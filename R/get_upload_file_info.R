get_upload_file_info = function(input = "p.csv"){

  pacman::p_load(data.table)

  dta = fread(input)


  column_name = colnames(dta)
  column_value = sapply(dta,unique, simplify = FALSE)
  column_length = sapply(dta, function(x) length(unique(x)), simplify = FALSE)
  column_class = sapply(dta, class, simplify = FALSE)




  return(list(success = TRUE, column_name = column_name, column_value = column_value, column_length = column_length, column_class = column_class))


}
