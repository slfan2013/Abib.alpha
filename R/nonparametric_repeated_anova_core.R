nonparametric_repeated_anova_core = function(e,group_indexes,
                               id_index,
                               post_hoc_test_type){
  # https://github.com/SurajGupta/r-source/blob/master/src/library/stats/R/friedman.test.R


  # groups <- factor(c(col(y)))
  # blocks <- factor(c(row(y)))

  # k <- nlevels(groups)
  k = length(group_indexes)
  n = length(levels(id_index))
  e_list_by_id = sapply(levels(id_index), function(x) e[,id_index%in%x], simplify = F)

  r_list = sapply(e_list_by_id, function(x){
    t(apply(x, 1, function(x) rank(x, na.last = "keep")))
  }, simplify = FALSE)


  # STATISTIC <- ((12 * sum((colSums(r) - n * (k + 1) / 2)^2)) /
  #                 (n * k * (k + 1)
  #                  - (sum(unlist(lapply(TIES, function (u) {u^3 - u}))) /
  #                       (k - 1))))
  r_list_array = array(unlist(r_list), dim = c(nrow(r_list[[1]]),ncol(r_list[[1]]),length(r_list)))

  # TIES <- tapply(c(r), row(r), table)
  TIES = apply(r_list_array, 1, function(x){
    apply(x,2,table)
  })


  no_TIES_index = sapply(TIES, class) == "matrix"
  # STATISTIC <- ((12 * sum((colSums(r) - n * (k + 1) / 2)^2)) /
  #                 (n * k * (k + 1)
  #                  - (sum(unlist(lapply(TIES., function (u) {u^3 - u}))) /
  #                       (k - 1))))
  STATISTIC  = rep(NA, nrow(e))

  STATISTIC = rowSums((t(apply(r_list_array, 1, function(x){
    rowSums(x)
  })) - n * (k+1)/2)^2)*12/(n * k * (k + 1))

  if(sum(no_TIES_index)>0){
    STATISTIC[!no_TIES_index] = rowSums((t(apply(r_list_array[!no_TIES_index,,], 1, function(x){
      rowSums(x)
    })) - n * (k+1)/2)^2)*12/(n * k * (k + 1)
                              - (sapply(TIES[!no_TIES_index], function(x) sum(unlist(lapply(x, function (u) {u^3 - u})))) /
                                   (k - 1)))

  }




  PARAMETER <- k - 1
  p <- pchisq(STATISTIC, PARAMETER, lower.tail = FALSE)


  adjusted_p = p.adjust(p, 'fdr')

  result = data.table(statistic = STATISTIC, repeated_ANOVA_p_value = p, adjusted_repeated_ANOVA_p_value = adjusted_p)

  # post hoc analysis result.
  post_hoc_result = list()
  if(post_hoc_test_type == "pairwise_nonparametric_paired_t_test_with_no_correction"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = nonparametric_paired_t_test_core(e,group_indexes_temp, direction = "two.sided", id_index)[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
  }else if(post_hoc_test_type == "pairwise_nonparametric_paired_t_test_with_fdr"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = nonparametric_paired_t_test_core(e,group_indexes_temp, direction = "two.sided", id_index)[,c(1,3)]
      }
    post_hoc_result = do.call("cbind",post_hoc_result)
  }else if(grepl("pairwise_nonparametric_paired_t_test_with_",post_hoc_test_type)){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = nonparametric_paired_t_test_core(e,group_indexes_temp, direction = "two.sided", id_index)[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
    post_hoc_result = data.matrix(post_hoc_result)
    post_hoc_result[,seq(2,ncol(post_hoc_result),by=2)] = t(apply(post_hoc_result[,seq(2,ncol(post_hoc_result),by=2)], 1,function(x){
      p.adjust(x, method = tail(strsplit(post_hoc_test_type,"_")[[1]],1))
    }))
  }

  if(nrow(post_hoc_result) == 1){
    post_hoc_result = t(post_hoc_result)
  }

  post_hoc_result = data.table(post_hoc_result)
  colnames(post_hoc_result)[seq(2,ncol(post_hoc_result),by=2)] = paste0("p value: ",apply(combn(length(group_indexes), 2),2,function(x){
    paste0(names(group_indexes)[x[1]]," vs ",names(group_indexes)[x[2]])
  }))
  colnames(post_hoc_result)[seq(1,ncol(post_hoc_result),by=2)] = paste0("statistic: ",apply(combn(length(group_indexes), 2),2,function(x){
    paste0(names(group_indexes)[x[1]]," vs ",names(group_indexes)[x[2]])
  }))
  result = data.table(result, post_hoc_result)
  return(result)
}
