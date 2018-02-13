# percent of true significant
percent_true_significant = 0.01
# number of groups
number_of_groups = 3
# means
means = 0:(number_of_groups-1)
# number of compounds
number_of_compounds = 1000
# number of samples for each group
number_of_samples = 10



false_significant_index = 1:round(number_of_compounds*(1-percent_true_significant))
true_significant_index = c(1:number_of_compounds)[!c(1:number_of_compounds)%in%false_significant_index]
# create data (each row represents a compound and each column represents a sample)
subsets = list()
for(i in 1:number_of_groups){
  true = matrix(rnorm(length(true_significant_index)*number_of_samples, mean = means[i]), nrow = length(true_significant_index))
  false = matrix(rnorm(length(false_significant_index)*number_of_samples, mean = 0), nrow = length(false_significant_index))
  subsets[[i]] = rbind(false, true)
}

data = do.call("cbind", subsets)

# create group
group = factor(rep(LETTERS[1:number_of_groups], each = number_of_samples))

posthocTGH = function (y, x, method = c("games-howell", "tukey"), conf.level = 0.95,
                       digits = 2, p.adjust = "holm", formatPvalue = TRUE)
{
  method <- tolower(method)
  tryCatch(method <- match.arg(method), error = function(err) {
    stop("Argument for 'method' not valid!")
  })
  res <- list(input = as.list(environment()))
  res$intermediate <- list(x = factor(x[complete.cases(x, y)]),
                           y = y[complete.cases(x, y)])
  res$intermediate$n <- tapply(y, x, length)
  res$intermediate$groups <- length(res$intermediate$n)
  res$intermediate$df <- sum(res$intermediate$n) - res$intermediate$groups
  res$intermediate$means <- tapply(y, x, mean)
  res$intermediate$variances <- tapply(y, x, var)
  res$intermediate$names <- levels(res$intermediate$x)
  res$intermediate$pairNames <- combn(res$intermediate$groups,
                                      2, function(ij) {
                                        paste0(rev(res$intermediate$names[ij]), collapse = "-")
                                      })
  res$intermediate$descriptives <- cbind(res$intermediate$n,
                                         res$intermediate$means, res$intermediate$variances)
  rownames(res$intermediate$descriptives) <- levels(res$intermediate$x)
  colnames(res$intermediate$descriptives) <- c("n", "means",
                                               "variances")
  res$intermediate$errorVariance <- sum((res$intermediate$n -
                                           1) * res$intermediate$variances)/res$intermediate$df
  res$intermediate$se <- combn(res$intermediate$groups, 2,
                               function(ij) {
                                 sqrt(res$intermediate$errorVariance * sum(1/res$intermediate$n[ij]))
                               })
  res$intermediate$dmeans <- combn(res$intermediate$groups,
                                   2, function(ij) {
                                     diff(res$intermediate$means[ij])
                                   })
  res$intermediate$t <- abs(res$intermediate$dmeans)/res$intermediate$se
  res$intermediate$p.tukey <- ptukey(res$intermediate$t * sqrt(2),
                                     res$intermediate$groups, res$intermediate$df, lower.tail = FALSE)
  res$intermediate$alpha <- (1 - conf.level)
  res$intermediate$qcrit <- qtukey(res$intermediate$alpha,
                                   res$intermediate$groups, res$intermediate$df, lower.tail = FALSE)/sqrt(2)
  res$intermediate$tukey.low <- res$intermediate$dmeans - (res$intermediate$qcrit *
                                                             res$intermediate$se)
  res$intermediate$tukey.high <- res$intermediate$dmeans +
    (res$intermediate$qcrit * res$intermediate$se)
  res$output <- list()
  res$output$tukey <- data.frame(res$intermediate$dmeans, res$intermediate$tukey.low,
                                 res$intermediate$tukey.high, res$intermediate$t, res$intermediate$df,
                                 res$intermediate$p.tukey)
  res$output$tukey$p.tukey.adjusted <- p.adjust(res$intermediate$p.tukey,
                                                method = p.adjust)
  rownames(res$output$tukey) <- res$intermediate$pairNames
  colnames(res$output$tukey) <- c("diff", "ci.lo", "ci.hi",
                                  "t", "df", "p", "p.adjusted")
  res$intermediate$df.corrected <- combn(res$intermediate$groups,
                                         2, function(ij) {
                                           sum(res$intermediate$variances[ij]/res$intermediate$n[ij])^2/sum((res$intermediate$variances[ij]/res$intermediate$n[ij])^2/(res$intermediate$n[ij] -
                                                                                                                                                                         1))
                                         })
  res$intermediate$se.corrected <- combn(res$intermediate$groups,
                                         2, function(ij) {
                                           sqrt(sum(res$intermediate$variances[ij]/res$intermediate$n[ij]))
                                         })
  res$intermediate$t.corrected <- abs(res$intermediate$dmeans)/res$intermediate$se.corrected
  res$intermediate$qcrit.corrected <- qtukey(res$intermediate$alpha,
                                             res$intermediate$groups, res$intermediate$df.corrected,
                                             lower.tail = FALSE)/sqrt(2)
  res$intermediate$gh.low <- res$intermediate$dmeans - res$intermediate$qcrit.corrected *
    res$intermediate$se.corrected
  res$intermediate$gh.high <- res$intermediate$dmeans + res$intermediate$qcrit.corrected *
    res$intermediate$se.corrected
  res$intermediate$p.gameshowell <- ptukey(res$intermediate$t.corrected *
                                             sqrt(2), res$intermediate$groups, res$intermediate$df.corrected,
                                           lower.tail = FALSE)
  res$output$games.howell <- data.frame(res$intermediate$dmeans,
                                        res$intermediate$gh.low, res$intermediate$gh.high, res$intermediate$t.corrected,
                                        res$intermediate$df.corrected, res$intermediate$p.gameshowell)
  res$output$games.howell$p.gameshowell.adjusted <- p.adjust(res$intermediate$p.gameshowell,
                                                             method = p.adjust)
  rownames(res$output$games.howell) <- res$intermediate$pairNames
  colnames(res$output$games.howell) <- c("diff", "ci.lo", "ci.hi",
                                         "t", "df", "p", "p.adjusted")
  class(res) <- "posthocTGH"
  return(res)
}


GH = list()
for(i in 1:nrow(data)){
  GH[[i]] = posthocTGH(data[i,] ,group, digits=4)$output[['games.howell']][,'p']
}
GH = do.call("rbind", GH)
tukey = list()
for(i in 1:nrow(data)){
  tukey[[i]] = posthocTGH(data[i,] ,group, digits=4)$output[['tukey']][,'p']
}
tukey = do.call("rbind", tukey)
pairedT = list()
for(i in 1:nrow(data)){
  o = pairwise.t.test(x = data[i,], g=group, p.adjust.method = 'none', paired = FALSE)$p.value
  o = o[!is.na(o)]
  pairedT[[i]] = o
}
pairedT = do.call("rbind", pairedT)
pairedT = apply(pairedT,2,p.adjust,"fdr")






# true label
response = rep(F, number_of_compounds)
response[true_significant_index] = T

GH_true_positive = sum(response & GH[,1]<0.05)
tukey_true_positive = sum(response & tukey[,1]<0.05)
pairedT_true_positive = sum(response & pairedT[,1]<0.05)


GH_false_positive = sum(!response & GH[,1]<0.05)
tukey_false_positive = sum(!response & tukey[,1]<0.05)
pairedT_false_positive = sum(!response & pairedT[,1]<0.05)

GH_true_negative = sum(!response & !GH[,1]<0.05)
tukey_true_negative = sum(!response & !tukey[,1]<0.05)
pairedT_true_negative = sum(!response & !pairedT[,1]<0.05)


GH_false_negative = sum(response & !GH[,1]<0.05)
tukey_false_negative = sum(response & !tukey[,1]<0.05)
pairedT_false_negative = sum(response & !pairedT[,1]<0.05)





















