conditional_mutiple_logistic_regression_core = function(e,p_var,p_confounding_var,p_strata){

  pacman::p_load(data.table, survival)

  if(nrow(p_confounding_var)==0){
    dta = data.table(value = 0, y = as.numeric(factor(p_var))-1, p_strata = p_strata)
  }else{
    dta = data.table(value = 0, y = as.numeric(factor(p_var))-1, p_confounding_var, p_strata = p_strata)
  }

  PVAL = list()
  beta = list()
  # http://rcompanion.org/rcompanion/e_07.html
  for(i in 1:nrow(e)){
    dta$value = e[i,]
    model.summary = tryCatch(summary(

      clogit(y ~ . -  p_strata + strata(p_strata), data = dta)


      # glm(y ~ .,
      #                                    data=dta,
      #                                    na.action = NULL,
      #                                    family = binomial(link="logit")


    ),error = function(e) NA)
    if(class(model.summary)=="logical"){# means model.summary is NA
      PVAL[[i]] = NA
      beta[[i]] = NA
    }else{
      PVAL[[i]] = model.summary$coefficients[,5]
      beta[[i]] = model.summary$coefficients[,1]
    }

  }

  PVAL = do.call(rbind,PVAL)
  beta = do.call(rbind,beta)
  PVAL = PVAL[,"value"]
  beta = beta[,"value"]
  odds_ratio = exp(beta)

  result = data.table(PVAL, odds_ratio)
  colnames(result) = c("p value", "odds_ratio")


  return(result)
}
