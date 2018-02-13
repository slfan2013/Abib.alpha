nonparametric_paired_t_test_core = function(e,group_indexes,
                                     direction,id_index){
  #https://github.com/wch/r-source/blob/trunk/src/library/stats/R/wilcox.test.R#L307
  pacman::p_load(data.table)

  group1_index = group_indexes[[1]]
  group2_index = group_indexes[[2]]

  e1 = e[, group1_index]
  e2 = e[, group2_index]
  e1_sorted = e1[,order(id_index[group1_index])]
  e2_sorted = e2[,order(id_index[group2_index])]

  # OK <- complete.cases(x, y)
  # x <- x[OK] - y[OK]
  e_diff = e1 - e2

  CORRECTION <- 0

  # n <- as.double(length(x))
  n <- as.double(ncol(e_diff))

  # r <- rank(abs(x))
  r = t(apply(e_diff, 1, function(x) rank(abs(x), na.last = "keep")))



  # STATISTIC <- setNames(sum(r[x > 0]), "V")

  # length(split(t(e_diff), rep(1:nrow(e_diff), each = ncol(x))))
  e_diff_greater_than_0_index = e_diff>0
  e_diff_greater_than_0_index = split(t(e_diff_greater_than_0_index), rep(1:nrow(e_diff_greater_than_0_index), each = ncol(e_diff_greater_than_0_index)))

  STATISTIC = mapply(function(r., x) { sum(r.[x>0]) },
         r. = split(t(r), rep(1:nrow(r), each = ncol(r))),
         x = e_diff_greater_than_0_index)



  # TIES <- (length(r) != length(unique(r)))
  TIES = apply(r, 1, function(x){length(x)!=length(unique(x))})

  # PVAL <-
  #   switch(alternative,
  #          "two.sided" = {
  #            p <- if(STATISTIC > (n * (n + 1) / 4))
  #              psignrank(STATISTIC - 1, n, lower.tail = FALSE)
  #            else psignrank(STATISTIC, n)
  #            min(2 * p, 1)
  #          },
  #          "greater" = psignrank(STATISTIC - 1, n, lower.tail = FALSE),
  #          "less" = psignrank(STATISTIC, n))
  PVAL <-
    switch(direction,
           "two.sided" = {
             p <- ifelse(STATISTIC > (n * (n + 1) / 4), {psignrank(STATISTIC - 1, n, lower.tail = FALSE)},{psignrank(STATISTIC, n)})

             pmin(2 * p, 1)
           },
           "greater" = psignrank(STATISTIC - 1, n, lower.tail = FALSE),
           "less" = psignrank(STATISTIC, n))
#
#

  # NTIES <- table(r)
  # z <- STATISTIC - n * (n + 1)/4
  # SIGMA <- sqrt(n * (n + 1) * (2 * n + 1) / 24
  #               - sum(NTIES^3 - NTIES) / 48)
  # if(correct) {
  #   CORRECTION <-
  #     switch(alternative,
  #            "two.sided" = sign(z) * 0.5,
  #            "greater" = 0.5,
  #            "less" = -0.5)
  #   METHOD <- paste(METHOD, "with continuity correction")
  # }
  # z <- (z - CORRECTION) / SIGMA
  # PVAL <- switch(alternative,
  #                "less" = pnorm(z),
  #                "greater" = pnorm(z, lower.tail=FALSE),
  #                "two.sided" = 2 * min(pnorm(z),
  #                                      pnorm(z, lower.tail=FALSE)))

  statistic = STATISTIC
  if(sum(TIES)>1){
    NTIES = apply(r[TIES,], 1, table)
  }else{
    NTIES = list(table(r[TIES,]))
  }

  if(length(NTIES)>0 & length(NTIES[[1]])>0){
    z <- STATISTIC[TIES] - n * (n + 1)/4
    if(class(NTIES) == "matrix"){
      SIGMA <- sqrt(n * (n + 1) * (2 * n + 1) / 24 - apply(NTIES,2,function(x) sum(x^3 - x)) / 48)
    }else{
      SIGMA <- sqrt(n * (n + 1) * (2 * n + 1) / 24 - sapply(NTIES,function(x) sum(x^3 - x)) / 48)
    }

    CORRECTION <-
      switch(direction,
             "two.sided" = sign(z) * 0.5,
             "greater" = 0.5,
             "less" = -0.5)
    z <- (z - CORRECTION) / SIGMA
    p <- switch(direction,
                "less" = pnorm(z),
                "greater" = pnorm(z, lower.tail=FALSE),
                "two.sided" = 2 * pmin(pnorm(z),pnorm(z, lower.tail=FALSE)))
    PVAL[TIES] = p
    statistic[TIES] = z
  }


  p = PVAL


  adjusted_p = p.adjust(p, 'fdr')


  result = data.table(statistic = statistic, p=p,adjusted_p=adjusted_p)

  names(result) = c("statistic", paste0("p value: ",paste0(names(group_indexes), collapse=' vs ')),paste0("adjusted p value: ",paste0(names(group_indexes), collapse=' vs ')))


  return(result)
}


