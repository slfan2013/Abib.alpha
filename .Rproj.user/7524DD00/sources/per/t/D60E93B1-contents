CALCULATE = function(
  task_id="AUTO_CREATED_USER_68410298_1515699286613_68410298_1515727291267",
  skip_checking = FALSE # TRUE means that the CPU usage has been checked by CHECK_CPU and passed.
){

  if(!skip_checking){
    # check if CPU ok.
    if(Sys.info()['sysname'] == "Windows"){
      sys_info <- system("wmic path Win32_PerfFormattedData_PerfProc_Process get Name,PercentProcessorTime", intern = TRUE)
      df <- do.call(rbind, lapply(strsplit(sys_info, " "), function(x) {x <- x[x != ""];data.frame(process = x[1], cpu = x[2])}))
      num_processor_occupied = sum(grepl("Rgui|rstudio", df$process))
    }else{
      sys_info <- strsplit(system("ps -C rsession -o %cpu,%mem,pid,cmd", intern = TRUE), " ")
      df <- do.call(rbind, lapply(sys_info[-1],
                                  function(x) data.frame(
                                    cpu = as.numeric(x[2]),
                                    mem = as.numeric(x[4]),
                                    pid = as.numeric(x[5]),
                                    cmd = paste(x[-c(1:5)], collapse = " "))))
      num_processor_occupied = nrow(df)
    }
  }else{
    num_processor_occupied = -1
  }

  if(num_processor_occupied < parallel::detectCores() * .75){
    #if usage is less than 50%, start doing analysis.

    if(!is.null(task_id)){

      # it means this is a immediate task that user would like to have result.
      # change status to calculating.
      url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/",task_id)
      task <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)
      start_time = Sys.time();task$start_time = start_time
      task$STATUS = "calculating"
      RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(task,auto_unbox = T, force = T))
      # do the actual calculation.
      result = RCurl::getURL(paste0("http://chemrichdb1.fiehnlab.ucdavis.edu/ocpu/library/Abib.alpha/R/",task$FUNCTION),
                             customrequest='POST',
                             httpheader=c('Content-Type'='application/json'),
                             postfields= jsonlite::toJSON(task$PARAMETER, auto_unbox = T)
      )
      if(length(grep("^/ocpu/tmp",result))==1){
        # if success, change the status of the task to finished.
        url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/",task_id)
        task <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)
        task$end_time = Sys.time()
        task$calculation_time = Sys.time() - start_time
        task$STATUS = "finished"
        RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(task,auto_unbox = T, force = T))
        out = jsonlite::fromJSON(paste0("http://chemrichdb1.fiehnlab.ucdavis.edu/ocpu/tmp/",substr(result,11,21),"/R/.val/json"))
        return(list(success = TRUE, out = out, result_session = substr(result,1,21)))
      }else{
        # if error, change the status of the task to failed.
        url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/",task_id)
        task <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)
        task$end_time = Sys.time()
        task$calculation_time = Sys.time() - start_time
        task$STATUS = "failed"
        error = strsplit(result, "In call:")[[1]][1]
        task$ERROR = error

        RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(task,auto_unbox = T, force = T))
        # if error, put the error information to abib_task_error
        stop(error)
      }
    }else{
      # this means that this CALCULATE function is called every 1 minute.
      url <- paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/_design/task/_view/task")
      task <- jsonlite::fromJSON(URLencode(url), simplifyVector = T)
      # find the pending task.
      task$rows = task$rows[sapply(task$rows$value,function(x) x[[1]]) == 'pending',]
      # get task_is by checking if this task is DEPENDING on any task. If depending on a unfinished task, then we have to go with the first task that does not depend. Otherwise, go ahead.

      if(!nrow(task$rows)==0){
      DEPENDING = TRUE
      i = 1
      while(DEPENDING){
        if(anyNA(task$rows$value[[i]][[2]])){
          cat("go ahead");break;
        }else{

            if(nrow(task$rows[task$rows$id%in%task$rows$value[[i]][[2]][1:length(task$rows$value[[i]][[2]])],])==0){ # this means there is no DEPENDING task unfinished.
              cat("go ahead");break;
            }

        }

      }
      task_id = task$rows$id[i]

      cat("\n working on task: ");cat(task_id)
      # change status to calculating.
      url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/",task_id)
      task <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)
      start_time = Sys.time();task$start_time = start_time
      task$STATUS = "calculating"
      RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(task,auto_unbox = T, force = T))
      # do the actual calculation.
      result = RCurl::getURL(paste0("http://chemrichdb1.fiehnlab.ucdavis.edu/ocpu/library/Abib.alpha/R/",task$FUNCTION),
                             customrequest='POST',
                             httpheader=c('Content-Type'='application/json'),
                             postfields= jsonlite::toJSON(task$PARAMETER, auto_unbox = T)
      )
      if(length(grep("^/ocpu/tmp",result))==1){
        # if success, change the status of the task to finished.
        url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/",task_id)
        task <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)
        task$end_time = Sys.time()
        task$calculation_time = Sys.time() - start_time
        task$STATUS = "finished"
        RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(task,auto_unbox = T, force = T))

        # when calculation is finished. We need to save this to the abib_user_info MESSAGE[].
        url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info/",paste0(strsplit(task_id,"_68410298_")[[1]][c(1,2)],collapse = "_68410298_"))
        user_info <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)

        if(length(user_info$message)==0){
          user_info$message = list()
        }
        user_info$message[[length(user_info$message) + 1]] = list(
          title = "You have one task finished!",
          task_name = task$FUNCTION,
          task_parameter = task$PARAMETER
        )

        RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(user_info,auto_unbox = T, force = T))


      }else{
        # if error, change the status of the task to failed.
        url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/",task_id)
        task <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)
        task$end_time = Sys.time()
        task$calculation_time = Sys.time() - start_time
        task$STATUS = "failed"
        error = strsplit(result, "In call:")[[1]][1]
        task$ERROR = error
        RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(task,auto_unbox = T, force = T))
        # if error, put the error information to abib_task_error
        # when calculation is failed. We need to save this to the abib_user_info MESSAGE[].
        url <- paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info/",paste0(head(strsplit(task_id,"_68410298_")[[1]],-1),collapse = "_68410298_"))
        user_info <- jsonlite::fromJSON(URLencode(url), simplifyVector = F)

        if(length(user_info$message)==0){
          user_info$message = list()
        }

        user_info$message[[length(user_info$message) + 1]] = list(
          title = "Ooops. You have a task failed!",
          task_name = task$FUNCTION,
          task_parameter = task$PARAMETER
        )

        RCurl::getURL(URLencode(url),customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(user_info,auto_unbox = T, force = T))


        stop(error)
      }


    }else{
      cat("\n There is no task pending.")
    }
      }

  }else{
    # if usage is greater than 50%, put it on the queue.
    # just stop and return an error to alert user that the analysis is put on a queue.
    # we need to tell user how many jobs are ahead but I don't know how to do this right now.
    stop("Sorry. The server is busy. Your task is put in a queue of our database. We'll finish your request once our server is available, and then we'll prompt an notification to let you know.")

  }



  }


