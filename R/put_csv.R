put_csv = function(project_ID = 'tryThu.Aug.17.14.53.35.2017', attname = 'test.csv', att = data.table::fread("G:\\initialize MetDA\\user_active.csv")){
  projectUrl <- URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/metdadb/",projectID))
  projectList <- jsonlite::fromJSON(projectUrl)

  new_att = projectList[["_attachments"]]
  new_att = new_att[!names(new_att)%in%attname]
  new_att[[attname]] = list(content_type="text/csv", data = RCurl::base64(
    paste0(R.utils::captureOutput(write.csv(att,stdout(), row.names=F)),collapse = "\n")
  ))
  projectList[["_attachments"]] = new_att
  result = RCurl::getURL(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/metdadb/",projectID),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))
  while(grepl("error",result)) {
    projectList <- jsonlite::fromJSON(projectUrl)
    new_att = projectList[["_attachments"]]
    new_att = new_att[!names(new_att)%in%attname]
    new_att[[attname]] = list(content_type="text/csv", data = RCurl::base64(
      paste0(R.utils::captureOutput(write.csv(att,stdout(), row.names=F)),collapse = "\n")
    ))
    projectList[["_attachments"]] = new_att
    result = RCurl::getURL(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/metdadb/",projectID),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))
    if(grepl("ok",result)){
      break;
    }
  }
  return(result)
}
