two_way_boxplot_to_all = function(project_ID = "mx-351579-Macarena GC_68410298_1513122886549",
                           expression_id = "data_transformation-log2_68410298_1513122904309_xlsx",
                           sample_info_id = "sample_info_68410298_1513122886549_csv",
                           group_name1 = "Time point", # this should be the repeated factor
                           group_name2 =  "treatment",
                           levels1 = c("1","2","3","4","5","6","7","8"),
                           levels2 = c("2 - Pneumonia","3 - Subclinical R. equi ","4 - Unchallenged "),
                           # sample_ID_name = 'Horse ID',

                           # compound_name = "xylose",
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
                           auto_save = TRUE, # this should be TRUE because this function is supposed to call the task in the queue.
                           input_oriented_saving = TRUE,
                           quick_analysis=FALSE,
                           numeric_time = "1513128843270"


){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table",openxlsx, RColorBrewer, ggsci, ggplot2, ggpubr, officer,dplyr, rvg)

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






  dta = data.table(group1, group2, value = e[1,])
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

  # systematical.
  # determine the filename and upload attachment.
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)
  sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root"))], "_68410298_"))
  filename = make.unique(c(sibling_text,"two-way boxplots"),sep="_")[length(c(sibling_text,"two-way boxplots"))]
  # pptx %>% print(target = paste0(filename,".pptx")) %>% invisible()
  # dir.create(filename)

  # pptx = read_pptx()
  # NOTE. currently, the pptx will get slow after adding more slides. Issue reported here "https://github.com/davidgohel/officer/issues/92". So, I have to save boxplots as png and zip to user.
  compound_label_save = make.names(compound_label, unique = TRUE)
  # for(i in 1:length(pallete_option)){
  for(i in 1:nrow(e)){
    dta$value = e[i,]
    png(paste0(i,"th ",compound_label_save[i],".png"),width = 800, height = 600)
    # pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
      # ph_with_vg(code = {
        boxplot(value~group2*group1,data = dta,notch=FALSE,xaxt="n", at = at.x, col = col,  cex = .5)
        # add xaxis
        axis(1, at = mean(1:(length(levels2)+1))+c(0:(length(levels1)-1))*(length(levels2)+1),labels=levels1, las = axis_las)
        # add a main title and bottom and left axis labels
        title(compound_label[i], xlab=group_name1, ylab = "intensity")
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
      # }, type = "body", width = 8, height = 6, offx = 0, offy = 0)
    print(i)
  }

  zip("two-way boxplots.zip",files = paste0(1:nrow(e),"th ",compound_label_save,".png"))

  # put to database as attachment.
  attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "two-way boxplots", suffix = ".zip", content_type = "application/x-zip-compressed")

  report = paste0("# ",filename,"\n\nThe two-way boxplots of all compounds using _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset were provided in the _",filename,"/two-way boxplots.zip_. A basic description of a box in each of the group is following ![boxplot explanation](https://pro.arcgis.com/en/pro-app/help/analysis/geoprocessing/charts/GUID-0E2C3730-C535-40CD-8152-80D794A996A7-web.png 'boxplot explanation')")

  if(auto_save){
    # update tree structure
    projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
    projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
    projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)
    # folder
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0(filename,"_68410298_",numeric_time,""),
      parent = ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root")),
      text = filename,
      icon = "fa fa-folder",
      source = list(FUNCTION = "two_way_boxplot_to_all",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        # ADD PARAMETER HERE
        group_name1 = group_name1,
        group_name2 =  group_name2,
        levels1 = levels1,
        levels2 = levels2,
        axis_las = axis_las,
        legend_position = legend_position,
        add_group_median = add_group_median,
        jitter =jitter,
        jitter_color =jitter_color,
        pallete_option =pallete_option
      )),
      source_node_id = expression_id,
      report = report
    )
    # file.
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("two-way boxplots","_68410298_",numeric_time,"_zip"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("two-way boxplots",".zip"),
      icon = "fa fa-file-zip-o",
      attname = attname,
      source = list(FUNCTION = "two_way_boxplot_to_all",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        # ADD PARAMETER HERE
        group_name1 = group_name1,
        group_name2 =  group_name2,
        levels1 = levels1,
        levels2 = levels2,
        axis_las = axis_las,
        legend_position = legend_position,
        add_group_median = add_group_median,
        jitter =jitter,
        jitter_color =jitter_color,
        pallete_option =pallete_option
      )),
      source_node_id = paste0(filename,"_68410298_",numeric_time,""),
      column_name = c(),
      column_length = c(),
      column_class = c(),
      column_value = c()
    )

    result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))

    structure_to_be_added  = NA

  }else{

    structure_to_be_added = jsonlite::toJSON(list(
      list(
        id = paste0(filename,"_68410298_",numeric_time,""),
        parent = ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root")),
        text = filename,
        icon = "fa fa-folder",
        source = list(FUNCTION = "two_way_boxplot_to_all",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          # ADD PARAMETER HERE
          group_name1 = group_name1,
          group_name2 =  group_name2,
          levels1 = levels1,
          levels2 = levels2,
          axis_las = axis_las,
          legend_position = legend_position,
          add_group_median = add_group_median,
          jitter =jitter,
          jitter_color =jitter_color,
          pallete_option =pallete_option
        )),
        source_node_id = expression_id,
        report = report),
      list(
        id = paste0("two-way boxplots","_68410298_",numeric_time,"_xlsx"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("two-way boxplots",".pptx"),
        icon = "fa fa-file-powerpoint-o",
        attname = attname,
        source = list(FUNCTION = "two_way_boxplot_to_all",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          # ADD PARAMETER HERE
          group_name1 = group_name1,
          group_name2 =  group_name2,
          levels1 = levels1,
          levels2 = levels2,
          axis_las = axis_las,
          legend_position = legend_position,
          add_group_median = add_group_median,
          jitter =jitter,
          jitter_color =jitter_color,
          pallete_option =pallete_option
        )),
        source_node_id = paste0(filename,"_68410298_",numeric_time,""),
        column_name = colnames(out),
        column_length = sapply(out, function(x) length(unique(x)), simplify = F),
        column_class = sapply(out, function(x) class(x), simplify = F),
        column_value = sapply(out, function(x) unique(x), simplify = F)
      )
    ), auto_unbox = T)

  }
  return(list(out = NA,structure_to_be_added = structure_to_be_added))




}









