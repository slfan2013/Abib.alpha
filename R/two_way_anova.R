two_way_anova = function(project_ID = "test_68410298_1517332073767",
                 expression_id = "data transformation_68410298_1517332125857_csv",
                 sample_info_id = "sample_info_68410298_1517332125857_csv",
                 group_name1 = "species",
                 group_name2 =  "treatment",
                 levels1 = c("pumpkin", "tomatillo"),
                 levels2 = c("MeOH-frz","ACN.IPA-frz", "MeOH.CHCl3-frz", "MeOH.CHCl3-lyph"),
                 type = "Welch",
                 post_hoc_test_type = "pairwise_t_test_with_no_correction",
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
  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
  }

  group1 = group1[index]
  group2 = group2[index]


  core = two_way_anova_core(e,group1, group2,levels1, levels2,
                            main_effect_1_type = type,
                            main_effect_1_post_hoc_test_type = post_hoc_test_type,
                            main_effect_2_type = type,
                            main_effect_2_post_hoc_test_type = post_hoc_test_type,
                            simple_main_effect_1_type = type,
                            simplemain_effect_1_post_hoc_test_type = post_hoc_test_type,
                            simple_main_effect_2_type = type,
                            simplemain_effect_2_post_hoc_test_type = post_hoc_test_type)

  out = data.table(label = compound_label, core)




  # systematical.
  # determine the filename and upload attachment.
  filename = "two way ANOVA"
  # ========================================================================================================================================================= #
  report = paste0("# ",filename,"\n\ntwo-way ANOVA was conducted on variable values revealing statistical significance of each variable caused by ",group_name1, ", ", group_name2, " [(main effects)](https://courses.washington.edu/smartpsy/interactions.htm) and ", group_name1," x ", group_name2," [(interaction)](https://courses.washington.edu/smartpsy/interactions.htm). To overcome the multiple comparison problem, we utilized Benjamini and Hochberg (1995) procedure on the ANOVA raw p values to control the false discovery rate (FDR) and corrected for multiple hypothesis tests. The FDR was controlled at 0.05 (adjusted _p_ value). The result can be summaried in the *",filename, "* table.\n\n")
  report = paste0(report, "| Column Name | Description | Number (%) of significant |\n| :--- | :--- | :--- |\n| `two_way_anova_p_value` | two-way ANOVA raw p values testing the interaction between ",group_name1," and ",group_name2," | ",sum(out[[2]]<0.05, na.rm = T)," (",signif(sum(out[[2]]<0.05, na.rm = T)/nrow(out),4)*100,"%) |\n| `adjusted_two_way_anova_p_value` | FDR corrected two-way ANOVA raw p values | ",sum(out[[3]]<0.05, na.rm = T)," (",signif(sum(out[[3]]<0.05, na.rm = T)/nrow(out),4)*100,"%) |\nTable: ",filename,"\n\n")
  report = paste0(report, "Following the two-way  ANOVA, we further performed post-hoc analysis (`",post_hoc_test_type,"` on the `",group_name1,"` and `", post_hoc_test_type, "` on the `" ,group_name2, "`) to test groupwise differences of main effect and [simple main effect](https://www.uccs.edu/lbecker/glm_sme.html), respectively. For example, `p value: ",levels1[1]," vs ",levels1[2],"` is the p value of `",post_hoc_test_type,'` comparing the `',levels1[1], "` and `", levels1[2], "` mixing all the levels in the `", group_name2, "`, whereas   the `p value: ",levels2[1]," vs ", levels2[2], " @", levels1[1],"` is the p value of the `",post_hoc_test_type,"` comparing the `", levels2[1], "` and `",  levels2[2],"` at the level of `",levels1[1], "` of `", group_name1,"`. A post hoc test p value less than 0.05 is considered as significant. Please note that the FDR is controlled by the post-hoc test itself. A explanation of the post hoc analysis is given in the *",filename," post hoc * table.\n\n")
  text = ""
  for(i in 4:ncol(out)){
    if(colnames(out)[i] == "F_score"){
      text = paste0(text, "| `F_score` | The F statistic used to calculate p values of `repeated_ANOVA_p_value` |  |\n")
    }else if(colnames(out)[i] == "two_way_anova_p_value"){
      text = paste0(text, "| `two_way_anova_p_value` | the p value of repeated ANOVA for testing main effect of ",group_name1," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "adjusted_repeated_ANOVA_p_value"){
      text = paste0(text, "| `adjusted_repeated_ANOVA_p_value` | the FDR corrected p value of main effect of ",group_name1," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% apply(combn(levels1,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of `",post_hoc_test_type,"` comparing ",gsub("p value: ","",colnames(out)[i])," | ",sum(out[i]<0.05, na.rm = T)," (",signif(sum(out[i]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "F_score_1"){
      text = paste0(text, "| `F_score_1` | The F statistic used to calculate p values of ",type," `ANOVA_p_value` |  |\n")
    }else if(colnames(out)[i] == "ANOVA_p_value"){
      text = paste0(text, "| `ANOVA_p_value` | the p value of ",type," ANOVA for testing the main effect of ",group_name2," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] == "adjusted_ANOVA_p_value"){
      text = paste0(text, "| `adjusted_ANOVA_p_value` | the FDR corrected p value of main effect of ",group_name2," | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% apply(combn(levels2,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of `",post_hoc_test_type,"` comparing ",gsub("p value: ","",colnames(out)[i])," | ",sum(out[i]<0.05, na.rm = T)," (",signif(sum(out[i]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("F_score @", levels2)){
      text = paste0(text, "| `",colnames(out)[i],"` | The F statistic used to calculate p values of `repeated_ANOVA_p_value @",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` |  |\n")
    }else if(colnames(out)[i] %in% paste0("repeated_ANOVA_p_value @", levels2)){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of repeated ANOVA for testing the simple main effect of ",group_name1," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("adjusted_repeated_ANOVA_p_value @", levels2)){
      text = paste0(text, "| `",colnames(out)[i],"` | the FDR corrected p value of simple main effect of ",group_name1," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% unlist(sapply(levels2, function(x) paste0(apply(combn(levels1,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})," @",x), simplify = F))){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of the ",post_hoc_test_type," for comparing the ",head(strsplit(gsub("p value: ","",colnames(out)[i])," @")[[1]],1)," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("F_score @", levels1)){
      text = paste0(text, "| `",colnames(out)[i],"` | The F statistic used to calculate p values of ",type," `ANOVA_p_value @",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` |  |\n")
    }else if(colnames(out)[i] %in% paste0("ANOVA_p_value @", levels1)){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of ",type," ANOVA for testing the simple main effect of ",group_name2," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% paste0("adjusted_repeated_ANOVA_p_value @", levels1)){
      text = paste0(text, "| `",colnames(out)[i],"` | the FDR corrected p value of simple main effect of ",group_name2," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }else if(colnames(out)[i] %in% unlist(sapply(levels1, function(x) paste0(apply(combn(levels2,2), 2, function(x){paste0("p value: ",x[1]," vs ", x[2])})," @",x), simplify = F))){
      text = paste0(text, "| `",colnames(out)[i],"` | the p value of the ",post_hoc_test_type," for comparing the ",head(strsplit(gsub("p value: ","",colnames(out)[i])," @")[[1]],1)," at level `",tail(strsplit(colnames(out)[i],"@")[[1]],1),"` | ",sum(out[[i]]<0.05, na.rm = T)," (",signif(sum(out[[i]]<0.05, na.rm = T)/nrow(out), 4)*100,"%) |\n")
    }
  }

  report = paste0(report, "| Column Name | Description | Number (%) of significant |\n| :--- | :--- | :--- |\n",text,"\nTable: ",filename,"\n\n")
  report = paste0(report, "The two-way  ANOVA analysis result is saved in the *",filename,"/two-way  ANOVA.xlsx*.")



  # return:
  # report. data for heatmap chart, pie chart and table.
  # 2 venn data.
  # 1st venn is based on group_name1@levels2
  venn_data1 = list()
  for(i in 1:length(levels2)){
    index = grepl(paste0("@",levels2[i]),colnames(out))
    if(paste0("ANOVA_p_value @",levels2[i]) %in% colnames(out)[index]){
      venn_data1[[i]] = out[[paste0("ANOVA_p_value @",levels2[i])]]
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









