add_ellipse_to_score_plot = function(
  scores,
  use_color = TRUE,
  color = c("pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo"),
  selected_colors = c("#FF7F00", "#1F78B4"),
  pcx = "p1",
  pcy = "p2"
){
  pacman::p_load('data.table')
  scores = data.table(scores)

  # scores = fread("C:/Users/fansi/Documents/GitHub/Abib.alpha/ellipse.csv")

  if(use_color){
    color = factor(color,levels =  unique(color))
    ellise_coordinate = by(scores[,c(pcx,pcy),with=F],color,FUN=function(x){
      # x = scores[,c(pcx,pcy),with=F][color==color[1]]
      text.temp = x

      ell.info <- cov.wt(cbind(x[[1]], x[[2]]))
      eigen.info <- eigen(ell.info$cov)
      lengths <- sqrt(eigen.info$values * 2 * qf(.95, 2, length(x[[1]])-1))
      d = rbind(ell.info$center + lengths[1] * eigen.info$vectors[,1],
                ell.info$center - lengths[1] * eigen.info$vectors[,1],
                ell.info$center + lengths[2] * eigen.info$vectors[,2],
                ell.info$center - lengths[2] * eigen.info$vectors[,2])
      r <- cluster::ellipsoidhull(d)
      pred = predict(r)
    },simplify =F)
    out = list()
    for(i in 1:length(ellise_coordinate)){
      out[[i]] = ellise_coordinate[[i]]
    }
  }else{ # just a big ellipse covering all the points.

      # x = scores[,c(pcx,pcy),with=F][color==color[1]]
      text.temp = scores[,c(pcx,pcy),with=F]

      ell.info <- cov.wt(cbind(text.temp[[1]], text.temp[[2]]))
      eigen.info <- eigen(ell.info$cov)
      lengths <- sqrt(eigen.info$values * 2 * qf(.95, 2, length(text.temp[[1]])-1))
      d = rbind(ell.info$center + lengths[1] * eigen.info$vectors[,1],
                ell.info$center - lengths[1] * eigen.info$vectors[,1],
                ell.info$center + lengths[2] * eigen.info$vectors[,2],
                ell.info$center - lengths[2] * eigen.info$vectors[,2])
      r <- cluster::ellipsoidhull(d)
      pred = predict(r)
      ellise_coordinate = pred
      out = list()
      out[[1]] = ellise_coordinate

  }



  return(list(ellipse = out))
}
