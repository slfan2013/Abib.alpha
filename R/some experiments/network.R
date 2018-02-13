pacman::p_load(igraph,network,sna,visNetwork,threejs,networkD3,ndtv)

nodes <- read.csv("Data files\\Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Data files\\Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

links <- aggregate(links[,3], links[,-3], sum)
links <- links[order(links$from, links$to),]
colnames(links)[4] <- "weight"
rownames(links) <- NULL



nodes2 <- read.csv("Data files\\Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 <- read.csv("Data files\\Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)

links2 <- as.matrix(links2)
net <- graph_from_data_frame(d=links, vertices=nodes, directed=T)

E(net)       # The edges of the "net" object
V(net)       # The vertices of the "net" object
E(net)$type  # Edge attribute "type"
V(net)$media # Vertex attribute "media"


# Find nodes and edges by attribute:
# (that returns oblects of type vertex sequence/edge sequence)
V(net)[media=="BBC"]
E(net)[type=="mention"]


# You can also examine the network matrix directly:
net[1,]
net[5,7]


as_edgelist(net, names=T)
as_adjacency_matrix(net, attr="weight")
# Or data frames describing nodes and edges:
as_data_frame(net, what="edges")
as_data_frame(net, what="vertices")

plot(net)



net <- simplify(net, remove.multiple = F, remove.loops = T)



plot(net, edge.arrow.size=.4,vertex.label=NA)


net2 <- graph_from_incidence_matrix(links2)
table(V(net2)$type)


# ?igraph.plotting

plot(net, edge.arrow.size=.4, edge.curved=.1)

# Set edge color to light gray, the node & border color to orange
# Replace the vertex label with the node names stored in "media"
plot(net, edge.arrow.size=.2, edge.color="orange",
     vertex.color="orange", vertex.frame.color="#ffffff",
     vertex.label=V(net)$media, vertex.label.color="black")

# Generate colors based on media type:
colrs <- c("gray50", "tomato", "gold")
V(net)$color <- colrs[V(net)$media.type]

# Compute node degrees (#links) and use that to set node size:
deg <- igraph::degree(net, mode="all")
V(net)$size <- deg*3
# We could also use the audience size value:
V(net)$size <- V(net)$audience.size*0.6
# The labels are currently node IDs.
# Setting them to NA will render no labels:
V(net)$label <- NA

# Set edge width based on weight:
E(net)$width <- E(net)$weight/6

#change arrow size and edge color:
E(net)$arrow.size <- .2
E(net)$edge.color <- "gray80"
E(net)$width <- 1+E(net)$weight/12

l <- layout_with_fr(net)
plot(net, layout =  l)

plot(net, edge.color="orange", vertex.color="gray50")


plot(net)
legend(x=-1.5, y=-1.1, c("Newspaper","Television", "Online News"), pch=21,
       col="#777777", pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)

plot(net, vertex.shape="none", vertex.label=V(net)$media,
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="gray85")


edge.start <- ends(net, es=E(net), names=F)[,1]
edge.col <- V(net)$color[edge.start]

plot(net, edge.color=edge.col, edge.curved=.1)

net.bg <- sample_pa(80)

V(net.bg)$size <- 8
V(net.bg)$frame.color <- "white"
V(net.bg)$color <- "orange"
V(net.bg)$label <- ""
E(net.bg)$arrow.mode <- 0
plot(net.bg)




layouts <- grep("^layout_", ls("package:igraph"), value=TRUE)[-1]
layouts <- layouts[!grepl("bipartite|merge|norm|sugiyama|tree", layouts)]


hist(links$weight)
mean(links$weight)
sd(links$weight)


cut.off <- mean(links$weight)
net.sp <- delete_edges(net, E(net)[weight<cut.off])
plot(net.sp)










library(KEGG.db)













































