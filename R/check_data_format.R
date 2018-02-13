check_data_format = function(
  phenotype_data = "C:\\Users\\Sili\\Documents\\Github\\mx-351579-Macarena\\GC\\p.csv",
  feature_data = "C:\\Users\\Sili\\Documents\\Github\\mx-351579-Macarena\\GC\\f.csv",
  expression_data = "C:\\Users\\Sili\\Documents\\Github\\mx-351579-Macarena\\GC\\e.csv"
){

  pacman::p_load(data.table, ez)

  p = fread(phenotype_data, strip.white = FALSE)

  f = fread(feature_data, strip.white = FALSE)

  e = fread(expression_data, strip.white = FALSE)



  sample_info_column_name = colnames(p)
  sample_info = sapply(p,unique, simplify = FALSE)
  sample_info_length = sapply(p, function(x) length(unique(x)), simplify = FALSE)
  sample_info_class = sapply(p, class, simplify = FALSE)



  compound_info_column_name = colnames(f)
  compound_info = sapply(f,unique, simplify = FALSE)
  compound_info_length = sapply(f, function(x) length(unique(x)), simplify = FALSE)
  compound_info_class = sapply(f, class, simplify = FALSE)


  # summarizing sample info to be used in the project detail
  summarizing = ezPrecis(p)
  summarizing_table = data.table(rownames(summarizing),summarizing)
  colnames(summarizing_table) = c("column_name",colnames(summarizing_table)[-1])
  sample_info_table_JSON = jsonlite::toJSON(summarizing_table)
  # summarizing compound info to be used in the project detail
  summarizing = ezPrecis(f)
  summarizing_table = data.table(rownames(summarizing),summarizing)
  colnames(summarizing_table) = c("column_name",colnames(summarizing_table)[-1])
  compound_info_table_JSON = jsonlite::toJSON(summarizing_table)

  return(list(success = TRUE,
              sample_info_column_name = sample_info_column_name,
              compound_info_column_name = compound_info_column_name,
              sample_info = sample_info,
              compound_info = compound_info,
              sample_info_length = sample_info_length,
              compound_info_length = compound_info_length,
              sample_info_class = sample_info_class,
              compound_info_class = compound_info_class,

              nrow_e = nrow(e),
              ncol_e = ncol(e),
              nrow_f = nrow(f),
              ncol_f = ncol(f),
              nrow_p = nrow(p),
              ncol_p = ncol(p),

              sample_info_table_JSON = sample_info_table_JSON,
              compound_info_table_JSON = compound_info_table_JSON
              ))

}
