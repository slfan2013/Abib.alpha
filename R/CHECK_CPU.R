CHECK_CPU = function(){
  # check if CPU ok.
  if(Sys.info()['sysname'] == "Windows"){
    sys_info <- system("wmic path Win32_PerfFormattedData_PerfProc_Process get Name,PercentProcessorTime", intern = TRUE)
    df <- do.call(rbind, lapply(strsplit(sys_info, " "), function(x) {x <- x[x != ""];data.frame(process = x[1], cpu = x[2])}))
    num_processor_occupied = sum(grepl("Rgui|rstudio", df$process))
  }else{
    sys_info <- strsplit(system("ps -C rsession -o %cpu,%mem,pid,cmd", intern = TRUE), " ")
    if(is.list(sys_info)){
      num_processor_occupied = -1
    }else{
      df <- do.call(rbind, lapply(sys_info[-1],
                                  function(x) data.frame(
                                    cpu = as.numeric(x[2]),
                                    mem = as.numeric(x[4]),
                                    pid = as.numeric(x[5]),
                                    cmd = paste(x[-c(1:5)], collapse = " "))))
      num_processor_occupied = nrow(df)
    }

  }
  return(num_processor_occupied < parallel::detectCores() * .75)
}
