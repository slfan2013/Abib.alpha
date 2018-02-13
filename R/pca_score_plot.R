pca_score_plot = function(project_ID = "a2_68410298_1515096409152",
                          folder_ID = "PCA_68410298_1515102142296",
                          data = ooo.out.scores,
                          PC_x="p1",
                          PC_y="p2",
                          use_color = TRUE,
                          color_group_name = "species",
                          color = "",
                          selected_colors=c("red","pink"),
                          use_label=T,
                          label,
                          label_group_name = "label",
                          use_ellipse=TRUE,
                          width=1000,
                          height=800,
                          size=25,
                          x_lab = "PC1",
                          y_lab = "PC2",
                          numeric_time = "1515096725933"
                          ){

  pacman::p_load(data.table, ggplot2, officer, dplyr, rvg)
  # data = fread("C:\\Users\\fansi\\Documents\\GitHub\\Abib.alpha\\inst\\www\\views\\multivariate_analysis\\data-score.csv")
  # p = fread("http://127.0.0.1:5985/abib/a2_68410298_1515096409152/sample_info_68410298_1515096409152.csv")
  # color = p[[color_group_name]]
  # label = p[[label_group_name]]

  data = data.table(data, color = color, label = label)
  dpi = 120
  plot = ggplot(data, aes_string(x=PC_x, y=PC_y))
  if(use_color){
    plot = plot + geom_point(size = size/dpi, shape  = 21, stroke = 2/dpi, color = "black")
    plot = plot + geom_point(aes_string(color="color"), size = size/dpi, alpha = 0.75) + scale_color_manual(values=selected_colors)
  }else{
    plot = plot + geom_point(aes_string(color="color"), size = size/dpi, alpha = 0.75, colour="black",pch=21)
  }
  if(use_label){
    plot = plot + geom_text(label=label, nudge_x = 0, nudge_y = diff(range(data[[PC_x]]))/40, family = "arial")
  }
  if(use_ellipse){
    plot = plot + stat_ellipse(aes_string(color="color"), alpha = 0.75)
  }
  # legend
  plot = plot + labs(color=color_group_name)
  # lab
  plot = plot + ggtitle("score plot")+
    labs(x = x_lab, y = y_lab) + theme_light(base_size  = 8)+
    theme(plot.title = element_text(hjust = 0.5))

  # save plot
  pptx = read_pptx()
  pptx = pptx %>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code = print(plot), type = "body", width = width/200, height = height/200, offx = 0, offy = 0) %>%
    print(target = "PCA-score-plot.pptx") %>% invisible()

  attname = put_attachment(project_ID = project_ID, numeric_time = numeric_time,
                                filename = "PCA-score-plot", suffix = ".pptx", content_type = "application/vnd.openxmlformats-officedocument.presentationml.presentation")

  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = T)
  sibling_text = projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == folder_ID]
  sibling_text = gsub("\\.pptx","",sibling_text)
  final_name = make.unique(c(sibling_text, "PCA-score-plot"), sep = "_")[length(c(sibling_text, "PCA-score-plot"))]

  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectList$tree_structure[[length(projectList$tree_structure) + 1]] = list(
    id = paste0("PCA-score-plot_68410298_",numeric_time,"_pptx"),
    parent = folder_ID,
    text = paste0(final_name,".pptx"),
    icon = "fa fa-file-powerpoint-o",
    source = list(
      FUNCTION=pca_score_plot,
      PARAMETER = list(
        project_ID = project_ID,
        folder_ID = folder_ID,
        data = data,
        PC_x=PC_x,
        PC_y=PC_y,
        use_color = use_color,
        color_group_name = color_group_name,
        color = color,
        selected_colors=selected_colors,
        use_label=use_label,
        label=label,
        label_group_name = label_group_name,
        use_ellipse=use_ellipse,
        width=width,
        height=height,
        size=size,
        x_lab = x_lab,
        y_lab = y_lab
      )
    ),
    attname = attname
  )
  result = RCurl::getURL(projectUrl, customrequest = "PUT",
                         httpheader = c(`Content-Type` = "application/json"),
                         postfields = jsonlite::toJSON(projectList, auto_unbox = T,
                                                       force = T))


  return(list(success= TRUE))



}
