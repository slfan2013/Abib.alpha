volcano_plot = function(project_ID = "a1_68410298_1512518473875",
                  data_id = "merged_t test_fold change_1_68410298_1512518891_xlsx",
                  p_value_column_name = "p value: pumpkin vs tomatillo",
                  fold_change_column_name = "mean fold change: pumpkin / tomatillo",
                  p_value_threshold = 0.05,
                  fold_change_threshold = 2,
                  title = "volcano - plot",
                  auto_save = FALSE,
				          input_oriented_saving = TRUE,
                  quick_analysis=FALSE,
                  numeric_time = 1
){

  pacman::p_load("data.table", openxlsx, ggplot2,RColorBrewer, ggsci, ggpubr, officer,dplyr, rvg, htmlwidgets, plotly)

  # make _csv to .csv.
  data_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",data_id))

  # read data
  if(grepl(".xlsx",data_name)){
    data = read.xlsx(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",data_name)))
    colnames(data) = gsub("\\."," ",colnames(data))
  }else{
    data = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",data_name)),header=T)
  }



  log2_fold_change = log2(data[[fold_change_column_name]])
  negative_log10_p_value = -log10(data[[p_value_column_name]])

  data_plot = data.frame(label = data$label, log2_fold_change, negative_log10_p_value)


  col = rep("#FDFF00", length(log2_fold_change))
  col[log2_fold_change>log2(fold_change_threshold) & data[[p_value_column_name]] < p_value_threshold] = "#EB0000"
  col[log2_fold_change< -log2(fold_change_threshold) & data[[p_value_column_name]] < p_value_threshold] = "#257D00"
  cex = rep(3,  length(log2_fold_change))
  cex[log2_fold_change>log2(fold_change_threshold) & data[[p_value_column_name]] < p_value_threshold] = 5
  cex[log2_fold_change< -log2(fold_change_threshold) & data[[p_value_column_name]] < p_value_threshold] = 5
  data_plot$color = col
  p <- ggplot(data_plot, aes(log2_fold_change, negative_log10_p_value, label =  label))
  p = p + geom_point(aes(fill = col),shape = 21, size = cex) +
    scale_fill_manual(labels = c("decreaing","increasing","not selected"), values = c("#257D00", "#EB0000", "#FDFF00")) +
    xlab("log(2) Fold Change") +
    ylab("-log10 (p) ")+
    geom_vline(xintercept = c(-log2(fold_change_threshold),log2(fold_change_threshold)), linetype = "dashed") +
    geom_hline(yintercept = -log10(p_value_threshold), color = "red", linetype = "dashed")+
    ggtitle(label = title) +
    theme_bw()

  ggsave(paste0("result_68410298_volcano_plot.png"),plot = p, height = 2*600/300, width = 2*800/300, dpi = 300)
  plot_plotly = ggplotly(p = p)



  # save as pptx

  out = data_plot



  pptx = read_pptx()
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code = print(p), type = "body", width = 8*1.2, height = 6*1.2, offx = 0, offy = 0)



  # systematical.
  # determine the filename and upload attachment.
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)
  # sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == data_id]], "_68410298_"))
  sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == data_id],"root")], "_68410298_"))
  filename = make.unique(c(sibling_text,"volcano plot"),sep="_")[length(c(sibling_text,"volcano plot"))]
  # filename = "t test"
  # numeric_time = as.integer(Sys.time())

  pptx %>% print(target = paste0("volcano plot", ".pptx")) %>% invisible()
  attname_plot = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "volcano plot", suffix = ".pptx", content_type = "application/vnd.openxmlformats-officedocument.presentationml.presentation")
  fwrite(out, paste0("volcano plot", ".csv"))
  attname_data = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "volcano plot", suffix = ".csv", content_type = "application/vnd.ms-excel")
  saveWidget(plot_plotly, paste0("volcano plot",".html"), selfcontained = FALSE)
  attname_html = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "volcano plot", suffix = ".html", content_type = "text/html")




  report = paste0("# ",filename,"\n\n")

  report = paste0(report, "We further conducted volcano plot (**Figure** *",filename,"*) using _",strsplit(data_id,"_68410298_")[[1]][1],"_ dataset. On the condition that _",p_value_column_name,"_ < ",p_value_threshold, ", _",fold_change_column_name, "_ > ",fold_change_threshold," or < ",1/fold_change_threshold, ", ",sum(cex == max(cex, na.rm = T))," (",signif(sum(cex == max(cex, na.rm = T))/length(cex) * 100, 4), "%) compounds were retained in the volcano-plot. The red points means that the ",strsplit(strsplit(fold_change_column_name,": ")[[1]][2],"/ ")[[1]][1]," is greater than the ",strsplit(strsplit(fold_change_column_name,": ")[[1]][2],"/ ")[[1]][2],", _vice versa_.\n\n All files are saved in the _",filename,"_ folder. The graph coordinate is saved as _",filename,"\volcano plot.csv_, the editable graph is saved as _",filename,"\volcano plot.pptx_, and interactive plot is as _",filename,"\volcano plot.html_. \n\n")
  attname_png = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "result_68410298_volcano_plot", suffix = ".png", content_type = "image/png")

  # result_68410298_1512439818.png
  report = paste0(report, '![',filename,'](http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/',project_ID,'/result_68410298_volcano_plot_68410298_',numeric_time, '.png "',filename,'")')




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
      source = list(FUNCTION = "volcano_plot",PARAMETER = list(
        project_ID = project_ID,
        data_id = data_id,
        p_value_column_name = p_value_column_name,
        fold_change_column_name = fold_change_column_name,
        p_value_threshold = p_value_threshold,
        fold_change_threshold = fold_change_threshold,
        title = title
      )),
      source_node_id =data_id,
      report = report)
    # file. plot
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("volcano plot","_68410298_",numeric_time,"_pptx"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("volcano plot",".pptx"),
      icon = "fa fa-file-powerpoint-o",
      attname = attname_plot,
      source = list(FUNCTION = "volcano_plot",PARAMETER = list(
        project_ID = project_ID,
        data_id = data_id,
        p_value_column_name = p_value_column_name,
        fold_change_column_name = fold_change_column_name,
        p_value_threshold = p_value_threshold,
        fold_change_threshold = fold_change_threshold,
        title = title
      )),
      source_node_id =paste0(filename,"_68410298_",numeric_time,"")
    )
    # file. html
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("volcano plot","_68410298_",numeric_time,"_html"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("volcano plot",".html"),
      icon = "fa fa-file-image-o",
      attname = attname_html,
      source = list(FUNCTION = "volcano_plot",PARAMETER = list(
        project_ID = project_ID,
        data_id = data_id,
        p_value_column_name = p_value_column_name,
        fold_change_column_name = fold_change_column_name,
        p_value_threshold = p_value_threshold,
        fold_change_threshold = fold_change_threshold,
        title = title
      )),
      source_node_id =paste0(filename,"_68410298_",numeric_time,"")
    )
    # file. data
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("volcano plot","_68410298_",numeric_time,"_csv"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("volcano plot",".csv"),
      icon = "fa fa-file-excel-o",
      attname = attname_data,
      source = list(FUNCTION = "volcano_plot",PARAMETER = list(
        project_ID = project_ID,
        data_id = data_id,
        p_value_column_name = p_value_column_name,
        fold_change_column_name = fold_change_column_name,
        p_value_threshold = p_value_threshold,
        fold_change_threshold = fold_change_threshold,
        title = title
      )),
      source_node_id = paste0(filename,"_68410298_",numeric_time,""),
      column_name = colnames(out),
      column_length = sapply(out, function(x) length(unique(x)), simplify = F),
      column_class = sapply(out, function(x) class(x), simplify = F),
      column_value = sapply(out, function(x) unique(x), simplify = F)
    )

    result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))
    structure_to_be_added  = NA
  }else{
    structure_to_be_added = jsonlite::toJSON(list(
      list(
        id = paste0(filename,"_68410298_",numeric_time,""),
        ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root")),
        text = filename,
        icon = "fa fa-folder",
        source = list(FUNCTION = "volcano_plot",PARAMETER = list(
          project_ID = project_ID,
          data_id = data_id,
          p_value_column_name = p_value_column_name,
          fold_change_column_name = fold_change_column_name,
          p_value_threshold = p_value_threshold,
          fold_change_threshold = fold_change_threshold,
          title = title
        )),
        source_node_id =data_id,
        report = report),
      list(
        id = paste0("volcano plot","_68410298_",numeric_time,"_pptx"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("volcano plot",".pptx"),
        icon = "fa fa-file-powerpoint-o",
        attname = attname_plot,
        source = list(FUNCTION = "volcano_plot",PARAMETER = list(
          project_ID = project_ID,
          data_id = data_id,
          p_value_column_name = p_value_column_name,
          fold_change_column_name = fold_change_column_name,
          p_value_threshold = p_value_threshold,
          fold_change_threshold = fold_change_threshold,
          title = title
        )),
        source_node_id =paste0(filename,"_68410298_",numeric_time,"")
      ),
      list(
        id = paste0("volcano plot","_68410298_",numeric_time,"_html"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("volcano plot",".html"),
        icon = "fa fa-file-image-o",
        attname = attname_html,
        source = list(FUNCTION = "volcano_plot",PARAMETER = list(
          project_ID = project_ID,
          data_id = data_id,
          p_value_column_name = p_value_column_name,
          fold_change_column_name = fold_change_column_name,
          p_value_threshold = p_value_threshold,
          fold_change_threshold = fold_change_threshold,
          title = title
        )),
        source_node_id =paste0(filename,"_68410298_",numeric_time,"")
      ),
      list(
        id = paste0("volcano plot","_68410298_",numeric_time,"_csv"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("volcano plot",".csv"),
        icon = "fa fa-file-excel-o",
        attname = attname_data,
        source = list(FUNCTION = "volcano_plot",PARAMETER = list(
          project_ID = project_ID,
          data_id = data_id,
          p_value_column_name = p_value_column_name,
          fold_change_column_name = fold_change_column_name,
          p_value_threshold = p_value_threshold,
          fold_change_threshold = fold_change_threshold,
          title = title
        )),
        source_node_id = paste0(filename,"_68410298_",numeric_time,""),
        column_name = colnames(out),
        column_length = sapply(out, function(x) length(unique(x)), simplify = F),
        column_class = sapply(out, function(x) class(x), simplify = F),
        column_value = sapply(out, function(x) unique(x), simplify = F)
      )
    ), auto_unbox = T)
  }


  return(list(structure_to_be_added = structure_to_be_added, filename = filename))


}









