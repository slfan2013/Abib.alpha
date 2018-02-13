Games_Howell_test_core = function(e,group1_index,group2_index,
                                  num_group){# https://rpubs.com/aaronsc32/games-howell-test
  N1 = sum(group1_index)
  N2 = sum(group2_index)
  X1_bar = rowMeans(e[,group1_index])
  X2_bar = rowMeans(e[,group2_index])
  s1_square = rowSums((e[,group1_index] - X1_bar)^2)/(N1-1)
  s2_square = rowSums((e[,group2_index] - X2_bar)^2)/(N2-1)
  t = (X1_bar - X2_bar)/sqrt(s1_square/N1 + s2_square/N2)
  df = (s1_square/N1 + s2_square/N2)^2/(s1_square^2/N1^2/(N1-1) + s2_square^2/N2^2/(N2-1))
  p = ptukey(abs(t * sqrt(2)), num_group, df, lower.tail = F)
  return(data.table(statistic=t,p=p))
}
