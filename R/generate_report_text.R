generate_report_text = function(
  project_ID = "b3_68410298_1511823157888"
){

  pacman::p_load("data.table")

  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)

  tree = projectList$tree_structure


  edge = data.table(from = 1, to = 1, arrows = "to")
  for(i in 2:length(tree)){
    for(j in 1:length(tree[[i]]$source_node_id)){
      edge = rbind(edge, data.table(from = tree[[i]]$source_node_id[[j]], to = tree[[i]]$id, arrows = "to"))
    }
  }


  tree_ids = c()
  for(i in 1:length(tree)){
    tree_ids= c(tree_ids, tree[[i]]$id)
  }
  names(tree) = tree_ids


  report = ""
  for(i in unique(edge$from[-1])){
    print(i)
    print(tree[[i]]$report)
    if(!is.null(tree[[i]]$report)){
      report = paste0(report, "\n\n",tree[[i]]$report)
    }

  }

  return(report)


}
