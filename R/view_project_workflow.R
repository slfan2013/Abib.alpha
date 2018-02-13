view_project_workflow = function(project_ID = "a5_68410298_1515556206218"){

  pacman::p_load("data.table",  ropls, officer,dplyr, rvg, visNetwork)

  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  tree = projectList$tree_structure


  node = data.table(id = "root", label = "a7" ,title = "<p>project: a6</p>", color = "red", size = 20, font.size = 12)
  for(i in 2:length(tree)){

    title = paste0("<h2>",tree[[i]]$source$FUNCTION ,"</h2><br />")
    for(j in 1:length(tree[[i]]$source$PARAMETER)){
      title = paste0(title, "<p>", names(tree[[i]]$source$PARAMETER)[j],":",paste0(unlist(tree[[i]]$source$PARAMETER[[j]]),collapse = "; "),"</p>")
    }
    node = rbind(node, data.table(id=tree[[i]]$id, label = tree[[i]]$text, title=title, color = "lightblue", size = 20, font.size = 12))
  }


  edge = data.table(from = 1, to = 1, arrows = "to")
  for(i in 2:length(tree)){
    for(j in 1:length(tree[[i]]$source_node_id)){
      edge = rbind(edge, data.table(from = tree[[i]]$source_node_id[[j]], to = tree[[i]]$id, arrows = "to"))
    }
  }
  visNetwork(node, edge, width = "100%") %>%
    visOptions(highlightNearest = TRUE) %>%
    visLayout(randomSeed = 123)%>% visSave(file = "workflow.html", selfcontained = FALSE)


  return(list(success = TRUE))
}









