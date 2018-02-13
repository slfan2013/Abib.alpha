preview_edit_file = function(input){
  pacman::p_load(data.table)

  input = gsub("\r","",input)
  cfile = strsplit(input,"\n")[[1]]
  df = as.data.table(do.call(rbind,lapply(cfile,function(x){strsplit(x,"\t")[[1]]})),stringsAsFactors = F)
  colnames(df) = as.character(df[1,])
  df = df[-1,]


  for(i in 1:ncol(df)){
    temp = df[[i]]
    temp = temp[!is.na(temp)]
    if(sum(!is.na(as.numeric(temp)))==length(temp)){
      df[[i]] = as.numeric(df[[i]])
    }

  }

  return(df)


}
