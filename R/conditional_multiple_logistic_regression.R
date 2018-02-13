conditional_multiple_logistic_regression = function(project_ID = "test4_68410298_1510449038964",
                                       expression_id = "expression_data_68410298_1510449038964_csv",
                                       sample_info_id = "sample_info_68410298_1510449038964_csv",
                                       var_name = "species",# must has only two levels
                                       levels = c("tomatillo", "pumpkin"),
                                       confounding_var_name = c("var1"),
                                       strata_name = "var4",
                                       scale = TRUE # in order to get a meaningful odds ratio.
){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table")

  # make _csv to .csv.
  expression_name = paste0(substring(expression_id, 1, nchar(expression_id)-4),".csv")
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
  # e = fread("e.csv")

  # read sample info
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  # p = fread("p.csv")
  compound_label = e$label
  e = e[,colnames(e)%in%p$label,with=F]

  e = data.matrix(e)


  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }

  if(scale){
    e = t(apply(e,1,scale))
  }




  var = c(var_name, confounding_var_name)



  #
  p_confounding_var = p[, confounding_var_name,with = F]
  p_var = p[,var_name, with = F][[1]]
  p_var = factor(p_var, levels = levels)
  # dta = data.table(value = 1:nrow(p), p_var)
  # # get the design matrix.
  # X = model.matrix(value ~ .,data = dta)
  # colnames(X)[-1] = var

  p_strata = p[[strata_name]]

  core = conditional_mutiple_logistic_regression_core(e, p_var,p_confounding_var, p_strata = p_strata)

  result = data.table(label = compound_label, core)







}









