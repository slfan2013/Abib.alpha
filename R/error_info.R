error_info = function(
  FUNCTION="t_test",
  PARAMETER= list(
    project_ID = "test14_68410298_1510770135723",

    expression_id = "expression_data_68410298_1510770135723_csv",

    sample_info_id = "sample_info_68410298_1510770135723_csv",

    group_name = "species",

    levels = c("pumpkin","tomatillo"),

    direction = "two.sided",

    type = "Welch"
  ),
  usename= 'slfan1',
  error_message = 'error'
){


  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/error"))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = F)

  if(length(projectList$error) == 0){
    projectList$error = list()
  }
  projectList$error[[length(projectList$error) + 1]] = list(
    FUNCTION=FUNCTION,
    PARAMETER= PARAMETER,
    usename= usename,
    error_message  = error_message
  )

  result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))

  return(list(success = TRUE))



}
