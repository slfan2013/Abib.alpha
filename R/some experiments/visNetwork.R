library(data.table)
require(visNetwork, quietly = TRUE)
# minimal example
nodes <- data.frame(id = 1:3)
edges <- data.frame(from = c(1,2), to = c(1,3))
visNetwork(nodes, edges, width = "100%")


nodes <- data.frame(id = 1:10,

                    # add labels on nodes
                    label = paste("Node", 1:10),

                    # add groups on nodes
                    group = c("GrA", "GrB"),

                    # size adding value
                    value = 1:10,

                    # control shape of nodes
                    shape = c("square", "triangle", "box", "circle", "dot", "star",
                              "ellipse", "database", "text", "diamond"),

                    # tooltip (html or character), when the mouse is above
                    title = paste0("<p><b>", 1:10,"</b><br>Node !</p>"),

                    # color
                    color = c("darkred", "grey", "orange", "darkblue", "purple"),

                    # shadow
                    shadow = c(FALSE, TRUE, FALSE, TRUE, TRUE))
edges <- data.frame(from = c(1,2,5,7,8,10), to = c(9,3,1,6,4,7))
visNetwork(nodes, edges, height = "500px", width = "100%")






projectUrl <- URLencode(paste0("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/","a7_68410298_1511751137065"))
projectList <- jsonlite::fromJSON(projectUrl, simplifyVector = FALSE)
projectDataframe <- jsonlite::fromJSON(projectUrl, simplifyVector = TRUE)


tree = projectList$tree_structure


node = data.table(id = "root", label = "a7" ,title = "<p>project: a6</p>")
for(i in 2:length(tree)){

  title = paste0("<h2>",tree[[i]]$source$FUNCTION ,"</h2><br />")
  for(j in 1:length(tree[[i]]$source$PARAMETER)){
    title = paste0(title, "<p>", names(tree[[i]]$source$PARAMETER)[j],":",paste0(unlist(tree[[i]]$source$PARAMETER[[j]]),collapse = "; "),"</p>")
  }
  node = rbind(node, data.table(id=tree[[i]]$id, label = tree[[i]]$text, title=title))
}


edge = data.table(from = 1, to = 1, arrows = "to")
for(i in 2:length(tree)){
  for(j in 1:length(tree[[i]]$source_node_id)){
    edge = rbind(edge, data.table(from = tree[[i]]$source_node_id[[j]], to = tree[[i]]$id, arrows = "to"))
  }
}
visNetwork(node, edge, height = "500px", width = "100%") %>%
  visOptions(highlightNearest = TRUE) %>%
  visLayout(randomSeed = 123)



























