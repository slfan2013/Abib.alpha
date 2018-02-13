fold_change_core = function(e,group_indexes, type){
  pacman::p_load(data.table)


  e_list = sapply(group_indexes, function(x) e[,x], simplify = F)

  if(type == "mean"){
    e_avg = sapply(e_list,rowMeans, simplify = FALSE)
  }else{# median
    e_avg = sapply(e_list,function(x) apply(x,1,median, na.rm=T), simplify = FALSE)
  }

  group_indexes_combinations = combn(1:length(group_indexes), 2)

  result = apply(group_indexes_combinations, 2, function(x){
    e_avg[[x[1]]]/e_avg[[x[2]]]
  })
  result = data.table(result)
  colnames(result) = paste0(type," fold change: ",apply(combn(1:length(group_indexes),2), 2, function(x) paste0(names(group_indexes)[x[1]]," / ",names(group_indexes)[x[2]])))




  return(result)
}
