merging = function(
  project_ID = "a1_68410298_1511405611610",
  file1_id = "volcano plot_68410298_1511406038_csv",
  file2_id = "fold change_68410298_1511405981_xlsx",
  file1_text = "volcano plot.csv",
  file2_text = "fold change.xlsx",
  file1_column_name = "label",
  file2_column_name = "label",
  sort_by = FALSE,
  all_file1 = FALSE,
  all_file2 = FALSE,
  auto_save = FALSE,
  input_oriented_saving = TRUE,
  quick_analysis=FALSE,
  numeric_time = 1
){

  pacman::p_load("data.table", openxlsx)

  # make _csv to .csv OR _xlsx to .xlsx.
  file1_name = gsub("_csv",".csv",file1_id)
  file2_name = gsub("_csv",".csv",file2_id)
  file1_name = gsub("_xlsx",".xlsx",file1_name)
  file2_name = gsub("_xlsx",".xlsx",file2_name)

  file1_text = gsub(".csv","",file1_text)
  file2_text = gsub(".csv","",file2_text)
  file1_text = gsub(".xlsx","",file1_text)
  file2_text = gsub(".xlsx","",file2_text)

  # read the first file.
  if(grepl(".csv", file1_name)){
    file1 = fread(URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",file1_name)))
  }else if(grepl(".xlsx",file1_name)){
    file1 = openxlsx::read.xlsx(URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",file1_name)),check.names=FALSE)
    colnames(file1) = gsub("\\."," ",colnames(file1))
  }
  # read the second file.
  if(grepl(".csv", file2_name)){

    file2 = fread(URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",file2_name)))

  }else if(grepl(".xlsx",file2_name)){
    file2 = openxlsx::read.xlsx(URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",file2_name)),check.names=FALSE)
    colnames(file2) = gsub("\\."," ",colnames(file2))
  }

  # merge two files
  merged_data = merge(data.table(file1), data.table(file2), by.x = file1_column_name, by.y = file2_column_name, suffixes = c("_f1","_f2"),all.x = all_file1, all.y = all_file2, sort = sort_by)
  out = merged_data





  # systematical.
  # determine the filename and upload attachment.
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)
  sibling_text = gsub("\\.csv|\\.xlsx","",unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root"))], "_68410298_")))
  filename = make.unique(c(sibling_text,paste0("merged_",file1_text,"_",file2_text)),sep="_")[length(c(sibling_text,paste0("merged_",file1_text,"_",file2_text)))]
  # filename = "t test"
  # numeric_time = as.integer(Sys.time())


  if(grepl("\\.xlsx",file1_name)){
    # write xlsx
    wb <- createWorkbook()
    addWorksheet(wb, "result")
	colnames(out) = make.unique(colnames(out),sep = "_") # cannot have duplicated column name otherwise the next line will return error.
    writeDataTable(wb, "result", out, startRow = 1, startCol = 1)
    saveWorkbook(wb, paste0(filename,".xlsx"), TRUE)
    attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = filename, suffix = ".xlsx", content_type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  }else{
    fwrite(merged_data, paste0(filename,".csv"))
    attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = filename, suffix = ".csv", content_type = "application/vnd.ms-excel")
  }
if(auto_save){
  # update tree structure
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)

  # file.
  projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
    id = paste0(filename,"_68410298_",numeric_time,ifelse(grepl(".xlsx",attname),"_xlsx","_csv")),
    parent = ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root")),
    text = ifelse(grepl(".xlsx",attname),paste0(filename,".xlsx"),paste0(filename,".csv")),
    icon = "fa fa-file-excel-o",
    attname = attname,
    source = list(FUNCTION = "merge",PARAMETER = list(
      project_ID = project_ID,
      file1_id = file1_id,
      file2_id = file2_id,
      file1_text = file1_text,
      file2_text = file2_text,
      file1_column_name = file1_column_name,
      file2_column_name = file2_column_name,
      sort_by = sort_by,
      all_file1 = all_file1,
      all_file2 = all_file2
    )),
    source_node_id = c(file1_id, file2_id),
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
      id = paste0(filename,"_68410298_",numeric_time,ifelse(grepl(".xlsx",attname),"_xlsx","_csv")),
      parent = ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root")),
      text = ifelse(grepl(".xlsx",attname),paste0(filename,".xlsx"),paste0(filename,".csv")),
      icon = "fa fa-file-excel-o",
      attname = attname,
      source = list(FUNCTION = "merge",PARAMETER = list(
        project_ID = project_ID,
        file1_id = file1_id,
        file2_id = file2_id,
        file1_text = file1_text,
        file2_text = file2_text,
        file1_column_name = file1_column_name,
        file2_column_name = file2_column_name,
        sort_by = sort_by,
        all_file1 = all_file1,
        all_file2 = all_file2
      )),
      source_node_id = c(file1_id, file2_id),
      column_name = colnames(out),
      column_length = sapply(out, function(x) length(unique(x)), simplify = F),
      column_class = sapply(out, function(x) class(x), simplify = F),
      column_value = sapply(out, function(x) unique(x), simplify = F)
    )
  ), auto_unbox = T)
}



  return(list(out = out,structure_to_be_added = structure_to_be_added))



}









