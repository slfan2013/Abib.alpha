paired_t_test_core = function(e,group_indexes,
                              direction,
                              id_index){
  pacman::p_load(data.table)

  group1_index = group_indexes[[1]]
  group2_index = group_indexes[[2]]
  # with group, and expression data (e), we can start calculating t scores.
  # https://en.wikipedia.org/wiki/Student%27s_t-test#Unpaired_and_paired_two-sample_t-tests
  e1 = e[,group1_index]
  e2 = e[,group2_index]
  e1_sorted = e1[,order(id_index[group1_index])]
  e2_sorted = e2[,order(id_index[group2_index])]
  e_diff = e1_sorted - e2_sorted
  n = ncol(e_diff)
  X_D = rowMeans(e_diff)
  mu_0 = 0
  s_D_square = rowSums((e_diff - X_D)^2)/(n-1)
  t = (X_D - mu_0)/sqrt(s_D_square/n)
  df = n - 1

  # calculate p values
  if(direction == "two.sided"){
    p = pt(-abs(t),df)*2
  }else if(direction == "greater"){ # alternative is level[1] > level[2]
    p = pt(t,df, lower.tail = F)
  }else{
    p = pt(t,df, lower.tail = T)
  }

  # calculate adjusted p value
  adjusted_p = p.adjust(p, 'fdr')

  result = data.table(t=t,p=p,adjusted_p =  adjusted_p)
  names(result) = c("statistic", paste0("p value: ",paste0(names(group_indexes), collapse=' vs ')),paste0("adjusted p value: ",paste0(names(group_indexes), collapse=' vs ')))
  return(result)
}
