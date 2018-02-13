get_filename = function(project_ID, function_name = "t test", quick_analysis = F, input_oriented_saving = F){
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  # projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)

  sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root"))], "_68410298_"))

  filename = make.unique(c(sibling_text,function_name),sep="_")[length(c(sibling_text,function_name))]
  return(filename)
}

