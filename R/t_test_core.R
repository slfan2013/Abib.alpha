t_test_core = function(e,group_indexes,
                       type,
                       direction){
  pacman::p_load(data.table)

  group1_index = group_indexes[[1]]
  group2_index = group_indexes[[2]]


  # with group, and expression data (e), we can start calculating t scores.
  if(type == "Welch"){#https://en.wikipedia.org/wiki/Welch%27s_t-test
    N1 = sum(group1_index)
    N2 = sum(group2_index)
    X1_bar = rowMeans(e[,group1_index])
    X2_bar = rowMeans(e[,group2_index])
    s1_square = rowSums((e[,group1_index] - X1_bar)^2)/(N1-1)
    s2_square = rowSums((e[,group2_index] - X2_bar)^2)/(N2-1)
    t = (X1_bar - X2_bar)/sqrt(s1_square/N1 + s2_square/N2)
    df = (s1_square/N1 + s2_square/N2)^2/(s1_square^2/N1^2/(N1-1) + s2_square^2/N2^2/(N2-1))
  }else{ #https://en.wikipedia.org/wiki/Student%27s_t-test
    N1 = sum(group1_index)
    N2 = sum(group2_index)
    X1_bar = rowMeans(e[,group1_index])
    X2_bar = rowMeans(e[,group2_index])
    s1_square = rowSums((e[,group1_index] - X1_bar)^2)/(N1-1)
    s2_square = rowSums((e[,group2_index] - X2_bar)^2)/(N2-1)
    sp_square = ((N1-1)*s1_square + (N2-1)*s2_square)/(N1+N2-2)
    t = (X1_bar - X2_bar)/sqrt(sp_square * (1/N1 + 1/N2))
    df = N1+N2-2
  }


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


  result = data.table(t_score=t,p=p,adjusted_p=adjusted_p)

  names(result) = c("statistic", paste0("p value: ",paste0(names(group_indexes), collapse=' vs ')),paste0("adjusted p value: ",paste0(names(group_indexes), collapse=' vs ')))


  return(result)
}
