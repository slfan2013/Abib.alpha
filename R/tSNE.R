tSNE = function(project_ID = "test4_68410298_1510449038964",
               expression_id = "expression_data_68410298_1510449038964_csv",
               sample_info_id = "sample_info_68410298_1510449038964_csv",
               dims = 2,

               scale = TRUE,
               perplexity = 10,
               max_iter = 10000,

               color_by = "treatment",
               color_levels = c("MeOH-frz","ACN.IPA-frz","MeOH.CHCl3-frz","MeOH.CHCl3-lyph"),
               add_label = TRUE



){
  color_by_name = color_by

  pacman::p_load("data.table", Rtsne, RColorBrewer, plyr)

  # make _csv to .csv.
  expression_name = paste0(substring(expression_id, 1, nchar(expression_id)-4),".csv")
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
  # e = fread("e.csv")

  # read sample info
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  # p = fread("p.csv")




  if(color_by_name == "NO_68410298_COLOR"){
    color_by = NA
    included_label = p[['label']]
    compound_label = e$label
    e = e[, colnames(e) %in% included_label, with = F]
    e = data.matrix(e)
    for(i in 1:nrow(e)){
      e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
    }
  }else{
    # group (as factor)
    color_by = p[[color_by]]
    color_by = factor(color_by, levels = c(color_levels))
    # subsetting to get only two groups.
    included_label = p[['label']][!is.na(color_by)]
    compound_label = e$label
    sample_label = included_label
    e = e[, colnames(e) %in% included_label, with = F]

    e = data.matrix(e)
    for(i in 1:nrow(e)){
      e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
    }
    color_by = color_by[!is.na(color_by)]
  }


  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,!is.na(e[i,])])
  }
  e_t = t(e)

  colnames(e_t) = compound_label
  rownames(e_t) = sample_label

  color_option = RColorBrewer::brewer.pal(length(color_levels), "Set1")

  colors = mapvalues(color_by, from = levels(color_by), to = color_option)

  tsne <- Rtsne(e_t, dims = dims, perplexity=5, verbose=FALSE, max_iter = max_iter, pca_scale = scale)
  png("result.png", width = 800 * 1.5, height = 600 * 1.5)
  plot(tsne$Y, main="tsne", col = as.character(colors), xlab = "", ylab = "")
  legend("topleft", levels(color_by), col = color_option, pch = 1)
  if(add_label){
    text(tsne$Y, labels=color_by, col = color_option)
  }
  dev.off()

  scores = data.table(tsne$Y)
  rownames(scores) = sample_label
  colnames(scores) = c("V1","V2")
  fwrite(scores, "t-SNE-scores.csv")


  pptx = read_pptx()
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code =
    {
      plot(tsne$Y, main="tsne", col = colors, xlab = "", ylab = "")
      legend("topleft", levels(color_by), col = color_option, pch = 1)
      if(add_label){
        text(tsne$Y, labels=color_by, col = color_option)
      }
    }, type = "body", width = 8, height = 8, offx = 0, offy = 0)


  pptx %>% print(target = "t-SNE-plots.pptx") %>% invisible()






  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl)
  # numeric_time = as.integer(Sys.time())
  # change the tree structure.
  adding_to_tree_structure = data.frame(id = c(paste0("t-SNE_68410298_",numeric_time,""),
                                               paste0("t-SNE_plot_68410298_",numeric_time,"_pptx"),
                                               paste0("t-SNE_scores_68410298_",numeric_time,"_csv")
  ),
  parent = c(projectList$tree_structure$parent[projectList$tree_structure$id==expression_id],
             paste0("t-SNE_68410298_",numeric_time,""),paste0("t-SNE_68410298_",numeric_time,"")),
  text = c("t-SNE","t-SNE plot.pptx","t-SNE scores.csv"),
  icon = c("fa fa-folder","fa fa-file-powerpoint-o","fa fa-file-excel-o"),
  source = paste0("DATA_",expression_id,"_FUNCTION_pca_PARAMETERS_",project_ID,"_",expression_id,"_",sample_info_id, "_",dims,"_",scale,"_", perplexity,"_",max_iter,"_",color_by_name,"_",paste0(color_levels, collapse = "*"),"_END_"))
  projectList$tree_structure = rbind(projectList$tree_structure, adding_to_tree_structure)


  attname_folder = paste0("t-SNE_68410298_",numeric_time,"")
  # attach files.
  new_att = projectList[["_attachments"]]

  attname_score = paste0("t-SNE_scores_68410298_",numeric_time,".csv")
  new_att = new_att[!names(new_att)%in%attname_score]
  new_att[[attname_score]] = list(content_type="application/vnd.ms-excel", data = RCurl::base64Encode(readBin("t-SNE-scores.csv", "raw", file.info("t-SNE-scores.csv")[1, "size"]), "txt"))

  attname_plots = paste0("t-SNE_plot_68410298_",numeric_time,".pptx")
  new_att = new_att[!names(new_att)%in%attname_plots]
  new_att[[attname_plots]] = list(content_type="application/vnd.openxmlformats-officedocument.presentationml.presentation", data = RCurl::base64Encode(readBin("t-SNE-plots.pptx", "raw", file.info("t-SNE-plots.pptx")[1, "size"]), "txt"))




  projectList[["_attachments"]] = new_att
  result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))





  return(list(success = TRUE, attname_folder = attname_folder, attname_score = attname_score, attname_loading = attname_loading, attname_variance_explained = attname_variance_explained, attname_plots = attname_plots))


}









