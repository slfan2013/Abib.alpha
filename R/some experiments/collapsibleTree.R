devtools::install_github("AdeelK93/collapsibleTree")


library(collapsibleTree)
library(htmlwidgets)
a = collapsibleTree(warpbreaks, c("wool", "tension", "breaks"))
saveWidget(a, paste0("tree",".html"), selfcontained = FALSE)
