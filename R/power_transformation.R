power_transformation = function(
  project_ID = "a1_68410298_1515699302308",
  expression_id ="expression_data_68410298_1515699302308_csv",
  power_base=10,
  use_pca = TRUE,
  check_normality = TRUE,
  study_design=c("species","treatment"),
  quick_analysis=FALSE
){


  pacman::p_load("data.table", openxlsx)

  # make _csv to .csv.
  expression_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",expression_id))
  # read data
  if(grepl(".xlsx",expression_name)){
    e = read.xlsx(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)))
    # colnames(e) = gsub("\\."," ",colnames(e))
    e = data.table(e)
  }else{
    e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
    # e = fread("e.csv")
  }



  compound_label = e$label
  e = e[,-1,with = F]
  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }
  e[e==0] = 1

  core = e^power_base



  out = data.table(label = compound_label, core)



  filename = 'power'


  report = paste0("# ",filename,"\n\n")

  report = paste0(report, "We performed log (base=",power_base, ") data transformation on the _",strsplit(expression_id,"_68410298_")[[1]][1],"_ dataset. The transformed data is saved as _",filename,"/data_transformation-log2.xlsx_.\n\n")


  if(check_normality){
    p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/sample_info_68410298_",strsplit(project_ID,"_68410298_")[[1]][2],".csv")),header=T)
    p = p[,study_design,with=F]
    before_normality = apply(e, 1, function(x){
      dta = data.frame(x,p)
      shapiro.test(lm(x~., data = dta)$res)$p.value
    })
    after_normality = apply(core, 1, function(x){
      dta = data.frame(x,p)
      shapiro.test(lm(x~., data = dta)$res)$p.value
    })
  }else{
    before_normality = after_normality = NULL
  }
  if(use_pca){
    before_pca_score = prcomp(t(e), scale. = TRUE)$x[,c(1,2)]
    after_pca_score = prcomp(t(core), scale. = TRUE)$x[,c(1,2)]
  }else{
    before_pca_score = after_pca_score = NULL
  }


  return(list(table_data = out, report_text = report, before_normality = before_normality, after_normality = after_normality, normality_direction = after_normality - before_normality,before_pca_score = before_pca_score, after_pca_score = after_pca_score))



}









