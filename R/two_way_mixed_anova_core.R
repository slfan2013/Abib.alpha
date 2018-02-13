two_way_mixed_anova_core = function(e,group1, group2,levels1, levels2,id_index,
                              # main_effect_1_type = "Welch",
                              main_effect_1_post_hoc_test_type = "pairwise_paired_t_test_with_fdr",
                              main_effect_2_type = "Welch",
                              main_effect_2_post_hoc_test_type = "Games_Howell_test",
                              # simple_main_effect_1_type = "Welch",
                              simplemain_effect_1_post_hoc_test_type = "pairwise_paired_t_test_with_fdr",
                              simple_main_effect_2_type = "Welch",
                              simplemain_effect_2_post_hoc_test_type = "Games_Howell_test",
                              sphericity_correction = TRUE
){
  # http://www.itl.nist.gov/div898/handbook/prc/section4/prc437.htm
  pacman::p_load(ez, parallel)
  group1_indexes = sapply(levels1, function(x) group1%in%x, simplify = F)
  group2_indexes = sapply(levels2, function(x) group2%in%x, simplify = F)

  id = id_index
  two_way_mixed_anova_p_value = c()


  # determine how many cores I can use.
  if(Sys.info()['sysname'] == "Windows"){
    sys_info <- system("wmic path Win32_PerfFormattedData_PerfProc_Process get Name,PercentProcessorTime", intern = TRUE)
    df <- do.call(rbind, lapply(strsplit(sys_info, " "), function(x) {x <- x[x != ""];data.frame(process = x[1], cpu = x[2])}))
    num_processor_occupied = sum(grepl("Rgui|rstudio", df$process))
  }else{
    # sys_info <- strsplit(system("ps -C rsession -o %cpu,%mem,pid,cmd", intern = TRUE), " ")
    # df <- do.call(rbind, lapply(sys_info[-1],
    #                             function(x) data.frame(
    #                               cpu = as.numeric(x[2]),
    #                               mem = as.numeric(x[4]),
    #                               pid = as.numeric(x[5]),
    #                               cmd = paste(x[-c(1:5)], collapse = " "))))
    # num_processor_occupied = nrow(df)

    sys_info <- system("ps -aux | less", intern = TRUE)

    num = sum(sapply(sys_info, function(x){
      grepl("slave",x)
    }))

    num_processor_occupied = 24 - num
    if(num_processor_occupied < 1){
      stop("Sorry, all cores are occupied. Please wait and resubmit. We apologize for the inconvenience.")
    }

  }
  num_cores = max(min(20 - 1 - num_processor_occupied,4),1) # limit the number of cores to less than 8 but greater than 1.

  if(length(levels(group1))==2){# when two groups in the repeated factor, there is no Sphericity Corrections.
    cl = makeCluster(num_cores)
    two_way_mixed_anova_p_value = parSapply(cl = cl, 1:nrow(e), FUN = function(i,e,id,group1,group2,ezANOVA){
      # for(i in 1:nrow(e)){
      dta = data.frame(value = e[i,], id = id, group1 = group1, group2 = group2)
      tryCatch(ezANOVA(data = dta, dv = value, wid = id, within = .(group1),between = .(group2), type = 2)$ANOVA["4","p"], error = function(e){NA})
      # }
    },e,id,group1,group2,ezANOVA)
    stopCluster(cl)
  }else{
    cl = makeCluster(num_cores)
    two_way_mixed_anova_p_value = parSapply(cl = cl, 1:nrow(e), FUN = function(i,e,id,group1,group2,ezANOVA){
      # for(i in 1:nrow(e)){
      dta = data.frame(value = e[i,], id = id, group1 = group1, group2 = group2)
      tryCatch(ezANOVA(data = dta, dv = value, wid = id, within = .(group1),between = .(group2), type = 2)$`Sphericity Corrections`["4","p[HF]"], error = function(e){NA})
      # }
    },e,id,group1,group2,ezANOVA)
    stopCluster(cl)
  }


  two_way_mixed_anova_p_value_fdr = p.adjust(two_way_mixed_anova_p_value, 'fdr')




  # main effect 1
  if(length(group1_indexes) == 2){
    anova1_core = paired_t_test_core(e, group1_indexes, direction = "two.sided", id_index = id)
  }else{
    anova1_core = repeated_anova_core(e, group1_indexes,id_index,sphericity_correction = sphericity_correction, post_hoc_test_type = main_effect_1_post_hoc_test_type)
  }
  # main effect 2
  if(length(group2_indexes) == 2){
    anova2_core = t_test_core(e, group2_indexes, type = main_effect_2_type, direction = "two.sided")
  }else{
    anova2_core = anova_core(e, group2_indexes, type = main_effect_2_type, post_hoc_test_type = main_effect_2_post_hoc_test_type)
  }

  # simple main effect 1 (at each level of group2)
  simple_main_effect_1 = list()
  for(i in 1:length(group2_indexes)){
    index = group2_indexes[[i]]
    e. = e[,index]
    id. = id[index]
    group1_indexes. = sapply(group1_indexes, function(x){
      x[index]
    }, simplify = FALSE)
    if(length(group1_indexes)==2){
      simple_main_effect_1[[i]] = paired_t_test_core(e., group1_indexes., direction = "two.sided", id_index = id.)
      colnames(simple_main_effect_1[[i]]) = paste0(names(simple_main_effect_1[[i]]), " @", names(group2_indexes[i]))
    }else{
      simple_main_effect_1[[i]] = repeated_anova_core(e., group1_indexes., id.,sphericity_correction = sphericity_correction, post_hoc_test_type = simplemain_effect_1_post_hoc_test_type)
      colnames(simple_main_effect_1[[i]]) = paste0(names(simple_main_effect_1[[i]]), " @", names(group2_indexes[i]))
    }
  }
  simple_main_effect_1 = do.call(cbind,simple_main_effect_1)
  # simple main effect 2 (at each level of group1)
  simple_main_effect_2 = list()
  for(i in 1:length(group1_indexes)){
    index = group1_indexes[[i]]
    e. = e[,index]
    group2_indexes. = sapply(group2_indexes, function(x){
      x[index]
    }, simplify = FALSE)
    if(length(group2_indexes)==2){
      simple_main_effect_2[[i]] = t_test_core(e., group2_indexes., type = simple_main_effect_2_type, direction = "two.sided")
      colnames(simple_main_effect_2[[i]]) = paste0(names(simple_main_effect_2[[i]]), " @", names(group1_indexes[i]))
    }else{
      simple_main_effect_2[[i]] = anova_core(e., group2_indexes., type = simple_main_effect_2_type, post_hoc_test_type = simplemain_effect_2_post_hoc_test_type)
      colnames(simple_main_effect_2[[i]]) = paste0(names(simple_main_effect_2[[i]]), " @", names(group1_indexes[i]))
    }
  }
  simple_main_effect_2 = do.call(cbind,simple_main_effect_2)

  result = data.table(two_way_mixed_anova_p_value = two_way_mixed_anova_p_value,
                      adjusted_two_way_mixed_anova_p_value = two_way_mixed_anova_p_value_fdr,
                      anova1_core, anova2_core, simple_main_effect_1, simple_main_effect_2)



  return(result)
}
