mutiple_survival_regression = function(project_ID = "t test_68410298_1508863368603",
                                     expression_id = "expression_data_68410298_1508863368603_csv",
                                     sample_info_id = "sample_info_68410298_1508863368603_csv",
                                     time_name = c("time"),
                                     censor_name = c("status"),
                                     confounding_var_name = c("age",'sex'),
                                     scale = TRUE
){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table")

  # make _csv to .csv.
  expression_name = paste0(substring(expression_id, 1, nchar(expression_id)-4),".csv")
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  # e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
  e = fread("e.csv")

  # read sample info
  # p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  p = fread("p.csv")
  compound_label = e$label
  e = e[,colnames(e)%in%p$label,with=F]

  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }

  if(scale){
    e = t(apply(e,1,scale))
  }

  p_confounding_var = p[, confounding_var_name,with = F]

  time = p[[time_name]]
  censor = p[[censor_name]]

  core = mutiple_survival_regression_core(e,time, censor, p_confounding_var)

  result = data.table(label = compound_label, core[,var_name,with=F])







}









