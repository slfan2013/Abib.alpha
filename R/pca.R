pca = function(project_ID = "C_68410298_1516167892799",
               expression_id = "5-mM-0_17vs24hr_68410298_1516177326935_csv",
               sample_info_id = "sample_info_68410298_1516177326935_csv",

               scaleC = "standard",
               algoC = 'svd',

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

  opls = ropls::opls(e_t, scaleC = scaleC, predI = 5,printL = FALSE, plotL = F)

  loadings = data.table(label = compound_label, getLoadingMN(opls))
  # fwrite(loadings, "PCA-loadings.csv")
  var_exp = data.table(PC = paste0("PC", 1:length(opls@modelDF$R2X)), percentage = opls@modelDF$R2X*100)
  # fwrite(var_exp, "PCA-variance_explained.csv")
  scores = data.table(label = sample_label, getScoreMN(opls))
  # fwrite(scores, "PCA-scores.csv")






  # # systematical
  # projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  # projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
  # projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = T)
  # # numeric_time = as.integer(Sys.time())
  #
  #
  #
  # filename = get_filename(project_ID, function_name = "PCA", quick_analysis, input_oriented_saving)
  #
  #
  # attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "PCA-scores", suffix = ".csv", content_type = "application/vnd.ms-excel")
  # attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "PCA-loadings", suffix = ".csv", content_type = "application/vnd.ms-excel")
  # attname = put_attachment(project_ID,numeric_time =  numeric_time, filename = "PCA-variance_explained", suffix = ".csv", content_type = "application/vnd.ms-excel")

  filename = "pca"

report = paste0("# Principal Component Analysis (",filename,")\n\n")

report = paste0(report, "We further constructed Principal Component Analysis (PCA, **Figure** *",filename,"*) using all the compounds in _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset. \n\n")






return(list(scores = scores, loadings = loadings, var_exp = var_exp, report_text = report))


}









