create_new_project_put_files = function(
  path = "C:\\Users\\Sili\\Downloads\\Book1.xlsx",
  project_ID = "iii_68410298_1514189534865",
  numeric_time = "1514189534865"
){
  pacman::p_load(data.table)

  # read data and split data into sample_info, metabolite_info, and expression_data
  data = readxl::read_excel(path, col_names = FALSE)
  data = data.table(data)


  sample_col_range = min(which(!is.na(data[1,]))):ncol(data)
  sample_row_range = 1:min(which(!is.na(data[[1]])))
  compound_col_range = 1:(min(which(!is.na(data[1,]))))
  compound_row_range = (min(which(!is.na(data[[1]])))):nrow(data)

  p = t(data[sample_row_range,sample_col_range,with=F])
  colnames(p) = p[1,]
  p = p[-1,]
  p = p[,c(ncol(p),1:(ncol(p)-1))]
  p = data.table(p)
  p = sapply(p, function(x){
    if(sum(is.na(as.numeric(x)))==0){
      as.numeric(x)
    }else{
      x
    }
  }, simplify = F)
  p = as.data.table(p)
  colnames(p) = make.unique(colnames(p), sep = "_")
  if(!"label"%in%colnames(p)){
    stop("Cannot find 'label' in your data. Please check the data format requirement.")
  }
  if(sum(is.na(p$label))>0){
    p$label[is.na(p$label)] = "na"
  }
  if(sum(duplicated(p$label)>0)){
    p$label = make.unique(p$label, sep = "_")
  }

  data.table::fwrite(p, "sample_info.csv")
  jsonlite::write_json(p,"sample_info.JSON")


  f = data[compound_row_range,compound_col_range,with=F]
  colnames(f) = as.character(f[1,])
  f = f[-1,]
  f = f[,c(ncol(f),1:(ncol(f)-1)),with=F]
  f = sapply(f, function(x){
    if(sum(is.na(as.numeric(x)))==0){
      as.numeric(x)
    }else{
      x
    }
  }, simplify = F)
  f = as.data.table(f)
  colnames(f) = make.unique(colnames(f), sep = "_")
  if(sum(is.na(f$label))>0){
    f$label[is.na(f$label)] = "na"
  }
  if(sum(duplicated(f$label)>0)){
    f$label = make.unique(f$label, sep = "_")
  }
  data.table::fwrite(f, "metabolite_info.csv")
  jsonlite::write_json(f,"metabolite_info.JSON")

  e = data[compound_row_range, sample_col_range, with = F]
  colnames(e) = as.character(e[1,])
  colnames(e)[is.na(colnames(e))] = "na"
  e = e[-1,]
  e = data.table(label = e$label, sapply(e[,-1,with=F], function(x){
    as.numeric(x)
  }))
  colnames(e) = make.unique(colnames(e), sep = "_")
  e$label[is.na(e$label)] = "na"
  e$label = make.unique(e$label, sep = "_")
  colnames(e) = make.unique(colnames(e))

  fwrite(p, "sample_info.csv")
  put_attachment(project_ID,numeric_time =  numeric_time, filename = "sample_info", suffix = ".csv", content_type = "application/vnd.ms-excel")

  fwrite(f, "metabolite_info.csv")
  put_attachment(project_ID,numeric_time =  numeric_time, filename = "metabolite_info", suffix = ".csv", content_type = "application/vnd.ms-excel")

  fwrite(e, "expression_data.csv")
  put_attachment(project_ID,numeric_time =  numeric_time, filename = "expression_data", suffix = ".csv", content_type = "application/vnd.ms-excel")

  return(TRUE)
}
