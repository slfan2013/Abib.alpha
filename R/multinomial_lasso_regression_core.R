multinomial_lasso_regression_core = function(e,var,alpha){

  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5*min(e[i,!is.na(e[i,])])
  }


  cvfit = cv.glmnet(t(e), var, alpha = alpha, family = "multinomial")
  fit = glmnet(t(e), var, alpha = alpha, family = "multinomial")




  result = cbind(coef(fit, s = cvfit$lambda.min), coef(fit, s = cvfit$lambda.1se))

  result = data.table(as.matrix(result))

  colnames(result) = c("coefficient with min cv lambda", "coefficient with 1se cv lambda")



  return(list(result = result, cvfit = cvfit, fit = fit))
}
