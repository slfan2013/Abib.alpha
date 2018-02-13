calculate_ellipse = function(
  x = c("572", "649", "715", "1043", "724", "463", "419", "1011", "849", "", "774", "1223", "876", "888", "325", "422", "994", "588", "666", "589", "778", "392", "656", "699", "530", "539", "429", "639", "451", "603", "241", "801", "748", "987", "1064", "1177", "579", "440", "464", "374", "776", "401", "732", "862", "926", "573", "836", "1140"),
  y = c("3840", "3561", "5059", "6476", "3892", "3500", "6398", "7569", "4367", "5547", "4355", "6251", "3471", "5086", "2097", "1707", "2915", "4059", "4390", "4267", "3969", "2080", "2464", "5902", "7591", "10477", "4756", "9826", "8304", "7191", "2212", "11144", "7849", "11046", "9885", "9823", "6085", "11810", "12067", "2952", "9461", "4575", "9766", "10170", "10079", "7082", "5463", "8794"),
  group = c("pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "pumpkin", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo", "tomatillo")
){
  pacman::p_load('data.table')

  x = as.numeric(x)
  y = as.numeric(y)
  group = factor(group, levels = unique(group))
  x[is.na(x)] = median(x, na.rm = T)
  y[is.na(y)] = median(y, na.rm = T)
  ellise_coordinate = by(data.table(x,y),group,FUN=function(val){
    # val = data.table(x,y)[group==group[1]]

    ell.info <- cov.wt(cbind(val[[1]], val[[2]]))
    eigen.info <- eigen(ell.info$cov)
    lengths <- sqrt(eigen.info$values * 2 * qf(.95, 2, length(val[[1]])-1))
    d = rbind(ell.info$center + lengths[1] * eigen.info$vectors[,1],
              ell.info$center - lengths[1] * eigen.info$vectors[,1],
              ell.info$center + lengths[2] * eigen.info$vectors[,2],
              ell.info$center - lengths[2] * eigen.info$vectors[,2])
    r <- cluster::ellipsoidhull(d)
    pred = predict(r,n.out=500)
  },simplify =F)
  out = list()
  for(i in 1:length(ellise_coordinate)){
    out[[i]] = ellise_coordinate[[i]]
  }



  return(list(ellipse = out))
}
