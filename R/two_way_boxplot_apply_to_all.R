two_way_boxplot_apply_to_all = function(project_ID = "test4_68410298_1509856716246",
                           expression_id = "expression_data_68410298_1509856716246_csv",
                           sample_info_id = "sample_info_68410298_1509856716246_csv",
                           group_name1 = "treatment", # this should be the repeated factor
                           group_name2 =  "species",
                           levels1 = c("ACN.IPA-frz", "MeOH-frz", "MeOH.CHCl3-frz", "MeOH.CHCl3-lyph"),
                           levels2 = c("pumpkin", "tomatillo"),
                           theme_name = "theme_classic",
                           jitter = F,
                           jitter_color = "red",
                           width = 0.75,
                           add_label = FALSE,
                           pallete_option = "Set1",
                           adjust_x_axis_angle = FALSE


){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table",RColorBrewer, ggsci, ggplot2, ggpubr, officer,dplyr, rvg)

  # make _csv to .csv.
  expression_name = paste0(substring(expression_id, 1, nchar(expression_id)-4),".csv")
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
  # e = fread("e.csv")
  # e = e[,-c(1,2,3,4)]
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
  compound_label = make.unique(compound_label)
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)



  # pallete_option = c("grey",rownames(brewer.pal.info), "npg", "aaas", "lancet", "jco", "ucscgb", "uchicago", "simpsons", "rickandmorty")

  if(add_label){
    label = p$label
  }else{
    label = NULL
  }

  selected_theme = get(theme_name)


  pptx = read_pptx()

  # for(i in 1:length(pallete_option)){
  for(i in 1:nrow(e[1:5,])){
    compound_name = compound_label[i]
    dta = data.table(group1, group2, value = e[compound_label%in%compound_name,])
    colnames(dta) = c(group_name1, group_name2, make.names(compound_name))

    plot = ggboxplot(dta, group_name1, make.names(compound_name), fill = group_name2, palette = pallete_option,
              title = compound_name,  notch = FALSE,
              add = ifelse(jitter, "jitter", "none"),
              add.params = list(color=jitter_color),
              label = label) +  selected_theme()+ theme(axis.text.x = element_text(angle = ifelse(adjust_x_axis_angle,30,0), hjust = 1))
    # ggsave(paste0(i,"th - ",make.names(compound_label[i]),".png"), width = 800/150, height = 600/150, dpi = 150)
    pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
      ph_with_vg(code = print(plot), type = "body", width = 8, height = 6, offx = 0, offy = 0)
  }

  pptx %>% print(target = "two-way boxplots.pptx") %>% invisible()


  put_attachment(project_ID =project_ID, filename = "two-way boxplots", suffix = ".pptx", content_type = "application/vnd.openxmlformats-officedocument.presentationml.presentation")

  # projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  # projectList <- jsonlite::fromJSON(projectUrl)
  #
  # # numeric_time = as.integer(Sys.time())
  # attname = paste0("two-way boxplots_68410298_",numeric_time,".pptx")
  # new_att = projectList[["_attachments"]]
  # new_att = new_att[!names(new_att)%in%attname]
  # new_att[[attname]] = list(content_type="application/vnd.openxmlformats-officedocument.presentationml.presentation", data = RCurl::base64Encode(readBin("two-way boxplots.pptx", "raw", file.info("two-way boxplots.pptx")[1, "size"]), "txt"))
  # projectList[["_attachments"]] = new_att
  # result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))

  return(attname)


  # ggsave(paste0(pallete_option[i]," - small.png"), width = 6, height = 6, dpi=20)
  # }

}









