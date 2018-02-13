t_test = function(project_ID = "C_68410298_1516167892799",
                  expression_id = "5-mM-0_17vs24hr_68410298_1516177326935_csv",
                  sample_info_id = "sample_info_68410298_1516177326935_csv",
                  group_name = "time",
                  levels = c("0.17 hr", "24 hrs"),
                  direction = "two.sided",
                  type = "Welch",
                  # auto_save = FALSE,
                  # input_oriented_saving = TRUE,
                  quick_analysis=FALSE
                  # ,numeric_time = "1513217773753"
                  ){
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
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  # p = fread("p.csv")

  # group (as factor)
  group = p[[group_name]]
  group = factor(group, levels = c(levels))

  # subsetting to get only two groups.
  included_label = p[['label']][!is.na(group)]
  compound_label = e$label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }
  group = group[!is.na(group)]

  # group index.
  # group1_index = group%in%levels[1]
  # group2_index = group%in%levels[2]

  group_indexes = sapply(levels, function(x) group%in%x, simplify = F)


  core = t_test_core(e,group_indexes,type,direction)



  out = data.table(label = compound_label, core)




  # systematical.
  # determine the filename and upload attachment.
  # filename = get_filename(project_ID, function_name = "t test", quick_analysis, input_oriented_saving)

  # write xlsx
  # wb <- createWorkbook()
  # addWorksheet(wb, "result")
  # # addWorksheet(wb, "report")
  #
  #
  # significantStyle <- createStyle(fontColour = "#9C0006")
  # number_format = createStyle(numFmt = "0.000")
  # colnames(out) = make.unique(colnames(out),sep = "_") # cannot have duplicated column name otherwise the next line will return error.
  # writeDataTable(wb, "result", out, startRow = 1, startCol = 1, tableStyle = "TableStyleLight9")
  # conditionalFormatting(wb, 1, cols=c(3,4), rows=2:(nrow(out)+1), rule="<0.05", style = significantStyle)
  # addStyle(wb,"result",cols=2:4, rows = 2:(nrow(out)+1), style = number_format, gridExpand = T)
  # # conditionalFormatting(wb, "result", cols = 2, rows = 2:(nrow(out)+1), type = "colourScale", style = c("#F8696B", "#FFEB84","#63BE7B"))
  # saveWorkbook(wb, paste0("t test",".xlsx"), TRUE)
  # fwrite(out, paste0(filename,".csv"))

  # fwrite(out, paste0("t test",".csv"))



  # attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "t test", suffix = ".csv", content_type = "application/vnd.ms-excel")



  filename = "t test"

  report = paste0("# ",filename,"\n\nTo study the changes in metabolic profile effect by ", group_name, " ", levels[1], " _vs._ ", levels[2],", ")

  report = paste0(report,"we performed `",direction,"` ", type, " t test for each of the metabolic variable in the _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset and report significance at 0.05 of raw _p_ value. To deal with the challenges with multiple testings, we utilized Benjamini and Hochberg (1995) procedure to control the false discovery rate (FDR) and correct for multiple hypothesis tests. The FDR was controlled at 0.05 (adjusted _p_ value) for testing the exposure signatures for the ", group_name,".\n\nAs a result, we found that there are ", sum(out[[3]]<0.05, na.rm = T), " (",signif(sum(out[[3]]<0.05, na.rm = T)/nrow(out),4)*100 ,"%) significant compounds have a raw _p_ value of less than 0.05, and ", sum(out[[4]]<0.05, na.rm = T), " (",signif(sum(out[[4]]<0.05, na.rm = T)/nrow(out),4)*100 ,"%) compounds significant after controlling for the FDR.\n\nThe result is saved in the _",filename,"/t test.csv_. The column description is as following,\n\n")

  # column name explanation
  report = paste0(report,"- **",colnames(core)[1],":**", " ", "The [t statistic](https://en.wikipedia.org/wiki/T-statistic#Definition_and_features) of compound. Positive means that the ", levels[1], " is greater than the ", levels[2]," for that compound.\n\n")
  report = paste0(report,"- **",colnames(core)[2],":**", " ", "The raw _p_ values of `",direction,"` ",type," t test comparing ",levels[1]," _vs._ ",levels[2],".\n\n")
  report = paste0(report,"- **",colnames(core)[3],":**", " ", "The Benjamini-Hochberg (1995) adjusted _p_ value of the raw _p_ values.\n\n")







  # return:
  # report. data for pie chart. and table.
  pie_data = data.frame(label = c( "not significant","raw significant","FDR significant"),value = c(sum(out[[3]]>0.05),sum(out[[3]]<0.05&out[[4]]>0.05),sum(out[[4]]<0.05)))

  table_data_criterion = data.table(label = out$label, out[[3]]>0.05, out[[3]]<0.05&out[[4]]>0.05, out[[4]]<0.05)
  colnames(table_data_criterion) = c("label", as.character(pie_data$label)) # when use click a pie piece, we'll know in the table_data, which should be displayed.
  colnames(out) = gsub("\\.","_",colnames(out))
  return(list(table_data_criterion = table_data_criterion,table_data = out,  table_data_colnames = gsub("\\.","_",colnames(out)), report_text = report, graph_pie_data = pie_data))



}









