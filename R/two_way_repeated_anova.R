two_way_repeated_anova = function(project_ID = "t test_68410298_1508863368603",
                               expression_id = "expression_data_68410298_1508863368603_csv",
                               sample_info_id = "sample_info_68410298_1508863368603_csv",
                               group_name1 = "treatment", # this should be the repeated factor
                               group_name2 =  "species", # this should be the repeated factor
                               levels1 = c("ACN.IPA-frz", "MeOH-frz", "MeOH.CHCl3-frz", "MeOH.CHCl3-lyph"),
                               levels2 = c("pumpkin", "tomatillo"),
                               sample_ID_name = 'id',
                               post_hoc_test_type = "pairwise_paired_t_test_with_fdr"
){
  # https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php
  pacman::p_load("data.table")

  # make _csv to .csv.
  expression_name = paste0(substring(expression_id, 1, nchar(expression_id)-4),".csv")
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  # e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
  e = fread("e.csv")
  # e = e[,-c(1,2,3,4)]
  # read sample info
  # p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  p = fread("p.csv")
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

  id_index = factor(p[[sample_ID_name]])
  # id_index = rep(1:6, 8)
  core = two_way_repeated_anova_core(e,group1, group2,levels1, levels2,id_index,
                                     main_effect_post_hoc_test_type = post_hoc_test_type,
                                     simplemain_effect_post_hoc_test_type = post_hoc_test_type)

  result = data.table(label = compound_label, core)





  fwrite(result,'result.csv')


}









