download_folder_as_zip = function(
  project_id="mx-351579-Macarena GC_68410298_1513122886549",
  id = c("root", "expression_data_68410298_1513122886549_csv", "metabolite_info_68410298_1513122886549_csv", "sample_info_68410298_1513122886549_csv", "data_transformation-log2_68410298_1513122904309", "two-way mixed ANOVA_68410298_1513124894550", "Heatmap_68410298_1513125302543", "PCA_68410298_1513125421753", "PCA_1_68410298_1513125440765", "data_transformation-log2_68410298_1513122904309_xlsx", "two-way mixed ANOVA_68410298_1513124894550_xlsx", "Heatmap-sample_tree_cut_68410298_1513125302543_csv", "Heatmap-compound_tree_cut_68410298_1513125302543_csv", "Heatmap-heatmap_plot_68410298_1513125302543_png", "PCA-scores_68410298_1513125421753_csv", "PCA-loadings_68410298_1513125421753_csv", "PCA-variance_explained_68410298_1513125421753_csv", "PCA-plots_68410298_1513125421753_pptx", "PCA-scores_68410298_1513125440765_csv", "PCA-loadings_68410298_1513125440765_csv", "PCA-variance_explained_68410298_1513125440765_csv", "PCA-plots_68410298_1513125440765_pptx"),
  path = c("mx-351579-Macarena GC", "mx-351579-Macarena GC/expression_data.csv", "mx-351579-Macarena GC/metabolite_info.csv", "mx-351579-Macarena GC/sample_info.csv", "mx-351579-Macarena GC/data_transformation-log2", "mx-351579-Macarena GC/two-way mixed ANOVA", "mx-351579-Macarena GC/Heatmap", "mx-351579-Macarena GC/PCA", "mx-351579-Macarena GC/PCA_1", "mx-351579-Macarena GC/data_transformation-log2/data_transformation-log2.xlsx", "mx-351579-Macarena GC/two-way mixed ANOVA/two-way mixed ANOVA.xlsx", "mx-351579-Macarena GC/Heatmap/Heatmap-sample_tree_cut.csv", "mx-351579-Macarena GC/Heatmap/Heatmap-compound_tree_cut.csv", "mx-351579-Macarena GC/Heatmap/Heatmap-heatmap_plot.png", "mx-351579-Macarena GC/PCA/PCA-scores.csv", "mx-351579-Macarena GC/PCA/PCA-loadings.csv", "mx-351579-Macarena GC/PCA/PCA-variance_explained.csv", "mx-351579-Macarena GC/PCA/PCA-plots.pptx", "mx-351579-Macarena GC/PCA_1/PCA-scores.csv", "mx-351579-Macarena GC/PCA_1/PCA-loadings.csv", "mx-351579-Macarena GC/PCA_1/PCA-variance_explained.csv", "mx-351579-Macarena GC/PCA_1/PCA-plots.pptx")){


  downloadFileName = paste0(path[1],".zip")

  project = jsonlite::fromJSON(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_id)), simplifyVector = F)
  project_att = project[['_attachments']]
  project_att_name = names(project_att)
  project_tree_structure_id = sapply(project$tree_structure, function(x) x$id)
  project_tree_structure_attname = sapply(project$tree_structure, function(x) x$attname, simplify = F)
  names(project_tree_structure_attname) = project_tree_structure_id
  names(path) = id


  attname = project_tree_structure_attname[project_tree_structure_id%in%id]


  for(i in 1:length(id)){
    if(is.null(attname[[i]])){ # this means that the ith element is a folder.
      dir.create(path[names(attname)[i]],recursive = T, showWarnings  = F)
    }else{ # this means that the ith element is a file.
      download.file(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_id,"/",attname[i])),path[names(attname)[i]],mode = 'wb')
    }
  }

  zip(zipfile = downloadFileName, files = path[1])



  return(downloadFileName)


}









