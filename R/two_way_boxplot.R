two_way_boxplot = function(project_ID = "GC1_68410298_1513118066555",
                           expression_id = "data_transformation-log2_68410298_1513118073624_xlsx",
                           sample_info_id = "sample_info_68410298_1513118066555_csv",
                           group_name1 = "Time point", # this should be the repeated factor
                           group_name2 =  "treatment",
                           levels1 = c("1","2","3","4","5","6","7","8"),
                           levels2 = c("2 - Pneumonia","3 - Subclinical R. equi ","4 - Unchallenged "),
                           # sample_ID_name = 'Horse ID',

                           compound_name = "zymosterol",
                           # theme_name = "theme_classic",
                           axis_las = 1, # either vertocal to xaxis (1) or vertical to xaxis (2)

                           legend_position = "topright",

                           add_group_median = F,

                           jitter = F,
                           jitter_color = "black",

                           # width = 0.75,
                           # add_label = FALSE,
                           pallete_option = "Set1",
                           # adjust_x_axis_angle = FALSE,
                           auto_save = FALSE,
						   input_oriented_saving = TRUE,
						   quick_analysis=FALSE,
                           numeric_time = "1513118495582"


){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table",openxlsx, RColorBrewer, ggsci, ggplot2, ggpubr)

  # REPLACE # make _csv to .csv.!
  expression_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",expression_id))
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  if(grepl(".xlsx",expression_name)){
    e = read.xlsx(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)))
    # colnames(e) = gsub("\\."," ",colnames(e))
    e = data.table(e)
  }else{
    e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
    # e = fread("e.csv")
  }
  # read sample info
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  # p = fread("p.csv")
  # p = p[-c(1,2,3,4)]
  # group (as factor)
  group1 = p[[group_name1]]
  group1 = factor(group1, levels = c(levels1))

  group2 = p[[group_name2]]
  group2 = factor(group2, levels = c(levels2))

  # subsetting to get only two groups.
  index = !is.na(group1) & !is.na(group2)
  included_label = p[['label']][index]
  compound_label = e$label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }


  dta = data.table(group1, group2, value = e[compound_label%in%compound_name,])
  colnames(dta) = c(group_name1, group_name2, make.names(compound_name))
  colnames(dta) = make.names(colnames(dta))

  # pallete_option = c("grey",rownames(brewer.pal.info), "npg", "aaas", "lancet", "jco", "ucscgb", "uchicago", "simpsons", "rickandmorty")

  # if(add_label){
  #   label = p$label
  # }else{
  #   label = NULL
  # }
  #
  # selected_theme = get(theme_name)
  #
  #
  # dta2 = data.frame(rep(levels(factor(dta[[make.names(group_name1)]])),each = 3), rep(levels(factor(dta[[make.names(group_name2)]])),8), avg = as.numeric(by(dta$xylose, paste0(dta$Time.point, dta$treatment), FUN = mean)))
  # colnames(dta2) = make.names(c(group_name1, group_name2,colnames(dta)[3]))
  # class(dta2[,1]) = "numeric"; class(dta2[,2]) = "factor"
  # # for(i in 1:length(pallete_option)){
  # i = 1
  #   ggboxplot(dta, make.names(group_name1), make.names(compound_name), fill = make.names(group_name2), palette = pallete_option[i],
  #             title = compound_name,  notch = FALSE,
  #             add = ifelse(jitter, "jitter", "none"),
  #             add.params = list(color=jitter_color),
  #             label = label)  +
  #     geom_line(data = dta2, aes_string(x = make.names(group_name1), y = make.names(compound_name), color = make.names(group_name2))) +
  #     selected_theme() +
  #     theme(axis.text.x = element_text(angle = ifelse(adjust_x_axis_angle,30,0), hjust = 1))
  #   ggsave("result_68410298_two_way_boxplot.png", width = 800/150, height = 600/150, dpi = 150)
  #   # ggsave(paste0(pallete_option[i]," - small.png"), width = 6, height = 6, dpi=20)
  # # }




    png(paste0("result_68410298_two_way_boxplot.png"),width = 800, height = 600)
    dta = data.table(group1, group2, value = e[compound_label%in%compound_name,])
    # define where boxes shoule be placed.
    at.x = vector();m=1;
    for(i in 1:(length(levels1)*length(levels2)+length(levels1))){
       if(!(i%%(length(levels2)+1)==0)){
          at.x[m] = m
         }
       m=m+1
    };at.x = at.x[!is.na(at.x)]

    col = brewer.pal(length(levels2), pallete_option)
    names(col) = levels2

    boxplot(value~group2*group1,data = dta,notch=FALSE,xaxt="n", at = at.x, col = col, cex = .5)
    # add xaxis
    axis(1, at = mean(1:(length(levels2)+1))+c(0:(length(levels1)-1))*(length(levels2)+1),labels=levels1, las = axis_las)
    # add a main title and bottom and left axis labels
    title(compound_name, xlab=group_name1, ylab = "intensity")
    # add legend
    legend(legend_position, inset=.02, title=group_name2, levels2, fill=col, horiz=TRUE, cex=0.8)


    # add lines connecting medians
    if(add_group_median){
      dta2 = data.frame(avg = as.numeric(by(dta$value, paste0(dta$group1, dta$group2), median)), group1 = rep(levels1, each = length(levels2)), group2 = rep(levels2, length(levels1)))
      for(lv in levels2){
        lines(at.x[dta2$group2%in%lv],dta2[dta2$group2%in%lv,1], col = col[names(col)==lv], type = "l")
      }
    }

    if(jitter){
      jitters = by(dta, INDICES = data.frame(dta$group2, dta$group1), FUN = function(x) x)
      for(i in 1:length(jitters)){
        points(x = rep(at.x[i], length(jitters[[i]]$value)), y = jitters[[i]]$value, pch = 20, cex = .8, col = jitter_color)
      }
    }
    dev.off()


    return(TRUE)

}









