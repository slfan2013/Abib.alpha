nonparametric_t_test_core = function(e,group_indexes,
                       direction){
  #https://github.com/wch/r-source/blob/trunk/src/library/stats/R/wilcox.test.R#L307
  pacman::p_load(data.table)

  group1_index = group_indexes[[1]]
  group2_index = group_indexes[[2]]

  # r <- rank(c(x - mu, y))
  r <-  t(apply(e[,c(which(group1_index),which(group2_index))], 1, function(x){rank(x, na.last = "keep")}))
  n.x <- sum(group1_index)
  n.y <- sum(group2_index)
  STATISTIC <- rowSums(r[,seq_along(1:n.x)]) - n.x * (n.x + 1) / 2

  # TIES <- (length(r) != length(unique(r)))
  TIES = apply(r, 1, function(x){length(x)!=length(unique(x))})


  p = switch(direction,
                   "two.sided" = {
                     p <- ifelse(STATISTIC > (n.x * n.y / 2),
                                 pwilcox(STATISTIC - 1, n.x, n.y, lower.tail = FALSE),
                                 pwilcox(STATISTIC, n.x, n.y))
                     pmin(2 * p, 1)
                    },
                   "greater" = {
                     pwilcox(STATISTIC - 1, n.x, n.y, lower.tail = FALSE)
                   },
                   "less" = pwilcox(STATISTIC, n.x, n.y))

  if(sum(TIES)==1){
    NTIES <- table(r)
  }else{
    NTIES <- apply(r[TIES,], 1, function(x) table(x))
  }



  statistic = STATISTIC - n.x * n.y / 2 # indicates changing direction: increasing or decreasing

  if(class(NTIES) == "list"){
    z <- STATISTIC[TIES] - n.x * n.y / 2
    SIGMA <- sqrt((n.x * n.y / 12) *
                    ((n.x + n.y + 1)
                     - sapply((sapply(NTIES, function(x) (x^3-x))), sum)
                     / ((n.x + n.y) * (n.x + n.y - 1))))
  }else if(class(NTIES)=="matrix"){
    z <- STATISTIC[TIES] - n.x * n.y / 2
    SIGMA <- sqrt((n.x * n.y / 12) *
                    ((n.x + n.y + 1)
                     - apply((apply(NTIES, 2,function(x) (x^3-x))),2, sum)
                     / ((n.x + n.y) * (n.x + n.y - 1))))
  }else{
    z = STATISTIC
    SIGMA <- sqrt((n.x * n.y / 12) *
                    (n.x + n.y + 1))
  }




  CORRECTION <- switch(direction,
                         "two.sided" = sign(z) * 0.5,
                         "greater" = 0.5,
                         "less" = -0.5)

  z <- (z - CORRECTION) / SIGMA
  PVAL <- switch(direction,
                 "less" = pnorm(z),
                 "greater" = pnorm(z, lower.tail=FALSE),
                 "two.sided" = 2 * pmin(pnorm(z),
                                       pnorm(z, lower.tail=FALSE)))

if(sum(TIES)==1){
  p[TIES] = wilcox.test(e[TIES,group1_index],e[TIES,group2_index])$p.value
}else{
  p[TIES] = PVAL
}





  adjusted_p = p.adjust(p, 'fdr')


  result = data.table(statistic = statistic, p=p,adjusted_p=adjusted_p)

  names(result) = c("statistic",paste0("p value: ",paste0(names(group_indexes), collapse=' vs ')),paste0("adjusted p value: ",paste0(names(group_indexes), collapse=' vs ')))


  return(result)
}


