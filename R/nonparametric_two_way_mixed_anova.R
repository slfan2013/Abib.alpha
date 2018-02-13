nonparametric_two_way_mixed_anova = function(project_ID = "C_68410298_1516226987062",
                                             expression_id = "log transformation_68410298_1516226994522_csv",
                                             sample_info_id = "sample_info_68410298_1516226994522_csv",
                                             group_name2 = "treatment",
                                             group_name1 =  "time",# this should be the repeated factor
                                             levels2 = c("10mM Glucose","5mM Glucose","5mM Glucose + 5mM Fructose"),
                                             levels1 = c("0.17 hr","1 hr","6 hrs","24 hrs"),
                                             sample_ID_name = 'SampleID',
                                             type = "Welch",
                                             post_hoc_test_type1 = "pairwise_nonparametric_paired_t_test_with_holm",
                                             post_hoc_test_type2 = "pairwise_nonparametric_t_test_with_holm",
                                             quick_analysis=FALSE
){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
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
  # p = p[-c(1,2,3,4)]
  # group (as factor)
  group1 = p[[group_name1]]
  group1 = factor(group1, levels = c(levels1))

  group2 = p[[group_name2]]
  group2 = factor(group2, levels = c(levels2))

  # subsetting to get only two groups.
  index = !is.na(group1) & !is.na(group2)
  included_label = p[['label']][index]
  compound_label = e$label
  e = e[, colnames(e) %in% included_label, with = F]
  e = data.matrix(e)

  group1 = group1[index]
  group2 = group2[index]

  id_index = factor(p[[sample_ID_name]])
  id_index = id_index[p$label%in%included_label]


  # check the completeness of the ID * group1. If not, add.
  id_levels = levels(id_index)
  group1_levels = levels(group1)
  group2_levels = levels(group2)
  id_tb = table(id_index, group1, group2)
  id_index = as.character(id_index)
  group1 = as.character(group1)
  group2 = as.character(group2)
  for(z in 1:dim(id_tb)[3]){ # in each level of group2
    for(i in 1:nrow(id_tb[,,z])){ # check if any row is not all 0s or all 1s by length unique ?= 2. this means that there is missing id.
      if(length(unique(id_tb[i,,z]))==2){
        id_index = c(id_index, rep(rownames(id_tb[,,z])[i],sum(id_tb[i,,z]==0))) # add a sudo id.
        group1 = c(group1, names(which(id_tb[i,,z] == 0))) # add corresponding sudo group1.
        group2 = c(group2, group2_levels[z]) # add corresponding sudo group2.
        e = cbind(e, matrix(NA, nrow = nrow(e), ncol = sum(id_tb[i,,z]==0))) # add columns with missing values.
      }
    }
  }
  id_index = factor(id_index, levels = id_levels) # make them back to factor again
  group1 = factor(group1, levels = group1_levels) # make them back to factor again
  group2 = factor(group2, levels = group2_levels) # make them back to factor again

  # replace missing value with halfminimum.
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }

  core = nonparametric_two_way_mixed_anova_core(e,group1, group2,levels1, levels2,id_index,
                                  main_effect_1_post_hoc_test_type = post_hoc_test_type1,
                                  main_effect_2_post_hoc_test_type = post_hoc_test_type2,
                                  simplemain_effect_1_post_hoc_test_type = post_hoc_test_type1,
                                  simplemain_effect_2_post_hoc_test_type = post_hoc_test_type2)






  out = data.table(label = compound_label, core)



  # systematical.
  # determine the filename and upload attachment.
  filename = "two way ANOVA with nonparametric post hoc test"
  # ========================================================================================================================================================= #
  report = paste0("# ",filename,"\n\n Nonparametric two-way mixed ANOVA was conducted on variable values revealing statistical significance of each variable caused by ",group_name1, ", ", group_name2, " [(main effects)](https://courses.washington.edu/smartpsy/interactions.htm) and ", group_name1," x ", group_name2," [(interaction)](https://courses.washington.edu/smartpsy/interactions.htm). To overcome the multiple comparison problem, we utilized Benjamini and Hochberg (1995) procedure on the nonparametric  ANOVA raw p values to control the false discovery rate (FDR) and corrected for multiple hypothesis tests. The FDR was controlled at 0.05 (adjusted _p_ value). The result can be summaried in the *",filename, "* table.\n\n")
  report = paste0(report, "| Column Name | Description | Number (%) of significant |\n| :--- | :--- | :--- |\n| `two_way_mixed_anova_p_value` | nonparametric two-way ANOVA raw p values testing the interaction between ",group_name1," and ",group_name2," | ",sum(out[[2]]<0.05, na.rm = T)," (",signif(sum(out[[2]]<0.05, na.rm = T)/nrow(out),4)*100,"%) |\n| `adjusted_two_way_mixed_anova_p_value` | FDR corrected nonparametric two-way ANOVA raw p values | ",sum(out[[3]]<0.05, na.rm = T)," (",signif(sum(out[[3]]<0.05, na.rm = T)/nrow(out),4)*100,"%) |\nTable: ",filename,"\n\n")
  report = paste0(report, "Following the nonparametric two-way mixed ANOVA, we further performed post-hoc analysis (`",post_hoc_test_type1,"` on the `",group_name1,"` and `", post_hoc_test_type2, "` on the `" ,group_name2, "`) to test groupwise differences of main effect and [simple main effect](httrepeated_ANOVA_p_valueps://www.uccs.edu/lbecker/glm_sme.html), respectively. For example, `p value: ",levels1[1]," vs ",levels1[2],"` is the p value of `",post_hoc_test_type1,'` comparing the `',levels1[1], "` and `", levels1[2], "` mixing all the levels in the `", group_name2, "`, whereas   the `p value: ",levels2[1]," vs ", levels2[2], " @", levels1[1],"` is the p value of the `",post_hoc_test_type2,"` comparing the `", levels2[1], "` and `",  levels2[2],"` at the level of `",levels1[1], "` of `", group_name1,"`. A post hoc test p value less than 0.05 is considered as significant. Please note that the FDR is controlled by the post-hoc test itself. A explanation of the post hoc analysis is given in the *",filename," post hoc * table.\n\n")
  text = ""
  for(i in 4:ncol(out)){
    if(colnames(out)[i] == "F_score"){
      text = paste0(text, "| `F_score` | The F statistic used to calculate p values of `repeated_ANOVA_p_value` |  |\n")
    }else if(colnames(out)[i] == "two_way_mixed_anova_p_value"){
      text = paste0(text, "| `two_way_mixed_anova_p_value` | the p value of repeated ANOVA for testing main effect of ",group_name1," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "adjusted_repeated_ANOVA_p_value"){
      text = paste0(text, "| `adjusted_repeated_ANOVA_p_value` | the FDR corrected p value of main effect of ",group_name1," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% apply(combn(levels1,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of `",post_hoc_test_type1,"` comparing ",gsub("p value: ","",colnames(out)[i])," | ",sum(out[i]<0.05, na.rm = T)," (",signif(sum(out[i]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "F_score_1"){
      text = paste0(text, "| `F_score_1` | The F statistic used to calculate p values of ",type," `ANOVA_p_value` |  |\n")
    }else if(colnames(out)[i] == "ANOVA_p_value"){
      text = paste0(text, "| `ANOVA_p_value` | the p value of nonparametric ANOVA for testing the main effect of ",group_name2," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "adjusted_ANOVA_p_value"){
      text = paste0(text, "| `adjusted_ANOVA_p_value` | the FDR corrected p value of main effect of ",group_name2," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% apply(combn(levels2,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of `",post_hoc_test_type2,"` comparing ",gsub("p value: ","",colnames(out)[i])," | ",sum(out[i]<0.05, na.rm = T)," (",signif(sum(out[i]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("F_score @", levels2)){
      text = paste0(text, "| `",colnames(out)[i],"` | The F statistic used to calculate p values of `repeated_ANOVA_p_value @",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` |  |\n")
    }else if(colnames(out)[i] %in% paste0("repeated_ANOVA_p_value @", levels2)){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of repeated ANOVA for testing the simple main effect of ",group_name1," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("adjusted_repeated_ANOVA_p_value @", levels2)){
      text = paste0(text, "| `",colnames(out)[i],"` | the FDR corrected p value of simple main effect of ",group_name1," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% unlist(sapply(levels2, function(x) paste0(apply(combn(levels1,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})," @",x), simplify = F))){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of the ",post_hoc_test_type1," for comparing the ",head(strsplit(gsub("p value: ","",colnames(out)[i])," @")[[1]],1)," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("F_score @", levels1)){
      text = paste0(text, "| `",colnames(out)[i],"` | The F statistic used to calculate p values of nonparametric `ANOVA_p_value @",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` |  |\n")
    }else if(colnames(out)[i] %in% paste0("ANOVA_p_value @", levels1)){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of nonparametric ANOVA for testing the simple main effect of ",group_name2," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("adjusted_repeated_ANOVA_p_value @", levels1)){
      text = paste0(text, "| `",colnames(out)[i],"` | the FDR corrected p value of simple main effect of ",group_name2," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% unlist(sapply(levels1, function(x) paste0(apply(combn(levels2,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})," @",x), simplify = F))){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of the ",post_hoc_test_type2," for comparing the ",head(strsplit(gsub("p value: ","",colnames(out)[i])," @")[[1]],1)," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }
  }

  report = paste0(report, "| Column Name | Description | Number (%) of significant |\n| :--- | :--- | :--- |\n",text,"\nTable: ",filename,"\n\n")
  report = paste0(report, "The two-way mixed ANOVA analysis result is saved in the *",filename,"/two-way mixed ANOVA.xlsx*.")



  # return:
  # report. data for heatmap chart, pie chart and table.
  # 2 venn data.
  # 1st venn is based on group_name1@levels2
  venn_data1 = list()
  for(i in 1:length(levels2)){
    index = grepl(paste0("@",levels2[i]),colnames(out))
    if(paste0("repeated_ANOVA_p_value @",levels2[i]) %in% colnames(out)[index]){
      venn_data1[[i]] = out[[paste0("repeated_ANOVA_p_value @",levels2[i])]]
    }else{
      venn_data1[[i]] = out[[paste0("p value: ",levels1[1]," vs ",levels1[2]," @",levels2[i])]]
    }
    venn_data1[[i]] = out$label[venn_data1[[i]]<0.05]
    names(venn_data1)[i] = levels2[i]
  }



  venn_data2 = list()
  for(i in 1:length(levels1)){
    index = grepl(paste0("@",levels1[i]),colnames(out))
    if(paste0("ANOVA_p_value @",levels1[i]) %in% colnames(out)[index]){
      venn_data2[[i]] = out[[paste0("ANOVA_p_value @",levels1[i])]]
    }else{
      venn_data2[[i]] = out[[paste0("p value: ",levels2[1]," vs ",levels2[2]," @",levels1[i])]]
    }
    venn_data2[[i]] = out$label[venn_data2[[i]]<0.05]
    names(venn_data2)[i] = levels1[i]
  }



  colnames(out) = gsub("\\.","_",colnames(out))
  return(list(table_data = out,  report_text = report,  table_data_colnames = gsub("\\.","_",colnames(out)), venn_data1 = venn_data1, venn_data2 = venn_data2))



}









