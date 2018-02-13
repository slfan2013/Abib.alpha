mutiple_linear_regression_core = function(e,X){

  pacman::p_load(data.table)
  # http://reliawiki.org/index.php/Multiple_Linear_Regression_Analysis

  ys = split(t(e), rep(1:nrow(e), each = ncol(e)))
  tX = t(X)
  inv_tX_X = solve(t(X)%*%X)
  H = X%*%inv_tX_X%*%tX
  H = X%*%solve(t(X)%*%X)%*%t(X)
  n = nrow(X)
  I=diag(n)
  k = ncol(X)-1

  # y = ys[[2]]
  PVAL = sapply(ys, function(y){
    beta = inv_tX_X%*%tX%*%y
    SSe = t(y)%*%(I - H)%*%y
    MSe = SSe/(n - k - 1)
    C = sqrt(diag((MSe)[1,1] * inv_tX_X))
    t = beta[,1]/C
    (1-pt(abs(t), df = n - k-1))*2
  })

  PVAL = t(PVAL)

  # dta = data.frame(value = ys[[2]], X[,-1])
  # summary(lm(value~., data = dta))$coefficient[,4]

  result = data.table(PVAL)



  return(result)
}
