repeated_anova = function(project_ID = "b3_68410298_1515281598316",
                 expression_id = "expression_data_68410298_1515281598316_csv",
                 sample_info_id = "sample_info_68410298_1515281598316_csv",
                 sample_ID_name = "id",
                 group_name = "treatment",
                 levels = c("MeOH-frz", "ACN.IPA-frz", "MeOH.CHCl3-frz", "MeOH.CHCl3-lyph"),
                 sphericity_correction = TRUE,
                 post_hoc_test_type = "pairwise_paired_t_test_with_holm",
                 quick_analysis=FALSE
                 ){
  pacman::p_load("data.table", openxlsx)

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
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  # p = fread("p.csv")

  # group (as factor)
  group = p[[group_name]]
  group = factor(group, levels = c(levels))

  # subsetting to get only two groups.
  included_label = p[['label']][!is.na(group)]
  compound_label = e$label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)

  group = group[!is.na(group)]


  # p$id = c(rep(c(1:6),4),rep(c(1:6),4)+100)

  id_index = factor(p[[sample_ID_name]])
  id_index = id_index[p$label%in%included_label]


  # check the completeness of the ID * group1. If not, add.
  id_levels = levels(id_index)
  group_levels = levels(group)
  id_tb = table(id_index, group)
  id_index = as.character(id_index)
  group = as.character(group)
  for(j in 1:dim(id_tb)[2]){ # in each level of group
    for(i in 1:length(id_tb[,j])){ # check if any row is not all 0s or all 1s by length unique ?= 2. this means that there is missing id.
      if(id_tb[i,j]==0){
        id_index = c(id_index, names(id_tb[,j])[i]) # add a sudo id.
        group = c(group, colnames(id_tb)[j]) # add corresponding sudo group1.
        e = cbind(e, matrix(NA, nrow = nrow(e), ncol = 1)) # add columns with missing values.
      }
    }
  }
  id_index = factor(id_index, levels = id_levels) # make them back to factor again
  group = factor(group, levels = group_levels) # make them back to factor again



  group_indexes = sapply(levels, function(x) group%in%x, simplify = F)
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }
  core = repeated_anova_core(e,group_indexes,id_index,sphericity_correction,post_hoc_test_type)



  out = data.table(label = compound_label, core)



  # systematical.
  # determine the filename and upload attachment.
  filename = "repeated ANOVA"

  report = paste0("# ",filename,"\n\nThe statistical significance was evaluated by one-way repeated ANOVA ",ifelse(sphericity_correction,"with sphericity correction ","")," _(paired by ",sample_ID_name,")_ with `",post_hoc_test_type,"` as post hoc test procedure on the _",group_name," (",paste0(levels,collapse = ", "),")_. To overcome the multiple comparison problem, we adopted Benjamini-Hochberg false discovery rate (FDR) correction on  repeated ANOVA _p_ values. As a result, we found that there were ",sum(out[[2]]<0.05,na.rm = T)," (",signif(sum(out[[2]]<0.05,na.rm = T)/nrow(out),4)*100,"%) compounds had a ANOVA _p_ value < 0.05, and after FDR correction, there were ",sum(out[[3]]<0.05,na.rm = T)," (",signif(sum(out[[3]]<0.05,na.rm = T)/nrow(out),4)*100,"%) compounds significant. A detailed explanation of each column is following, \n\n")

  text = ""
  for(i in 1:ncol(out)){
    if(colnames(out)[i] == "repeated_ANOVA_p_value"){
      text = paste0(text, "| `repeated_ANOVA_p_value` | the p value of  repeated ANOVA ",ifelse(sphericity_correction,"with sphericity correction ",""),"for testing the effect of ",group_name," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "adjusted_repeated_ANOVA_p_value"){
      text = paste0(text, "| `adjusted_repeated_ANOVA_p_value` | the FDR corrected p value of effect of ",group_name," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% apply(combn(levels,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of `",post_hoc_test_type,"` comparing ",gsub("p value: ","",colnames(out)[i])," | ",sum(out[i]<0.05, na.rm = T)," (",signif(sum(out[i]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }
  }

  report = paste0(report, "| Column Name | Description | Number (%) of significant |\n| :--- | :--- | :--- |\n",text,"\nTable: ",filename,"\n\n")
  report = paste0(report, "The  repeated ANOVA analysis result is saved in the *",filename,"/ANOVA.xlsx*.")



  # return:
  # report. data for heatmap chart, pie chart and table.
  heatmap_data = lower.tri(matrix(nrow(out), nrow = length(levels), ncol = length(levels)), diag = FALSE)
  heatmap_data_value = sapply(out[,-c(1:4),with=F][,seq(2,ncol(out[,-c(1:4),with=F]),by=2),with=F], function(x){
    sum(x<0.05,na.rm = T)
  })
  heatmap_data_value = heatmap_data_value/nrow(out)
  heatmap_data[lower.tri(heatmap_data)] = heatmap_data_value
  heatmap_data = heatmap_data + t(heatmap_data)
  rownames(heatmap_data) = colnames(heatmap_data) = levels


  pie_data = data.frame(label = c(gsub("p value","significant",names(heatmap_data_value)),gsub("p value","not significant",names(heatmap_data_value))), value = c(heatmap_data_value,1-heatmap_data_value))




  table_data_criterion = data.table(label = out$label, sapply(out[,-c(1:4),with=F][,seq(2,ncol(out[,-c(1:4),with=F]),by=2),with=F], function(x){
    x<0.05
  }),sapply(out[,-c(1:4),with=F][,seq(2,ncol(out[,-c(1:4),with=F]),by=2),with=F], function(x){
    x>0.05
  }))
  colnames(table_data_criterion) = c("label", as.character(pie_data$label)) # when use click a pie piece, we'll know in the table_data, which should be displayed.

  colnames(out) = gsub("\\.","_",colnames(out))
  colnames(table_data_criterion) = gsub("\\.","_",colnames(table_data_criterion))
  pie_data$label = gsub("\\.","_",pie_data$label)
  colnames(heatmap_data) = gsub("\\.","_",colnames(heatmap_data))
  rownames(heatmap_data) = gsub("\\.","_",rownames(heatmap_data))


  return(list(table_data = out, heatmap_data = heatmap_data, table_data_criterion = table_data_criterion, table_data_colnames = gsub("\\.","_",colnames(out)), report_text = report, graph_pie_data_for_click = pie_data))




}









