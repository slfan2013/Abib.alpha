pls = function(project_ID = "CSH_68410298_1517439950508",
               expression_id = "5-mM-0_17vs24hr_68410298_1516177326935_csv",
               sample_info_id = "sample_info_68410298_1516177326935_csv",

               scaleC = "standard",
               algoC = 'nipals',

               response = "time",

               predI = "NA",
               permI = 100,
               quick_analysis=FALSE



){

  pacman::p_load("data.table",  ropls, officer,dplyr, rvg, openxlsx)

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

  included_label = p[['label']]
  compound_label = e$label
  sample_label = included_label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }



  e_t = t(e)

  colnames(e_t) = compound_label
  rownames(e_t) = sample_label

  opls = ropls::opls(x = e_t, y = p[[response]],  scaleC = scaleC, predI = 10,printL = FALSE, plotL = F, permI = permI)

  loadings = data.table(label = compound_label, getLoadingMN(opls))
  # fwrite(data.table(compound_label = compound_label, loadings), "PLS-loadings.csv")
  # var_exp = getPcaVarVn(opls)
  # fwrite(data.table(var_exp), "PLS-VIP_score.csv")

  scores = data.table(label = sample_label, getScoreMN(opls))
  # fwrite(data.table(sample_label = sample_label, scores), "PLS-scores.csv")

  VIP_score = data.table(label = compound_label, getVipVn(opls))
  # fwrite(data.table(compound_label = compound_label, VIP_score), "PLS-VIP_score.csv")

  # plot(opls, typeVc = "correlation", parTitleL = T, parDevNewL = FALSE)
  model_summary = data.table(opls@modelDF)

  permutation_summary = opls@suppLs$permMN
  # plot(opls, typeVc = "permutation", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "predict-train", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "predict-test", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "summary", parTitleL = T, parDevNewL = FALSE)

  var_exp = data.table(PC = paste0("PC",1:10), percentage = opls@modelDF[,1]*100)

  # plot(opls, typeVc = "x-variance", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "xy-score", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "xy-weight", parTitleL = T, parDevNewL = FALSE)


  filename = "plsda"

  report = paste0("# Partial Least Square - Discriminant Analysis (",filename,")\n\n")

  report = paste0(report, "We further constructed Principal Component Analysis (PCA, **Figure** *",filename,"*) using all the compounds in _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset. \n\n")

  filename = "pca"

  report = paste0("# Principal Component Analysis (",filename,")\n\n")

  report = paste0(report, "We further constructed Principal Component Analysis (PCA, **Figure** *",filename,"*) using all the compounds in _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset. \n\n")


  return(list(scores = scores, loadings = loadings, VIP_score = VIP_score, VIP_score_sort = VIP_score[order(VIP_score$V2, decreasing = F),], var_exp = var_exp, model_summary = model_summary, permutation_summary = permutation_summary, permutation_sig = sum(!permutation_summary[,3]<permutation_summary[1,3])/nrow(e),report_text = report))





}









