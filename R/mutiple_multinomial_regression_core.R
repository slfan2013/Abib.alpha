mutiple_multinomial_regression_core = function(e,p_var,p_confounding_var){

  pacman::p_load(data.table, nnet, car, lsmeans)


  if(nrow(p_confounding_var)==0){
    dta = data.table(value = NA, y = p_var)
  }else{
    dta = data.table(value = NA, y = p_var, p_confounding_var)
  }



  PVAL = c()
  beta = list()
  # http://rcompanion.org/rcompanion/e_07.html
  for(i in 1:nrow(e)){
    dta$value = e[i,]
    fit = tryCatch(multinom(y ~ .,
                     data=dta,
                     na.action = NULL
    ), error = function(e) NA)

    if(class(fit)=="logical"){# means model.summary is NA
      PVAL[i] = NA
      beta[[i]] = NA
    }else{ #https://stats.stackexchange.com/questions/63222/getting-p-values-for-multinom-in-r-nnet-package
      PVAL[i] = Anova(fit)["value","Pr(>Chisq)"]
    }

  }


  pairewise_result = list()
  pairwise_combination = combn(levels(p_var),2)

  for(i in 1:ncol(pairwise_combination)){
    l1 = pairwise_combination[1,i]
    l2 = pairwise_combination[2,i]
    e. = e[, p_var %in% c(l1, l2)]
    p_var. = p_var[p_var%in%c(l1,l2)]
    if(nrow(p_confounding_var)==0){
      p_confounding_var. = p_confounding_var
    }else{
      p_confounding_var. = p_confounding_var[p_var%in%c(l1,l2),]
    }
    pairewise_result[[i]] = mutiple_logistic_regression_core(e., p_var., p_confounding_var.)
  }

  names(pairewise_result) = paste0(pairwise_combination[1,]," vs ",pairwise_combination[2,])

  for(i in 1:length(pairewise_result)){
    colnames(pairewise_result[[i]]) = paste0(names(pairewise_result)[i]," ",colnames(pairewise_result[[i]]))
  }

  pairewise_result = do.call(cbind,pairewise_result)



  result = data.table(`multinomial p value` = PVAL, pairewise_result)


  return(result)
}
