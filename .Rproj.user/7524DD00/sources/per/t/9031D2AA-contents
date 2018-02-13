fold_change = function(project_ID = "test3_68410298_1516132288269",
                  expression_id = "expression_data_68410298_1516132288269_csv",
                  sample_info_id = "sample_info_68410298_1516132288269_csv",
                  group_name1= "species",
                  levels1 = c("pumpkin","tomatillo"),
                  two_factor = T,
                  group_name2= "treatment",
                  levels2 = c("100% MeOH - fresh frozen","ACN:IPA:H2O (3:3:2) - fresh frozen","MeOH:CHCl3:H2O (5:2:2) - fresh frozen","MeOH:CHCl3:H2O (5:2:2) - lyophilized"),
                  method = 'mean',
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


  if(two_factor){
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

    group = paste0(group1, "*",group2)
    group = factor(group)

    group_indexes1 = sapply(levels1, function(x) group1%in%x, simplify = F)
    group_indexes2 = sapply(levels2, function(x) group2%in%x, simplify = F)
    group_indexes = sapply(levels(group), function(x) group%in%x, simplify = F)

    core1 = fold_change_core(e,group_indexes1, method)
    core2 = fold_change_core(e,group_indexes2, method)
    core = fold_change_core(e,group_indexes, method)

    out = data.table(label = compound_label,core1, core2, core)

    colnames(out) = gsub("\\.","_",colnames(out))

  }else{
    # group (as factor)
    group1 = p[[group_name1]]
    group1 = factor(group1, levels = c(levels1))

    # subsetting to get only two groups.
    included_label = p[['label']][!is.na(group1)]
    compound_label = e$label
    e = e[, colnames(e) %in% included_label, with = F]
    e = data.matrix(e)
    for(i in 1:nrow(e)){
      e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
    }
    group1 = group1[!is.na(group1)]

    group_indexes = sapply(levels(group1), function(x) group1%in%x, simplify = F)
    core = fold_change_core(e,group_indexes, method)



    out = data.table(label = compound_label, core)
  }

  filename = "fold change"
  # ========================================================================================================================================================= #
  report = paste0("# ",filename,"\n\n fold change text. \n\n")



  return(list(table_data = out, table_data_colnames = gsub("\\.","_",colnames(out)), report_text = report))


}









