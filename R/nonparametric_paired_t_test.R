nonparametric_paired_t_test = function(project_ID = "a4_68410298_1514765751212",
                                expression_id = "expression_data_68410298_1514765751212_csv",
                                sample_info_id = "sample_info_68410298_1514765751212_csv",
                                sample_ID_name = "id",
                                group_name = "species",
                                levels = c("pumpkin", "tomatillo"),
                                direction = "two.sided",
								                quick_analysis=FALSE){


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
  core = nonparametric_paired_t_test_core(e,group_indexes, direction,id_index)



  out = data.table(label = compound_label, core)



  # systematical.
  # determine the filename and upload attachment.
  filename = "Wilcoxon signed-rank test"


  report = paste0("# ",filename,"\n\nTo study the changes in metabolic profile in the paired samples _(paired by `",sample_ID_name,"` in the _sample_info_)_ effect by ", group_name, " ", levels[1], " _vs._ ", levels[2],", ")

  report = paste0(report,"we performed `",direction,"` nonparametric paired t test (Wilcoxon signed-rank) for each of the metabolic variable in the _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset and report significance at 0.05 of raw _p_ value. To deal with the challenges with multiple testings, we utilized Benjamini and Hochberg (1995) procedure to control the false discovery rate (FDR) and correct for multiple hypothesis tests. The FDR was controlled at 0.05 (adjusted _p_ value) for testing the exposure signatures for the ", group_name,".\n\nAs a result, we found that there are ", sum(out[[2]]<0.05, na.rm = T), " (",signif(sum(out[[2]]<0.05, na.rm = T)/nrow(out),4)*100 ,"%) significant compounds have a raw _p_ value of less than 0.05, and ", sum(out[[3]]<0.05, na.rm = T), " (",signif(sum(out[[3]]<0.05, na.rm = T)/nrow(out),4)*100 ,"%) compounds significant after controlling for the FDR.\n\nThe result is saved in the _",filename,"/nonparametric paired t test.xlsx_. The column description is as following,\n\n")

  # column name explanation
  report = paste0(report,"- **",colnames(core)[1],":**", " ", "The raw _p_ values of `",direction,"` nonparametric paired t test comparing ",levels[1]," _vs._ ",levels[2],".\n\n")
  report = paste0(report,"- **",colnames(core)[2],":**", " ", "The Benjamini-Hochberg (1995) adjusted _p_ value of the raw _p_ values.\n\n")







  # return:
  # report. data for pie chart. and table.
  pie_data = data.frame(label = c( "not significant","raw significant","FDR significant"),value = c(sum(out[[3]]>0.05),sum(out[[3]]<0.05&out[[4]]>0.05),sum(out[[4]]<0.05)))

  table_data_criterion = data.table(label = out$label, out[[3]]>0.05, out[[3]]<0.05&out[[4]]>0.05, out[[4]]<0.05)
  colnames(table_data_criterion) = c("label", as.character(pie_data$label)) # when use click a pie piece, we'll know in the table_data, which should be displayed.
  colnames(out) = gsub("\\.","_",colnames(out))
  return(list(table_data_criterion = table_data_criterion,table_data = out,  table_data_colnames = gsub("\\.","_",colnames(out)), report_text = report, graph_pie_data = pie_data))



}









