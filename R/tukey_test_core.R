tukey_test_core = function(e,group1_index,group2_index,
                           num_group,
                           sp_square,
                           num_sample){ # Linear Models with R by Julia Faraway
  N1 = sum(group1_index)
  N2 = sum(group2_index)
  X1_bar = rowMeans(e[,group1_index])
  X2_bar = rowMeans(e[,group2_index])
  t = (X1_bar - X2_bar)/sqrt(sp_square * (1/N1 + 1/N2))
  p = ptukey(abs(t * sqrt(2)), num_group, num_sample-num_group, lower.tail = F)
  return(data.table(statistic=t,p=p))
}
