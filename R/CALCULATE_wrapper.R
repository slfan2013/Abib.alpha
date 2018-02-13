CALCULATE_wrapper = function(
  task_id="AUTO_CREATED_USER_68410298_1515699286613_68410298_1515727291267",
  function_name = ""
){


  # check CPU usage at 80.
  result_CPU_check = RCurl::getURL(URLencode("http://chemrichdb1.fiehnlab.ucdavis.edu/ocpu/library/Abib.alpha/R/CHECK_CPU"),
                         customrequest='POST',
                         httpheader=c('Content-Type'='application/json')
  )


  if(jsonlite::fromJSON(URLencode(paste0("http://chemrichdb1.fiehnlab.ucdavis.edu/ocpu/tmp/",substr(result_CPU_check,11,21),"/R/.val/json")))){

    result = CALCULATE(task_id, skip_checking = TRUE)

    # download result.png if there is a figure return.
    # if(RCurl::url.exists(paste0('http://chemrichdb1.fiehnlab.ucdavis.edu',result$result_session,'/files/result.png'))){
    #   download.file(paste0('http://chemrichdb1.fiehnlab.ucdavis.edu',result$result_session,'/files/result.png'),"result.png",mode = 'wb')
    # }
    o = tryCatch({download.file(URLencode(paste0('http://chemrichdb1.fiehnlab.ucdavis.edu',result$result_session,'/files/result_68410298_',function_name,'.png')),"result.png", quiet = T,mode = 'wb')}, silent = FALSE,condition  = function(err){return(NA)})

    return(list(success = result$success, out = result$out, result_session = result$result_session))

  }else{
    stop("Sorry. The server is busy. Your task is put in a queue of our database. We'll finish your request once our server is available, and then we'll prompt an notification to let you know.")
  }






}


