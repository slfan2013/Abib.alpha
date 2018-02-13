createProject <- function() {

  file = data.table::fread("http://chemrichdb2.fiehnlab.ucdavis.edu/db/metabox/admin/test.csv", sep = ',', check.names = F, stringsAsFactors = F)

  result = jsonlite::toJSON(file)

  return(list(success = TRUE, result = result))
}
