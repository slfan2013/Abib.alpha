nonparametric_two_way_repeated_anova = function(project_ID = "t test_68410298_1508863368603",
                                  expression_id = "expression_data_68410298_1508863368603_csv",
                                  sample_info_id = "sample_info_68410298_1508863368603_csv",
                                  group_name1 = "treatment", # this should be the repeated factor
                                  group_name2 =  "species", # this should be the repeated factor
                                  levels1 = c("ACN.IPA-frz", "MeOH-frz", "MeOH.CHCl3-frz", "MeOH.CHCl3-lyph"),
                                  levels2 = c("pumpkin", "tomatillo"),
                                  sample_ID_name = 'id',
                                  post_hoc_test_type = "pairwise_nonparametric_paired_t_test_with_fdr",
                                  auto_save = FALSE,
								  input_oriented_saving = TRUE,
								  quick_analysis=FALSE,
                                  numeric_time = 1
){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table", openxlsx)

  # make _csv to .csv.
  expression_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",expression_id))
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

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
  # p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  p = fread("p.csv")
  # p = p[-c(1,2,3,4)]
  # group (as factor)
  group1 = p[[group_name1]]
  group1 = factor(group1, levels = c(levels1))

  group2 = p[[group_name2]]
  group2 = factor(group2, levels = c(levels2))

  # subsetting to get only two groups.
  index = !is.na(group1) & !is.na(group2)
  included_label = p[['label']][index]
  compound_label = e$label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }

  group1 = group1[index]
  group2 = group2[index]

  id_index = factor(p[[sample_ID_name]])
  # id_index = factor(rep(1:6, 8))
  core = nonparametric_two_way_repeated_anova_core(e,group1, group2,levels1, levels2,id_index,
                                     main_effect_post_hoc_test_type = post_hoc_test_type,
                                     simplemain_effect_post_hoc_test_type = post_hoc_test_type)

  out = data.table(label = compound_label, core)



  report = "nonparametric two way repeated ANOVA\n============\nthis is a paragraph"


  # systematical.
  # determine the filename and upload attachment.
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)
  sibling_text = unlist(strsplit(projectDataframe$tree_structure$text[projectDataframe$tree_structure$parent == ifelse(quick_analysis,"QUICK_ANALYSIS",ifelse(input_oriented_saving,projectDataframe$tree_structure$parent[projectDataframe$tree_structure$id == expression_id],"root"))], "_68410298_"))
  filename = make.unique(c(sibling_text,"nonparametric two way repeated ANOVA"),sep="_")[length(c(sibling_text,"nonparametric two way repeated ANOVA"))]
  # filename = "nonparametric two way repeated ANOVA"
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
  saveWorkbook(wb, paste0("nonparametric two way repeated ANOVA",".xlsx"), TRUE)
  # fwrite(out, paste0(filename,".csv"))



  attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "nonparametric two way repeated ANOVA", suffix = ".xlsx", content_type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")




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
      source = list(FUNCTION = "nonparametric_two_way_repeated_anova",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id,
        # ADD PARAMETER HERE

        group_name1 = group_name1,
        group_name2 =  group_name2,
        levels1 = levels1,
        levels2 = levels2,
        sample_ID_name =sample_ID_name,
        post_hoc_test_type = post_hoc_test_type



      )),
      source_node_id = expression_id,
      report = report
    )
    # file.
    projectList$tree_structure[[length(projectList$tree_structure)+1]] = list(
      id = paste0("nonparametric two way repeated ANOVA","_68410298_",numeric_time,"_xlsx"),
      parent = paste0(filename,"_68410298_",numeric_time,""),
      text = paste0("nonparametric two way repeated ANOVA",".xlsx"),
      icon = "fa fa-file-excel-o",
      attname = attname,
      source = list(FUNCTION = "nonparametric_two_way_repeated_anova",PARAMETER = list(
        project_ID = project_ID,
        expression_id = expression_id,
        sample_info_id = sample_info_id ,
        # ADD PARAMETER HERE

        group_name1 = group_name1,
        group_name2 =  group_name2,
        levels1 = levels1,
        levels2 = levels2,
        sample_ID_name =sample_ID_name,
        post_hoc_test_type = post_hoc_test_type





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
        source = list(FUNCTION = "nonparametric_two_way_repeated_anova",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          # ADD PARAMETER HERE
          group_name1 = group_name1,
          group_name2 =  group_name2,
          levels1 = levels1,
          levels2 = levels2,
          sample_ID_name =sample_ID_name,
          post_hoc_test_type = post_hoc_test_type





        )),
        source_node_id = expression_id,
        report = report),
      list(
        id = paste0("nonparametric two way repeated ANOVA","_68410298_",numeric_time,"_xlsx"),
        parent = paste0(filename,"_68410298_",numeric_time,""),
        text = paste0("nonparametric two way repeated ANOVA",".xlsx"),
        icon = "fa fa-file-excel-o",
        attname = attname,
        source = list(FUNCTION = "nonparametric_two_way_repeated_anova",PARAMETER = list(
          project_ID = project_ID,
          expression_id = expression_id,
          sample_info_id = sample_info_id,
          # ADD PARAMETER HERE

          group_name1 = group_name1,
          group_name2 =  group_name2,
          levels1 = levels1,
          levels2 = levels2,
          sample_ID_name =sample_ID_name,
          post_hoc_test_type = post_hoc_test_type





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









