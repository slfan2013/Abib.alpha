upload_data <- function(path = "C:\\Users\\Sili\\Desktop\\Statistical analysis datasets\\mx 131933 A\\A.xlsx") {
  pacman::p_load(data.table)

  # read data and split data into sample_info, metabolite_info, and expression_data
  data = readxl::read_excel(path, col_names = FALSE)
  data = data.table(data)

  warning_message = "<ul>"

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
    warning_message = paste0(warning_message, "<li>Empty sample labels found, they were replaced by <em>na</em>s.</li>")
  }
  if(sum(duplicated(p$label)>0)){
    warning_message = paste0(warning_message, "<li>Duplicated sample labels found, they were made unique by appending sequence numbers to duplicates. <em>(",paste0(p$label[duplicated(p$label)],collapse = ', '),")</em></li>")
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
    warning_message = paste0(warning_message, "<li>Empty metaboliet labels found, they were replaced by <em>na</em>s.</li>")
    f$label[is.na(f$label)] = "na"
  }
  if(sum(duplicated(f$label)>0)){
    warning_message = paste0(warning_message, "<li>Duplicated metabolite labels found, they were made unique by appending sequence numbers to duplicates. <em>(",paste0(f$label[duplicated(f$label)],collapse = ', '),")</em></li>")
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
  if(sum(is.na(e[,-1,with=F]))>0){
    warning_message = paste0(warning_message, "<li>",sum(is.na(e[,-1,with=F]))," missing values in expression data found, they will be repalced by half minimum of each compound by default if not specified in <em>missing value imputation</em> module.</li>")
  }
  if(sum(e[,-1,with=F]==0, na.rm = T)>0){
    warning_message = paste0(warning_message, "<li>",sum(e[,-1,with=F]==0, na.rm = T)," zero values in expression data found, they will NOT be dealt with by default.</li>")
  }
  data.table::fwrite(e, "expression_data.csv")
  jsonlite::write_json(e,"expression_data.JSON")


  warning_message = paste0(warning_message, "</ul>")

  # guess study design
  length_unique_sample_info = sapply(p, function(x){
    length(unique(x))
  })
  guess_study_design = colnames(p)[ length_unique_sample_info > 1 & length_unique_sample_info < 5]
  if(length(guess_study_design)>2){
    guess_study_design = guess_study_design[c(1,2)]
  }

  return(list(
    warning_message = warning_message,
    colnames_sample_info = colnames(p),
    colnames_metabolite_info = colnames(f),
    guess_study_design = guess_study_design
  ))

}
