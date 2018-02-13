submit_bug = function(
  project_ID="test14_68410298_1510770135723",
  username="slfan1",
  submit_time="Thu Nov 16 2017 09:32:33 GMT-0800 (Pacific Standard Time)",
  name="t_test",
  message='test'
){


  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/report_bug"))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = F)

  if(length(projectList$bug) == 0){
    projectList$bug = list()
  }
  projectList$bug[[length(projectList$bug) + 1]] = list(
    project_ID = project_ID,
    username = username,
    submit_time = submit_time,
    name = name,
    message = message,
    status = "open"
  )

  result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))

  return(list(success = TRUE))



}
