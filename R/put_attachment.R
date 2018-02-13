put_attachment = function(project_ID,numeric_time =as.integer(Sys.time()), filename = "two-way boxplots", suffix = ".pptx", content_type = "application/vnd.openxmlformats-officedocument.presentationml.presentation"){



  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl)
  attname = paste0(filename, "_68410298_",numeric_time,suffix)
  new_att = projectList[["_attachments"]]
  new_att = new_att[!names(new_att)%in%attname]
  new_att[[attname]] = list(content_type=content_type, data = RCurl::base64Encode(readBin(paste0(filename, suffix), "raw", file.info(paste0(filename, suffix))[1, "size"]), "txt"))
  projectList[["_attachments"]] = new_att
  result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))


  return(attname)
}
