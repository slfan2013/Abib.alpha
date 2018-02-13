heatmap = function(project_ID = "a1_68410298_1513106480995",
                   expression_id = "expression_data_68410298_1513106480995_csv",
                   sample_info_id = "sample_info_68410298_1513106480995_csv",
                   metabolite_info_id = "metabolite_info_68410298_1513106480995_csv",

                  color_palatte_name = "Set1",
                  scale = F,
                  cluster_rows =F,
                  cluster_cols = F,
                  clustering_distance_rows = "euclidean",
                  clustering_distance_cols = "euclidean",

                  clustering_method = "complete",
                  cutree_rows = 1,
                  cutree_cols = 1,
                  legend = FALSE,

                  annotation_row_name = "NO_68410298_COMPOUND_ANNOTATION",
                  annotation_col_name = c("treatment","Time point"),

                  annotation_legend = F,

                  show_rownames = F,
                  show_colnames = F,

                  main = "",
                  fontsize_row = 8,
                  fontsize_col = 8,

                  display_numbers = F,
                  number_color = "gray30",

                  fontsize = 5,
                  treeheight_row = 30,
                  treeheight_col = 30,


                  viewOpt = "overview",
                  pptx = FALSE,

                  auto_save = TRUE,
input_oriented_saving = TRUE,
                  quick_analysis=FALSE,
                  numeric_time = "1513106519159"
                  ){

  pacman::p_load("data.table",openxlsx  ,grid, RColorBrewer, scales, gtable, stats, grDevices, graphics, Cairo) # dependencies of pheatmap

  # make _csv to .csv.
  expression_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",expression_id))
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")
  metabolite_info_name = paste0(substring(metabolite_info_id, 1, nchar(metabolite_info_id)-4),".csv")

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
  # read compound info
  f = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",metabolite_info_name)),header=T,strip.white=F)
  # f = fread("f.csv")

  compound_label = e$label
  e = e[, -1, with = F]
  e = data.matrix(e)
  rownames(e) = compound_label
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }
  e[e==0] = 1

  source("https://raw.githubusercontent.com/slfan2013/source/master/pheatmap.R")# pheatmap


  # # Create test matrix
  # test = matrix(rnorm(200), 20, 10)
  # test[1:10, seq(1, 10, 2)] = test[1:10, seq(1, 10, 2)] + 3
  # test[11:20, seq(2, 10, 2)] = test[11:20, seq(2, 10, 2)] + 2
  # test[15:20, seq(2, 10, 2)] = test[15:20, seq(2, 10, 2)] + 4
  # colnames(test) = paste("Test", 1:10, sep = "")
  # rownames(test) = paste("Gene", 1:20, sep = "")
  # annotation_row = data.frame(
  #   GeneClass = factor(rep(c("Path1", "Path2", "Path3"), c(10, 4, 6)))
  # )
  # rownames(annotation_row) = paste("Gene", 1:20, sep = "")

  if(annotation_row_name[1] == "NO_68410298_COMPOUND_ANNOTATION"){
    annotation_row_name = NA
  }
  if(annotation_col_name[1] == "NO_68410298_SAMPLE_ANNOTATION"){
    annotation_col_name = NA
  }

  if(!is.na(annotation_col_name[1])){
    annotation_col = data.frame(p[,annotation_col_name, with = F])
    colnames(annotation_col) = annotation_col_name
    rownames(annotation_col) = colnames(e)
  }else{
    annotation_col = NA
  }
  if(!is.na(annotation_row_name[1])){
    annotation_row = data.frame(f[,annotation_row_name, with = F])
    colnames(annotation_row) = annotation_row_name
    rownames(annotation_row) = rownames(e)
  }else{
    annotation_row = NA
  }

  dpi = 150
  minW <- 630;
  myW <- ncol(e)*18 + 150;
  if(myW < minW){
    myW <- minW;
  }
  w <- round(myW/dpi,2);

  myH <- nrow(e)*18 + 150;
  h <- round(myH/dpi,2);


  if(viewOpt == "overview"){

      if(w > 9){
        w <- 9;
      }

    if(h > w){
      h <- w;
    }
  }

  Cairo(w, h, units = "in",file="result_68410298_heatmap.png",dpi = dpi, type="png", bg="white")
  heatmap_result = pheatmap(e, color = colorRampPalette(rev(brewer.pal(n = 7, name = color_palatte_name)))(100),
                     border_color = "gray60",
                     scale = ifelse(scale, "row", "none"),
                     cluster_rows = cluster_rows,
                     cluster_cols = cluster_cols,
                     clustering_distance_rows = clustering_distance_rows,
                     clustering_distance_cols = clustering_distance_cols,
                     clustering_method = clustering_method,
                     cutree_rows  = cutree_rows,
                     cutree_cols = cutree_cols,
                     legend = legend,
                     annotation_row = annotation_row,
                     annotation_col = annotation_col,
                     annotation_legend = annotation_legend,
                     show_rownames = show_rownames,
                     show_colnames = show_colnames,
                     main = main,
                     fontsize_row = fontsize_row,
                     fontsize_col = fontsize_col,
                     display_numbers = display_numbers,
                     number_color =number_color,
                     treeheight_row = treeheight_row,
                     treeheight_col = treeheight_col,
                     fontsize = fontsize
                     )
  dev.off()


  # the tree cut of samples
  sample_tree_cut = data.table(label = p$label, sample_cluster = ifelse(cluster_cols,cutree(heatmap_result$tree_col, k = cutree_cols),NA))
  if(!is.na(annotation_col_name[1])){
    sample_tree_cut = data.table(sample_tree_cut, annotation_col)
  }
  fwrite(sample_tree_cut,"Heatmap-sample_tree_cut.csv")
  compound_tree_cut = data.table(label = compound_label, compound_cluster =  ifelse(cluster_rows,cutree(heatmap_result$tree_row, k = cutree_rows),NA))
  if(!is.na(annotation_row_name[1])){
    compound_tree_cut = data.table(compound_tree_cut, annotation_row)
  }
  fwrite(compound_tree_cut,"Heatmap-compound_tree_cut.csv")


  if(pptx){
    pptx = read_pptx()
    pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
      ph_with_vg(code =
      {
        pheatmap(e, color = colorRampPalette(rev(brewer.pal(n = 7, name = color_palatte_name)))(100),
                 border_color = "gray60",
                 scale = ifelse(scale, "row", "none"),
                 cluster_rows = cluster_rows,
                 cluster_cols = cluster_cols,
                 clustering_distance_rows = clustering_distance_rows,
                 clustering_distance_cols = clustering_distance_cols,
                 clustering_method = clustering_method,
                 cutree_rows  = cutree_rows,
                 cutree_cols = cutree_cols,
                 legend = legend,
                 annotation_row = annotation_row,
                 annotation_col = annotation_col,
                 annotation_legend = annotation_legend,
                 show_rownames = show_rownames,
                 show_colnames = show_colnames,
                 main = main,
                 fontsize_row = fontsize_row,
                 fontsize_col = fontsize_col,
                 display_numbers = display_numbers,
                 number_color =number_color,
                 treeheight_row = treeheight_row,
                 treeheight_col = treeheight_col,
                 fontsize = fontsize
        )
      }, type = "body", width = 8, height = 6, offx = 0, offy = 0)


    pptx %>% print(target = "Heatmap-heatmap_plot.pptx") %>% invisible()
  }else{
    Cairo(w, h, units = "in",file="Heatmap-heatmap_plot.png",dpi = dpi, type="png", bg="white")
    heatmap_result = pheatmap(e, color = colorRampPalette(rev(brewer.pal(n = 7, name = color_palatte_name)))(100),
                              border_color = "gray60",
                              scale = ifelse(scale, "row", "none"),
                              cluster_rows = cluster_rows,
                              cluster_cols = cluster_cols,
                              clustering_distance_rows = clustering_distance_rows,
                              clustering_distance_cols = clustering_distance_cols,
                              clustering_method = clustering_method,
                              cutree_rows  = cutree_rows,
                              cutree_cols = cutree_cols,
                              legend = legend,
                              annotation_row = annotation_row,
                              annotation_col = annotation_col,
                              annotation_legend = annotation_legend,
                              show_rownames = show_rownames,
                              show_colnames = show_colnames,
                              main = main,
                              fontsize_row = fontsize_row,
                              fontsize_col = fontsize_col,
                              display_numbers = display_numbers,
                              number_color =number_color,
                              treeheight_row = treeheight_row,
                              treeheight_col = treeheight_col,
                              fontsize = fontsize
    )
    dev.off()
  }





  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = T)
  # numeric_time = as.integer(Sys.time())
  sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root"))], "_68410298_"))
  filename = make.unique(c(sibling_text,"Heatmap"),sep="_")[length(c(sibling_text,"Heatmap"))]

  if(pptx){
    attname_html = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "Heatmap-heatmap_plot", suffix = ".pptx", content_type = "application/vnd.openxmlformats-officedocument.presentationml.presentation")
  }else{
    attname_html = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "Heatmap-heatmap_plot", suffix = ".png", content_type = "image/png")
  }

  attname_png = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "result_68410298_heatmap", suffix = ".png", content_type = "image/png")
  attname_html = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "Heatmap-sample_tree_cut", suffix = ".csv", content_type = "application/vnd.ms-excel")
  attname_html = put_attachment(project_ID =project_ID,numeric_time =  numeric_time, filename = "Heatmap-compound_tree_cut", suffix = ".csv", content_type = "application/vnd.ms-excel")


  report = paste0("# Heatmap and Hierarchical Clustering (",filename,")\n\n")

  report = paste0(report, "We used heatmap ",ifelse(sum(c(cluster_rows,cluster_cols))>0,paste0("with hierarchical clustering analysis (HCA) on ",ifelse(cluster_rows,"compounds and ",""), ifelse(cluster_rows,"samples","")),"")," _(Figure ",filename,")_ to depict the metabolism state using the data of _",strsplit(expression_id,"_68410298_")[[1]][1],"_. The analysis result was saved in the folder of _",filename,"_.")
  if(scale){
    report = paste0(report, "Each variable was auto-scaled before the analysis. ")
  }

  if(sum(c(cluster_rows,cluster_cols))>0){
    report = paste0(report, "We used _",ifelse(cluster_rows,clustering_distance_rows,clustering_distance_cols),"_ as the distance measure and ",clustering_method," as the agglomeration method. ")
  }

  if(is.na(annotation_row_name[1])){
    report = paste0(report, "The annotation of compounds _(",paste0(annotation_row_name,collapse = ", "),")_ was added to the left of the heatmap. ")
  }
  if(is.na(annotation_col_name[1])){
    report = paste0(report, ifelse(!is.na(annotation_row_name[1]),"And t","T"),"he annotation of samples _(",paste0(annotation_col_name,collapse = ", "),")_ was added to the right of the heatmap.")
  }

  if(cutree_rows>1 && cutree_cols>1){
    report = paste0(report, "We further cut the clustering tree of variables into ",cutree_rows," clusters and the result was saved in the _",filename,"/Heatmap-compound_tree_cut.csv_, while the tree cut of samples (",cutree_cols," clusters) was saved in the _",filename,"/Heatmap-sample_tree_cut.csv_.")
  }else if(cutree_rows>1){
    report = paste0(report, "We further cut the clustering tree of variables into ",cutree_rows," clusters and the result was saved in the _",filename,"/Heatmap-compound_tree_cut.csv_.")
  }else if(cutree_cols>1){
    report = paste0(report, "We further cut the clustering tree of samples into ",cutree_rows," clusters and the result was saved in the _",filename,"/Heatmap-sample_tree_cut.csv_.")
  }

  report = paste0(report, '\n\n ![',filename,'](http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/',project_ID,'/result_68410298_heatmap_68410298_',numeric_time, '.png "',filename,'")')






  # projectList[["_attachments"]] = new_att
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
      source = list(FUNCTION = "heatmap",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        metabolite_info_id = metabolite_info_id,

        color_palatte_name = color_palatte_name,
        scale = scale,
        cluster_rows = cluster_rows,
        cluster_cols = cluster_cols,
        clustering_distance_rows = clustering_distance_rows,
        clustering_distance_cols = clustering_distance_cols,

        clustering_method = clustering_method,
        cutree_rows = cutree_rows,
        cutree_cols = cutree_cols,
        legend = legend,

        annotation_row_name = annotation_row_name,
        annotation_col_name = annotation_col_name,

        annotation_legend = annotation_legend,

        show_rownames = show_rownames,
        show_colnames = show_colnames,

        main = main,
        fontsize_row = fontsize_row,
        fontsize_col = fontsize_col,

        display_numbers = display_numbers,
        number_color = number_color,

        fontsize = fontsize,
        treeheight_row = treeheight_row,
        treeheight_col = treeheight_col

      )),
      source_node_id = expression_id,
      report = report
    )

    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("Heatmap","-sample_tree_cut_68410298_",numeric_time,"_csv"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("Heatmap","-sample_tree_cut.csv"),
      icon = "fa fa-file-excel-o",
      source = list(FUNCTION = "heatmap",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        metabolite_info_id = metabolite_info_id,

        color_palatte_name = color_palatte_name,
        scale = scale,
        cluster_rows = cluster_rows,
        cluster_cols = cluster_cols,
        clustering_distance_rows = clustering_distance_rows,
        clustering_distance_cols = clustering_distance_cols,

        clustering_method = clustering_method,
        cutree_rows = cutree_rows,
        cutree_cols = cutree_cols,
        legend = legend,

        annotation_row_name = annotation_row_name,
        annotation_col_name = annotation_col_name,

        annotation_legend = annotation_legend,

        show_rownames = show_rownames,
        show_colnames = show_colnames,

        main = main,
        fontsize_row = fontsize_row,
        fontsize_col = fontsize_col,

        display_numbers = display_numbers,
        number_color = number_color,

        fontsize = fontsize,
        treeheight_row = treeheight_row,
        treeheight_col = treeheight_col

      )),
      source_node_id = paste0(filename,"_68410298_",numeric_time,""),
      attname = paste0("Heatmap","-sample_tree_cut_68410298_",numeric_time,".csv"),
      column_name = colnames(sample_tree_cut),
      column_length = sapply(sample_tree_cut, length, simplify = FALSE),
      column_class = sapply(sample_tree_cut, class, simplify = FALSE),
      column_value = sapply(sample_tree_cut, unique , simplify = FALSE)
    )

    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("Heatmap","-compound_tree_cut_68410298_",numeric_time,"_csv"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("Heatmap","-compound_tree_cut.csv"),
      icon = "fa fa-file-excel-o",
      source = list(FUNCTION = "heatmap",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        metabolite_info_id = metabolite_info_id,

        color_palatte_name = color_palatte_name,
        scale = scale,
        cluster_rows = cluster_rows,
        cluster_cols = cluster_cols,
        clustering_distance_rows = clustering_distance_rows,
        clustering_distance_cols = clustering_distance_cols,

        clustering_method = clustering_method,
        cutree_rows = cutree_rows,
        cutree_cols = cutree_cols,
        legend = legend,

        annotation_row_name = annotation_row_name,
        annotation_col_name = annotation_col_name,

        annotation_legend = annotation_legend,

        show_rownames = show_rownames,
        show_colnames = show_colnames,

        main = main,
        fontsize_row = fontsize_row,
        fontsize_col = fontsize_col,

        display_numbers = display_numbers,
        number_color = number_color,

        fontsize = fontsize,
        treeheight_row = treeheight_row,
        treeheight_col = treeheight_col

      )),
      source_node_id = paste0(filename,"_68410298_",numeric_time,""),
      attname = paste0("Heatmap","-compound_tree_cut_68410298_",numeric_time,".csv"),
      column_name = colnames(compound_tree_cut),
      column_length = sapply(compound_tree_cut, length, simplify = FALSE),
      column_class = sapply(compound_tree_cut, class, simplify = FALSE),
      column_value = sapply(compound_tree_cut, unique , simplify = FALSE)
    )

    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("Heatmap","-heatmap_plot_68410298_",numeric_time,ifelse(pptx,"_pptx","_png")),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = ifelse(pptx,paste0("Heatmap","-heatmap_plot.pptx"), paste0("Heatmap","-heatmap_plot.png")),
      icon = ifelse(pptx,"fa fa-file-powerpoint-o","fa fa-file-picture-o"),
      source = list(FUNCTION = "heatmap",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        metabolite_info_id = metabolite_info_id,

        color_palatte_name = color_palatte_name,
        scale = scale,
        cluster_rows = cluster_rows,
        cluster_cols = cluster_cols,
        clustering_distance_rows = clustering_distance_rows,
        clustering_distance_cols = clustering_distance_cols,

        clustering_method = clustering_method,
        cutree_rows = cutree_rows,
        cutree_cols = cutree_cols,
        legend = legend,

        annotation_row_name = annotation_row_name,
        annotation_col_name = annotation_col_name,

        annotation_legend = annotation_legend,

        show_rownames = show_rownames,
        show_colnames = show_colnames,

        main = main,
        fontsize_row = fontsize_row,
        fontsize_col = fontsize_col,

        display_numbers = display_numbers,
        number_color = number_color,

        fontsize = fontsize,
        treeheight_row = treeheight_row,
        treeheight_col = treeheight_col

      )),
      source_node_id = paste0(filename,"_68410298_",numeric_time,""),
      attname = paste0("Heatmap","-heatmap_plot_68410298_",numeric_time,ifelse(pptx,".pptx",".png"))
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
        source = list(FUNCTION = "heatmap",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          metabolite_info_id = metabolite_info_id,

          color_palatte_name = color_palatte_name,
          scale = scale,
          cluster_rows = cluster_rows,
          cluster_cols = cluster_cols,
          clustering_distance_rows = clustering_distance_rows,
          clustering_distance_cols = clustering_distance_cols,

          clustering_method = clustering_method,
          cutree_rows = cutree_rows,
          cutree_cols = cutree_cols,
          legend = legend,

          annotation_row_name = annotation_row_name,
          annotation_col_name = annotation_col_name,

          annotation_legend = annotation_legend,

          show_rownames = show_rownames,
          show_colnames = show_colnames,

          main = main,
          fontsize_row = fontsize_row,
          fontsize_col = fontsize_col,

          display_numbers = display_numbers,
          number_color = number_color,

          fontsize = fontsize,
          treeheight_row = treeheight_row,
          treeheight_col = treeheight_col

        )),
        source_node_id = expression_id,
        report = report
      ),
      list(
        id = paste0("Heatmap","-sample_tree_cut_68410298_",numeric_time,"_csv"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("Heatmap","-sample_tree_cut.csv"),
        icon = "fa fa-file-excel-o",
        source = list(FUNCTION = "heatmap",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          metabolite_info_id = metabolite_info_id,

          color_palatte_name = color_palatte_name,
          scale = scale,
          cluster_rows = cluster_rows,
          cluster_cols = cluster_cols,
          clustering_distance_rows = clustering_distance_rows,
          clustering_distance_cols = clustering_distance_cols,

          clustering_method = clustering_method,
          cutree_rows = cutree_rows,
          cutree_cols = cutree_cols,
          legend = legend,

          annotation_row_name = annotation_row_name,
          annotation_col_name = annotation_col_name,

          annotation_legend = annotation_legend,

          show_rownames = show_rownames,
          show_colnames = show_colnames,

          main = main,
          fontsize_row = fontsize_row,
          fontsize_col = fontsize_col,

          display_numbers = display_numbers,
          number_color = number_color,

          fontsize = fontsize,
          treeheight_row = treeheight_row,
          treeheight_col = treeheight_col

        )),
        source_node_id = paste0(filename,"_68410298_",numeric_time,""),
        attname = paste0("Heatmap","-sample_tree_cut_68410298_",numeric_time,".csv"),
        column_name = colnames(sample_tree_cut),
        column_length = sapply(sample_tree_cut, length, simplify = FALSE),
        column_class = sapply(sample_tree_cut, class, simplify = FALSE),
        column_value = sapply(sample_tree_cut, unique , simplify = FALSE)
      ),
      list(
        id = paste0("Heatmap","-compound_tree_cut_68410298_",numeric_time,"_csv"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("Heatmap","-compound_tree_cut.csv"),
        icon = "fa fa-file-excel-o",
        source = list(FUNCTION = "heatmap",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          metabolite_info_id = metabolite_info_id,

          color_palatte_name = color_palatte_name,
          scale = scale,
          cluster_rows = cluster_rows,
          cluster_cols = cluster_cols,
          clustering_distance_rows = clustering_distance_rows,
          clustering_distance_cols = clustering_distance_cols,

          clustering_method = clustering_method,
          cutree_rows = cutree_rows,
          cutree_cols = cutree_cols,
          legend = legend,

          annotation_row_name = annotation_row_name,
          annotation_col_name = annotation_col_name,

          annotation_legend = annotation_legend,

          show_rownames = show_rownames,
          show_colnames = show_colnames,

          main = main,
          fontsize_row = fontsize_row,
          fontsize_col = fontsize_col,

          display_numbers = display_numbers,
          number_color = number_color,

          fontsize = fontsize,
          treeheight_row = treeheight_row,
          treeheight_col = treeheight_col

        )),
        source_node_id = paste0(filename,"_68410298_",numeric_time,""),
        attname = paste0("Heatmap","-compound_tree_cut_68410298_",numeric_time,".csv"),
        column_name = colnames(compound_tree_cut),
        column_length = sapply(compound_tree_cut, length, simplify = FALSE),
        column_class = sapply(compound_tree_cut, class, simplify = FALSE),
        column_value = sapply(compound_tree_cut, unique , simplify = FALSE)
      ),
      list(
        id = paste0("Heatmap","-heatmap_plot_68410298_",numeric_time,ifelse(pptx,"_pptx","_png")),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = ifelse(pptx,paste0("Heatmap","-heatmap_plot.pptx"), paste0("Heatmap","-heatmap_plot.png")),
        icon = ifelse(pptx,"fa fa-file-powerpoint-o","fa fa-file-picture-o"),
        source = list(FUNCTION = "heatmap",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          metabolite_info_id = metabolite_info_id,

          color_palatte_name = color_palatte_name,
          scale = scale,
          cluster_rows = cluster_rows,
          cluster_cols = cluster_cols,
          clustering_distance_rows = clustering_distance_rows,
          clustering_distance_cols = clustering_distance_cols,

          clustering_method = clustering_method,
          cutree_rows = cutree_rows,
          cutree_cols = cutree_cols,
          legend = legend,

          annotation_row_name = annotation_row_name,
          annotation_col_name = annotation_col_name,

          annotation_legend = annotation_legend,

          show_rownames = show_rownames,
          show_colnames = show_colnames,

          main = main,
          fontsize_row = fontsize_row,
          fontsize_col = fontsize_col,

          display_numbers = display_numbers,
          number_color = number_color,

          fontsize = fontsize,
          treeheight_row = treeheight_row,
          treeheight_col = treeheight_col

        )),
        source_node_id = paste0(filename,"_68410298_",numeric_time,""),
        attname = paste0("Heatmap","-heatmap_plot_68410298_",numeric_time,ifelse(pptx,".pptx",".png"))
      )
    ), auto_unbox = T)
  }


  return(list(structure_to_be_added = structure_to_be_added))


}









