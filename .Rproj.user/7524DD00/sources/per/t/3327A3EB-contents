boxplot_ = function(
  project_ID="a1_68410298_1515699302308",
  expression_id="expression_data_68410298_1515699302308_csv",
  factor1="treatment",
  levels1=c("MeOH-frz","ACN.IPA-frz","MeOH.CHCl3-frz", "MeOH.CHCl3-lyph"),
  two_factor=TRUE,
  factor2="treatment",
  levels2=c("MeOH-frz","ACN.IPA-frz","MeOH.CHCl3-frz", "MeOH.CHCl3-lyph")
){
  pacman::p_load(data.table, plotly, webshot)

  # make _csv to .csv.
  expression_name = gsub("_xlsx",".xlsx",gsub("_csv",".csv",expression_id))
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  if(grepl(".xlsx",expression_name)){
    e = read.xlsx(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)))
    # colnames(e) = gsub("\\."," ",colnames(e))
    e = data.table(e)
  }else{
    e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
    # e = fread("e.csv")
  }
  # read sample info
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/sample_info_68410298",strsplit(project_ID,"_68410298")[[1]][2],".csv")),header=T,strip.white=F)
  # p = fread("p.csv")


  group1 = p[[factor1]]
  group1 = factor(group1, levels = c(levels1))

  group2 = p[[factor2]]
  group2 = factor(group2, levels = c(levels2))

  # subsetting to get only two groups.
  index = !is.na(group1) & !is.na(group2)
  included_label = p[['label']][index]
  compound_label = e$label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }

  group1 = group1[index]
  group2 = group2[index]




  if(!two_factor){

    dta = data.table(value = e[4,], class = group1)
    plot = plot_ly(dta, y = ~value, color = ~class, type = "box",  boxpoints = "all")

    export(plot, file = "test.png")

    htmlwidgets::saveWidget(as_widget(plot), "test.html")

  }
}



















