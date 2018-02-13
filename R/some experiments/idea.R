result = RCurl::getURL("http://localhost:5656/ocpu/library/Abib.alpha/R/t_test/",customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= toJSON('{"project_ID":"test14_68410298_1510770135723","expression_id":"expression_data_68410298_1510770135723_csv","sample_info_id":"sample_info_68410298_1510770135723_csv","group_name":"species","levels":["pumpkin", "tomatillo"],"direction":"two.sided","type":"Welch"}',auto_unbox = T, force = T))



result = RCurl::getURL("http://localhost:5656/ocpu/library/base/R/mean",customrequest='POST',httpheader=c('Content-Type'='application/json'),postfields= toJSON(fromJSON('{"x":[1,2]}')))



result = RCurl::getURL("http://localhost:5656/ocpu/library/Abib.alpha/R/t_test",customrequest='POST',httpheader=c('Content-Type'='application/json'),postfields= toJSON(fromJSON('{"project_ID":"test14_68410298_1510770135723","expression_id":"expression_data_68410298_1510770135723_csv","sample_info_id":"sample_info_68410298_1510770135723_csv","group_name":"species","levels":["pumpkin", "tomatillo"],"direction":"two.sided","type":"Welch"}')))

toJSON('{"project_id":"test14_68410298_1510770135723","expression_id":"expression_data_68410298_1510770135723_csv","sample_info_id":"sample_info_68410298_1510770135723_csv","group_name":"species","levels":["pumpkin", "tomatillo"],"direction":"two.sided","type":"Welch"}',auto_unbox = T, force = T)

system("wmic cpu get loadpercentage")




function()}{
  # put to couchdb,
  ...

  # call check couchdb
  check_couchdb_pid(5656)
}


check_couchdb_pid = function(project_ID){


  # check CPU usage and view of pending tasks

  # fdasfasfas
  # use RCurl to post and do calculation

  result = RCurl::getURL(paste0("http://localhost/ocpu/library/Abib.alpha/R/",FUNCTION),
                         customrequest='POST',
                         httpheader=c('Content-Type'='application/json'),
                         postfields= jsonlite::toJSON(PARAMETER)
  )


  return()


}









check_couchdb = function(){
  # pending calculating finished

  # check CPU usage and view of pending tasks

  # fdasfasfas
  # use RCurl to post and do calculation

  return()


}




# http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/_design/task/_view/stats?=[%22a%22,%22root%22]
