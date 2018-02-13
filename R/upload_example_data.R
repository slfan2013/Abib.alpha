upload_example_data = function(
  project_ID = "example project_68410298_1513361548183"
){

  pacman::p_load(data.table)

  p = fread("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/EXAMPLE%20DATA%20FILE/Sample_info.csv", strip.white = FALSE)
  fwrite(p,"sample_info.csv")

  f = fread("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/EXAMPLE%20DATA%20FILE/Metabolite_info.csv", strip.white = FALSE)
  fwrite(f,"metabolite_info.csv")

  e = fread("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/EXAMPLE%20DATA%20FILE/Expression%20data.csv", strip.white = FALSE)
  fwrite(e,"expression_data.csv")
  # upload these tree data files.
  # upload expression
  attname = put_attachment(project_ID,numeric_time =  strsplit(project_ID,"_68410298_")[[1]][2], filename = "expression_data", suffix = ".csv", content_type = "application/vnd.ms-excel")
  # upload metabolite_info
  attname = put_attachment(project_ID,numeric_time =  strsplit(project_ID,"_68410298_")[[1]][2], filename = "metabolite_info", suffix = ".csv", content_type = "application/vnd.ms-excel")
  # upload sample_info
  attname = put_attachment(project_ID,numeric_time =  strsplit(project_ID,"_68410298_")[[1]][2], filename = "sample_info", suffix = ".csv", content_type = "application/vnd.ms-excel")



  return(TRUE)

}
