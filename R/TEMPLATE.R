TEMPLATE = function(project_ID = "a8_68410298_1511836861511",
                  expression_id = "data_transformation-log2_68410298_1511838284_xlsx",
                  sample_info_id = "sample_info_68410298_1511836861511_csv"

                  # parameters

){
  # REPLACE # make _csv to .csv.!
  expression_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",expression_id))

  # REPLACE read data!
  if(grepl(".xlsx",expression_name)){
    e = read.xlsx(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)))
    # colnames(e) = gsub("\\."," ",colnames(e))
    e = data.table(e)
  }else{
    e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
    # e = fread("e.csv")
  }

  # some functions
  # =====================================================================================================================



  # COPY FROM HERE!!
  out = data.table(label = compound_label, core)



  report = "MODULE_NAME\n============\nthis is a paragraph"


  # systematical.
  # determine the filename and upload attachment.
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)
  sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root"))], "_68410298_"))
  filename = make.unique(c(sibling_text,"MODULE_NAME"),sep="_")[length(c(sibling_text,"MODULE_NAME"))]
  # filename = "MODULE_NAME"
  # numeric_time = as.integer(Sys.time())

  # write xlsx
  wb <- createWorkbook()
  addWorksheet(wb, "result")
  # addWorksheet(wb, "report")


  significantStyle <- createStyle(fontColour = "#9C0006")
  number_format = createStyle(numFmt = "0.000")
  colnames(out) = make.unique(colnames(out),sep = "_") # cannot have duplicated column name otherwise the next line will return error.
  writeDataTable(wb, "result", out, startRow = 1, startCol = 1, tableStyle = "TableStyleLight9")
  conditionalFormatting(wb, 1, cols=which(grepl("p_value", colnames(out))|grepl("p value:", colnames(out))), rows=2:(nrow(out)+1), rule="<0.05", style = significantStyle)
  addStyle(wb,"result",cols=2:4, rows = which(!(grepl("p_value", colnames(out))|grepl("p value:", colnames(out))))[-1], style = number_format, gridExpand = T)
  # conditionalFormatting(wb, "result", cols = 2, rows = 2:(nrow(out)+1), type = "colourScale", style = c("#F8696B", "#FFEB84","#63BE7B"))
  saveWorkbook(wb, paste0("MODULE_NAME",".xlsx"), TRUE)
  # fwrite(out, paste0(filename,".csv"))



  attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "MODULE_NAME", suffix = ".xlsx", content_type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")




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
      source = list(FUNCTION = "MODULE_FUNCTION_NAME",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        # ADD PARAMETER HERE
      )),
      source_node_id = expression_id,
      report = report
    )
    # file.
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("MODULE_NAME","_68410298_",numeric_time,"_xlsx"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("MODULE_NAME",".xlsx"),
      icon = "fa fa-file-excel-o",
      attname = attname,
      source = list(FUNCTION = "MODULE_FUNCTION_NAME",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        # ADD PARAMETER HERE
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
        parent = ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root")),
        text = filename,
        icon = "fa fa-folder",
        source = list(FUNCTION = "MODULE_FUNCTION_NAME",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          # ADD PARAMETER HERE
        )),
        source_node_id = expression_id,
        report = report),
      list(
        id = paste0("MODULE_NAME","_68410298_",numeric_time,"_xlsx"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("MODULE_NAME",".xlsx"),
        icon = "fa fa-file-excel-o",
        attname = attname,
        source = list(FUNCTION = "MODULE_FUNCTION_NAME",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          # ADD PARAMETER HERE
        )),
        source_node_id = paste0(filename,"_68410298_",numeric_time,""),
        column_name = colnames(out),
        column_length = sapply(out, function(x) length(unique(x)), simplify = F),
        column_class = sapply(out, function(x) class(x), simplify = F),
        column_value = sapply(out, function(x) unique(x), simplify = F)
      )
    ), auto_unbox = T)

  }
  return(list(out = out,structure_to_be_added = structure_to_be_added))



}









