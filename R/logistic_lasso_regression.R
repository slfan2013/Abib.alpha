logistic_lasso_regression = function(project_ID = "t test_68410298_1508863368603",
                                   expression_id = "expression_data_68410298_1508863368603_csv",
                                   sample_info_id = "sample_info_68410298_1508863368603_csv",
                                   var_name = "species",
                                   levels = c("tomatillo", "pumpkin"),
                                   alpha = 0.5
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


  var = p[, var_name,with = F][[1]]
  var = factor(var, levels = levels)

  core = logistic_lasso_regression_core(e,var,alpha)

  fit = core$fit
  cvfit = core$cvfit

  plot(fit, "lambda", label = TRUE)
  abline(v = log(cvfit$lambda.min))
  abline(v = log(cvfit$lambda.1se))
  plot(cvfit)

  result = data.table(label = compound_label, core = core$result[-1])







}









