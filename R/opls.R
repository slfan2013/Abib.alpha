opls = function(project_ID = "test12_68410298_1510162535904",
               expression_id = "expression_data_68410298_1510162535904_csv",
               sample_info_id = "sample_info_68410298_1510162535904_csv",
               PC_x = "PC1",
               PC_y = "PC2",


               color_by = "species",
               color_levels = c("tomatillo", "pumpkin"),


               # predI = "NA",
               scaleC = "standard",
               parCexN = 1,
               parEllipsesL = TRUE,
               permI = 100,
               orthoI = "NA"



){

  # predI = as.numeric(predI)
  orthoI = as.numeric(orthoI)


  parCompVi = as.numeric(c(substring(PC_x,3),substring(PC_y,3)))

  pacman::p_load("data.table",  ropls, officer,dplyr, rvg)

  # make _csv to .csv.
  expression_name = paste0(substring(expression_id, 1, nchar(expression_id)-4),".csv")
  sample_info_name = paste0(substring(sample_info_id, 1, nchar(sample_info_id)-4),".csv")

  # read data
  e = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",expression_name)),header=T)
  # e = fread("e.csv")

  # read sample info
  p = fread(URLencode(paste0("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID,"/",sample_info_name)),header=T,strip.white=F)
  # p = fread("p.csv")



  if(color_by == "NO_68410298_COLOR"){
    color_by = NA
    included_label = p[['label']]
    compound_label = e$label
    e = e[, colnames(e) %in% included_label, with = F]
    e = data.matrix(e)
    for(i in 1:nrow(e)){
      e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
    }

  }else{
    # group (as factor)
    color_by = p[[color_by]]
    color_by = factor(color_by, levels = c(color_levels))
    # subsetting to get only two groups.
    included_label = p[['label']][!is.na(color_by)]
    compound_label = e$label
    sample_label = included_label
    e = e[, colnames(e) %in% included_label, with = F]

    e = data.matrix(e)
    for(i in 1:nrow(e)){
      e[i,is.na(e[i,])] = .5 * min(e[i,], na.rm = T)
    }
    color_by = color_by[!is.na(color_by)]
  }
  response = color_by



  for(i in 1:nrow(e)){
    e[i,is.na(e[i,])] = .5 * min(e[i,!is.na(e[i,])])
  }

  e_t = t(e)

  colnames(e_t) = compound_label
  rownames(e_t) = sample_label

  opls = ropls::opls(x = e_t, y = response,  scaleC = scaleC, predI = 1,printL = FALSE, plotL = F, permI = permI, orthoI = orthoI)

  loadings = getLoadingMN(opls)
  fwrite(data.table(compound_label = compound_label, loadings), "OPLS-loadings.csv")
  # var_exp = getPcaVarVn(opls)
  # fwrite(data.table(var_exp), "OPLS-VIP_score.csv")

  scores = getScoreMN(opls)
  fwrite(data.table(sample_label = sample_label, scores), "OPLS-scores.csv")

  VIP_score = getVipVn(opls)
  fwrite(data.table(compound_label = compound_label, VIP_score), "OPLS-VIP_score.csv")

  # plot(opls, typeVc = "correlation", parTitleL = T, parDevNewL = FALSE)


  # plot(opls, typeVc = "permutation", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "predict-train", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "predict-test", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "summary", parTitleL = T, parDevNewL = FALSE)


  # plot(opls, typeVc = "x-variance", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "xy-score", parTitleL = T, parDevNewL = FALSE)
  # plot(opls, typeVc = "xy-weight", parTitleL = T, parDevNewL = FALSE)

  png("result.png", width = 800 * 1.5, height = 600 * 1.5)
  par(mfrow = c(2,2))
  plot(opls, typeVc = "x-score", parTitleL = T, parDevNewL = FALSE, parAsColFcVn = color_by, parCexN  = parCexN, parCompVi = parCompVi, parEllipsesL = parEllipsesL)
  plot(opls, typeVc = "x-loading", parTitleL = T, parDevNewL = FALSE, parCompVi = parCompVi, parCexN  = parCexN)
  plot(opls, typeVc = "permutation", parTitleL = T, parDevNewL = FALSE)
  plot(opls, typeVc = "overview", parTitleL = T, parDevNewL = FALSE, parCompVi = parCompVi, parAsColFcVn = color_by, parCexN  = parCexN)
  title(sub = paste0("R2: ",signif(getSummaryDF(opls)[1,2],4)*100,"%; ",
                     "Q2: ",signif(getSummaryDF(opls)[1,3],4)*100,"%"))
  dev.off()



  pptx = read_pptx()
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code =
    {
      par(mfrow = c(2,2))
      plot(opls, typeVc = "x-score", parTitleL = T, parDevNewL = FALSE, parAsColFcVn = color_by, parCexN  = parCexN, parCompVi = parCompVi, parEllipsesL = parEllipsesL)
      plot(opls, typeVc = "x-loading", parTitleL = T, parDevNewL = FALSE, parCompVi = parCompVi, parCexN  = parCexN)
      plot(opls, typeVc = "permutation", parTitleL = T, parDevNewL = FALSE)
      plot(opls, typeVc = "overview", parTitleL = T, parDevNewL = FALSE, parCompVi = parCompVi, parAsColFcVn = color_by, parCexN  = parCexN)
      title(sub = paste0("R2: ",signif(getSummaryDF(opls)[1,2],4)*100,"%; ",
                         "Q2: ",signif(getSummaryDF(opls)[1,3],4)*100,"%"))
    }, type = "body", width = 8, height = 6, offx = 0, offy = 0)
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code = plot(opls, typeVc = "x-score", parTitleL = T, parDevNewL = FALSE, parAsColFcVn = color_by, parCexN  = parCexN, parCompVi = parCompVi, parEllipsesL = parEllipsesL), type = "body", width = 8, height = 6, offx = 0, offy = 0)
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code = plot(opls, typeVc = "x-loading", parTitleL = T, parDevNewL = FALSE, parCompVi = parCompVi, parCexN  = parCexN), type = "body", width = 8, height = 6, offx = 0, offy = 0)
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code = plot(opls, typeVc = "permutation", parTitleL = T, parDevNewL = FALSE), type = "body", width = 8, height = 6, offx = 0, offy = 0)
  pptx = pptx%>% add_slide(layout = "Title and Content", master = "Office Theme") %>%
    ph_with_vg(code = {plot(opls, typeVc = "overview", parTitleL = T, parDevNewL = FALSE, parCompVi = parCompVi, parAsColFcVn = color_by, parCexN  = parCexN);title(sub = paste0("R2: ",signif(getSummaryDF(opls)[1,2],4)*100,"%; ",
                                                                                                                                                                                 "Q2: ",signif(getSummaryDF(opls)[1,3],4)*100,"%"))}, type = "body", width = 8, height = 6, offx = 0, offy = 0)


  pptx %>% print(target = "OPLS-plots.pptx") %>% invisible()






  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl)
  # numeric_time = as.integer(Sys.time())
  # change the tree structure.
  adding_to_tree_structure = data.frame(id = c(paste0("OPLS_68410298_",numeric_time,""),
                                               paste0("OPLS-scores_68410298_",numeric_time,"_csv"),
                                               paste0("OPLS-loadings_68410298_",numeric_time,"_csv"),
                                               paste0("OPLS-VIP_score_68410298_",numeric_time,"_csv"),
                                               paste0("OPLS-plots_68410298_",numeric_time,"_pptx")
  ),
  parent = c(projectList$tree_structure$parent[projectList$tree_structure$id==expression_id],
             paste0("OPLS_68410298_",numeric_time,""),
             paste0("OPLS_68410298_",numeric_time,""),
             paste0("OPLS_68410298_",numeric_time,""),
             paste0("OPLS_68410298_",numeric_time,"")),
  text = c("OPLS","OPLS-scores.csv","OPLS-loadings.csv","OPLS-VIP_score.csv","OPLS-plots.pptx"),
  icon = c("fa fa-folder","fa fa-file-excel-o","fa fa-file-excel-o","fa fa-file-excel-o","fa fa-file-powerpoint-o"))
  projectList$tree_structure = rbind(projectList$tree_structure, adding_to_tree_structure)




  # attach files.
  new_att = projectList[["_attachments"]]

  attname = paste0("OPLS-scores_68410298_",numeric_time,".csv")
  new_att = new_att[!names(new_att)%in%attname]
  new_att[[attname]] = list(content_type="application/vnd.ms-excel", data = RCurl::base64Encode(readBin("OPLS-scores.csv", "raw", file.info("OPLS-scores.csv")[1, "size"]), "txt"))

  attname = paste0("OPLS-loadings_68410298_",numeric_time,".csv")
  new_att = new_att[!names(new_att)%in%attname]
  new_att[[attname]] = list(content_type="application/vnd.ms-excel", data = RCurl::base64Encode(readBin("OPLS-loadings.csv", "raw", file.info("OPLS-loadings.csv")[1, "size"]), "txt"))

  attname = paste0("OPLS-VIP_score_68410298_",numeric_time,".csv")
  new_att = new_att[!names(new_att)%in%attname]
  new_att[[attname]] = list(content_type="application/vnd.ms-excel", data = RCurl::base64Encode(readBin("OPLS-VIP_score.csv", "raw", file.info("OPLS-VIP_score.csv")[1, "size"]), "txt"))

  attname = paste0("OPLS-plots_68410298_",numeric_time,".pptx")
  new_att = new_att[!names(new_att)%in%attname]
  new_att[[attname]] = list(content_type="application/vnd.openxmlformats-officedocument.presentationml.presentation", data = RCurl::base64Encode(readBin("OPLS-plots.pptx", "raw", file.info("OPLS-plots.pptx")[1, "size"]), "txt"))




  projectList[["_attachments"]] = new_att
  result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))






  return(list(success = TRUE))


}









