nonparametric_anova_core = function(e,group_indexes,
                      post_hoc_test_type){
# https://github.com/SurajGupta/r-source/blob/master/src/library/stats/R/kruskal.test.R

  # k <- nlevels(g)
  k = length(group_indexes)
  # n <- length(x)
  n = ncol(e)

  # r <- rank(x)
  r = t(apply(e, 1, rank, na.last = 'keep'))

  # TIES <- table(x)
  TIES = apply(e, 1, table)

  # STATISTIC <- sum(tapply(r, g, "sum")^2 / tapply(r, g, "length"))
  e_list = sapply(group_indexes, function(x) e[,x], simplify = F)
  n_list = sapply(group_indexes, sum)

  r_list = sapply(group_indexes, function(x) r[,x], simplify = F)

  STATISTIC_numerator = sapply(r_list, function(a){
    apply(a, 1, function(b){
      sum(b)^2
    })
  }, simplify = FALSE)

  STATISTIC = Reduce("+",mapply(function(num,n){
    num/n
  }, num = STATISTIC_numerator, n = n_list, SIMPLIFY = FALSE))


  # STATISTIC <- ((12 * STATISTIC / (n * (n + 1)) - 3 * (n + 1)) /
  #                 (1 - sum(TIES^3 - TIES) / (n^3 - n)))
  STATISTIC <- ((12 * STATISTIC / (n * (n + 1)) - 3 * (n + 1)) /
                  (1 - sapply(TIES, function(x) sum(x^3-x)) / (n^3 - n)))

  PARAMETER <- k - 1L

  PVAL <- pchisq(STATISTIC, PARAMETER, lower.tail = FALSE)

  p = PVAL
  adjusted_p = p.adjust(p, 'fdr')

  result = data.table(statistic =STATISTIC ,ANOVA_p_value = p, adjusted_ANOVA_p_value = adjusted_p)

  # post hoc analysis result.
  post_hoc_result = list()
  if(post_hoc_test_type == "pairwise_nonparametric_t_test_with_no_correction"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = nonparametric_t_test_core(e,group_indexes_temp, direction = "two.sided")[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
  }else if(post_hoc_test_type == "pairwise_nonparametric_t_test_with_fdr"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = nonparametric_t_test_core(e,group_indexes_temp, direction = "two.sided")[,c(1,3)]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
    # post_hoc_result = apply(post_hoc_result,2,function(x){
    #   p.adjust(x, "fdr")
    # })
  }else if(grepl("pairwise_nonparametric_t_test_with_",post_hoc_test_type)){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = nonparametric_t_test_core(e,group_indexes_temp, direction = "two.sided")[,1:2]
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
