confirm_edit_file_node = function(input,
                                  project_ID = "slfan1task1_68410298_1511051582310",
                                  node_id = "metabolite_info_68410298_1511051582310_csv"){
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

  fwrite(df, "data.table.csv")

  # put to couchdb.
  projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/",project_ID))
  projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = F)

  # # numeric_time = as.integer(Sys.time())
  # attname = paste0("two-way boxplots_68410298_",numeric_time,".pptx")
  new_att = projectList[["_attachments"]]
  # new_att = new_att[!names(new_att)%in%attname]


  node_id_edited = gsub("_csv",".csv", node_id)


  if(grepl("metabolite_info",node_id_edited)){ # user is editing the metabolite_info. Need to update the compound_info & compound_info_column_name
    projectList[["compound_info"]] = sapply(df, unique)
    projectList[["compound_info_column_name"]] = colnames(df)
    projectList[["compound_info_length"]] = sapply(df, function(x) length(unique(x)), simplify = FALSE)
    projectList[["compound_info_class"]] = sapply(df, class, simplify = FALSE)


    for(i in 1:length(projectList[["tree_structure"]])){
      if(projectList[["tree_structure"]][[i]]$id == node_id){
        projectList[["tree_structure"]][[i]][["attname"]] = node_id_edited
        projectList[["tree_structure"]][[i]][["source"]] = list(
          FUNCTION = "confirm_edit_file_node",
          PARAMETER = list(
            input = input,
            project_ID = project_ID,
            node_id = node_id
          )
        );break;
      }
    }
    # summarizing compound info to be used in the project detail
    summarizing = ezPrecis(f)
    summarizing_table = data.table(rownames(summarizing),summarizing)
    colnames(summarizing_table) = c("column_name",colnames(summarizing_table)[-1])
    compound_info_table_JSON = jsonlite::toJSON(summarizing_table)
    projectList[["compound_info_table_JSON"]] = compound_info_table_JSON
  }else if(grepl("sample_info",node_id_edited)){
    projectList[["sample_info"]] = sapply(df, unique, simplify = FALSE)
    projectList[["sample_info_column_name"]] = colnames(df)
    projectList[["sample_info_length"]] = sapply(df, function(x) length(unique(x)), simplify = FALSE)
    projectList[["sample_info_class"]] = sapply(df, class, simplify = FALSE)


    for(i in 1:length(projectList[["tree_structure"]])){
      if(projectList[["tree_structure"]][[i]]$id == node_id){
        projectList[["tree_structure"]][[i]][["attname"]] = node_id_edited
        projectList[["tree_structure"]][[i]][["source"]] = list(
          FUNCTION = "confirm_edit_file_node",
          PARAMETER = list(
            input = input,
            project_ID = project_ID,
            node_id = node_id
          )
        );break;
      }
    }

    # summarizing sample info to be used in the project detail
    summarizing = ezPrecis(p)
    summarizing_table = data.table(rownames(summarizing),summarizing)
    colnames(summarizing_table) = c("column_name",colnames(summarizing_table)[-1])
    sample_info_table_JSON = jsonlite::toJSON(summarizing_table)
    projectList[["sample_info_table_JSON"]] = sample_info_table_JSON
  }else{ # add attname, column_name, column_length, column_class, column_value
    for(i in 1:length(projectList[["tree_structure"]])){
      if(projectList[["tree_structure"]][[i]]$id == node_id){
        projectList[["tree_structure"]][[i]][["attname"]] = node_id_edited
        projectList[["tree_structure"]][[i]][["column_name"]] = colnames(df)
        projectList[["tree_structure"]][[i]][["column_length"]] = sapply(df, function(x) length(unique(x)), simplify = FALSE)
        projectList[["tree_structure"]][[i]][["column_class"]] = sapply(df, class, simplify = FALSE)
        projectList[["tree_structure"]][[i]][["column_value"]] = sapply(df, unique, simplify = FALSE)
        projectList[["tree_structure"]][[i]][["source"]] = list(
          FUNCTION = "confirm_edit_file_node",
          PARAMETER = list(
            input = input,
            project_ID = project_ID,
            node_id = node_id
          )
        );break;
      }
    }

  }


  new_att[[node_id_edited]] = list(content_type=new_att[[node_id_edited]]$content_type, data = RCurl::base64Encode(readBin("data.table.csv", "raw", file.info("data.table.csv")[1, "size"]), "txt"))
  projectList[["_attachments"]] = new_att
  result = RCurl::getURL(projectUrl,customrequest='PUT',httpheader=c('Content-Type'='application/json'),postfields= jsonlite::toJSON(projectList,auto_unbox = T, force = T))


  return(list(success = TRUE))


}
