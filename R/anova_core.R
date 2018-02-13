anova_core = function(e,group_indexes,
                      type,
                      post_hoc_test_type){
  # with group, and expression data (e), we can start calculating F scores.
  if(type == "Welch"){#http://www.real-statistics.com/one-way-analysis-of-variance-anova/welchs-procedure/

    k = length(group_indexes)
    e_list = sapply(group_indexes, function(x) e[,x], simplify = F)
    n_list = sapply(group_indexes, sum)
    x_bar_list = sapply(e_list, function(x) rowMeans(x), simplify = F)
    s_square_list = mapply(function(x,y){ rowSums((x - y)^2/(ncol(x)-1))}, x = e_list, y = x_bar_list, SIMPLIFY = FALSE)
    w_list = mapply(function(n,s_square){n/s_square}, n = n_list, s_square = s_square_list, SIMPLIFY = FALSE)
    w = Reduce("+", w_list)
    x_bar = Reduce("+",mapply(function(w,x){w*x}, w = w_list, x = x_bar_list, SIMPLIFY = FALSE))/w
    top = 1/(k-1) * Reduce("+",mapply(function(w,x_square){w*x_square}, w = w_list, x_square = sapply(x_bar_list, function(x_j){(x_j - x_bar)^2}, simplify = FALSE), SIMPLIFY = F))
    bottom = 1 + 2*(k-2)/(k^2-1) * Reduce("+",mapply(function(n_j,w_j){(1/(n_j-1))*(1 - w_j/w)^2},n_j=n_list,w_j=w_list, SIMPLIFY = FALSE))
    f = top/bottom

    df1 = k - 1
    df2 = (k^2-1)/(3*Reduce("+",mapply(function(n_j,w_j){(1/(n_j-1))*(1 - w_j/w)^2},n_j=n_list,w_j=w_list, SIMPLIFY = FALSE)))


    p = 1 - pf(f, df1, df2)

    adjusted_p = p.adjust(p, 'fdr')

  }else{ #http://www.itl.nist.gov/div898/handbook/prc/section4/prc431.htm

    k = length(group_indexes)
    e_list = sapply(group_indexes, function(x) e[,x], simplify = F)
    n_list = sapply(group_indexes, sum)
    y_dot_dot = rowMeans(e)
    y_dot_list = sapply(e_list, function(x) rowMeans(x), simplify = F)

    SST = Reduce("+",mapply(function(n,y){n*(y-y_dot_dot)^2},n=n_list, y=y_dot_list, SIMPLIFY = FALSE))
    SS = rowSums((e - y_dot_dot)^2)
    SSE = SS - SST
    DFT = k - 1
    DFE = ncol(e) - k
    MST = SST/DFT
    MSE = SSE/DFE
    f = MST/MSE
    p = 1 - pf(f, DFT, DFE)

    adjusted_p = p.adjust(p, 'fdr')
  }
  result = data.table(statistic = f, ANOVA_p_value = p, adjusted_ANOVA_p_value = adjusted_p)

  # post hoc analysis result.
  post_hoc_result = list()
  if(post_hoc_test_type == "pairwise_t_test_with_no_correction"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = t_test_core(e,group_indexes_temp, type = type, direction = "two.sided")[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
  }else if(post_hoc_test_type == "pairwise_t_test_with_fdr"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = t_test_core(e,group_indexes_temp, type = type, direction = "two.sided")[,c(1,3)]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
    # post_hoc_result = apply(post_hoc_result,2,function(x){
    #   p.adjust(x, "fdr")
    # })
  }else if(grepl("pairwise_t_test_with_",post_hoc_test_type)){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      group_indexes_temp = list(group_indexes_combinations[1,i][[1]], group_indexes_combinations[2,i][[1]])
      post_hoc_result[[i]] = t_test_core(e,group_indexes_temp, type = type, direction = "two.sided")[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
    post_hoc_result = data.matrix(post_hoc_result)
    post_hoc_result[,seq(2,ncol(post_hoc_result),by=2)] = t(apply(post_hoc_result[,seq(2,ncol(post_hoc_result),by=2)], 1,function(x){
      p.adjust(x, method = tail(strsplit(post_hoc_test_type,"_")[[1]],1))
    }))
  }else if(post_hoc_test_type == "Games_Howell_test"){
    group_indexes_combinations = combn(group_indexes, 2)
    for(i in 1:ncol(group_indexes_combinations)){
      post_hoc_result[[i]] = Games_Howell_test_core(e,group1_index = group_indexes_combinations[1,i][[1]],group2_index = group_indexes_combinations[2,i][[1]],num_group = length(group_indexes))[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
  }else if(post_hoc_test_type == "tukey_test"){
    group_indexes_combinations = combn(group_indexes, 2)
    Ns = sapply(group_indexes, sum, simplify = FALSE)
    X_bars = sapply(group_indexes,function(x){
      rowMeans(e[,x])
    }, simplify = FALSE)
    s_squares = mapply(function(index, bar, n){
      rowSums((e[,index] - bar)^2)/(n-1)
    }, index = group_indexes, bar = X_bars, n = Ns, SIMPLIFY = FALSE)
    sp_square = Reduce("+",mapply(function(n, s){
      (n-1)*s
    }, n = Ns, s = s_squares, SIMPLIFY = FALSE))/(Reduce("+", Ns)-length(Ns))
    for(i in 1:ncol(group_indexes_combinations)){
      post_hoc_result[[i]] = tukey_test_core(e,group1_index = group_indexes_combinations[1,i][[1]],group2_index = group_indexes_combinations[2,i][[1]],num_group = length(group_indexes), sp_square = sp_square, num_sample = Reduce("+", Ns))[,1:2]
    }
    post_hoc_result = do.call("cbind",post_hoc_result)
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
