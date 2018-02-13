paired_t_test = function(project_ID = "B_68410298_1516165054888",
                  expression_id = "power transformation_68410298_1516165104685_csv",
                  sample_info_id = "sample_info_68410298_1513277797802_csv",
                  sample_ID_name = "Horse ID",
                  group_name = "Time point",
                  levels = c("1", "8"),
                  direction = "two.sided",
                  # auto_save = FALSE,
				          # input_oriented_saving = TRUE,
                  quick_analysis=FALSE
				          # ,numeric_time = "1513290817448"
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


  id_index = p[[sample_ID_name]]
  id_index = id_index[p$label%in%included_label]
  # check the completeness of the ID * group1. If not, add.
  id_levels = levels(id_index)
  group_levels = levels(group)
  id_tb = table(id_index, group)
  id_index = as.character(id_index)
  group = as.character(group)
  for(j in 1:dim(id_tb)[2]){ # in each level of group
    for(i in 1:length(id_tb[,j])){ # check if any row is not all 0s or all 1s by length unique ?= 2. this means that there is missing id.
      if(id_tb[i,j]==0){
        id_index = c(id_index, names(id_tb[,j])[i]) # add a sudo id.
        group = c(group, colnames(id_tb)[j]) # add corresponding sudo group1.
        e = cbind(e, matrix(NA, nrow = nrow(e), ncol = 1)) # add columns with missing values.
      }
    }
  }
  id_index = factor(id_index, levels = id_levels) # make them back to factor again
  group = factor(group, levels = group_levels) # make them back to factor again



  group_indexes = sapply(levels, function(x) group%in%x, simplify = F)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }
  core = paired_t_test_core(e,group_indexes,direction,id_index)

  out = data.table(label = compound_label, core)



  # systematical.
  # determine the filename and upload attachment.
  # filename = get_filename(project_ID, function_name = "paired t test", quick_analysis, input_oriented_saving)

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
  # saveWorkbook(wb, paste0("paired t test",".xlsx"), TRUE)
  # fwrite(out, paste0(filename,".csv"))

  # fwrite(out, paste0("paired t test",".csv"))
  #
  # attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "paired t test", suffix = ".csv", content_type = "application/vnd.ms-excel")




  filename = "paired t test"
  report = paste0("# ",filename,"\n\nTo study the changes in metabolic profile in the paired samples _(paired by `",sample_ID_name,"` in the _sample_info_)_ effect by ", group_name, " ", levels[1], " _vs._ ", levels[2],", ")

  report = paste0(report,"we performed `",direction,"` paired t test for each of the metabolic variable in the _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset and report significance at 0.05 of raw _p_ value. To deal with the challenges with multiple testings, we utilized Benjamini and Hochberg (1995) procedure to control the false discovery rate (FDR) and correct for multiple hypothesis tests. The FDR was controlled at 0.05 (adjusted _p_ value) for testing the exposure signatures for the ", group_name,".\n\nAs a result, we found that there are ", sum(out[[3]]<0.05, na.rm = T), " (",signif(sum(out[[3]]<0.05, na.rm = T)/nrow(out),4)*100 ,"%) significant compounds have a raw _p_ value of less than 0.05, and ", sum(out[[4]]<0.05, na.rm = T), " (",signif(sum(out[[4]]<0.05, na.rm = T)/nrow(out),4)*100 ,"%) compounds significant after controlling for the FDR.\n\nThe result is saved in the _",filename,"/paired t test.csv_. The column description is as following,\n\n")

  # column name explanation
  report = paste0(report,"- **",colnames(core)[1],":**", " ", "The [t statistic](https://en.wikipedia.org/wiki/T-statistic#Definition_and_features) of compound. Positive means that the ", levels[1], " is greater than the ", levels[2]," for that compound.\n\n")
  report = paste0(report,"- **",colnames(core)[2],":**", " ", "The raw _p_ values of `",direction,"` paired t test comparing ",levels[1]," _vs._ ",levels[2],".\n\n")
  report = paste0(report,"- **",colnames(core)[3],":**", " ", "The Benjamini-Hochberg (1995) adjusted _p_ value of the raw _p_ values.\n\n")



  # return:
  # report. data for pie chart. and table.
  pie_data = data.frame(label = c( "not significant","raw significant","FDR significant"),value = c(sum(out[[3]]>0.05),sum(out[[3]]<0.05&out[[4]]>0.05),sum(out[[4]]<0.05)))

  table_data_criterion = data.table(label = out$label, out[[3]]>0.05, out[[3]]<0.05&out[[4]]>0.05, out[[4]]<0.05)
  colnames(table_data_criterion) = c("label", as.character(pie_data$label)) # when use click a pie piece, we'll know in the table_data, which should be displayed.
  colnames(out) = gsub("\\.","_",colnames(out))
  return(list(table_data_criterion = table_data_criterion,table_data = out,  table_data_colnames = gsub("\\.","_",colnames(out)), report_text = report, graph_pie_data = pie_data))


}









