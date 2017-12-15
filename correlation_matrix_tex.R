# original can be found at the link below
# https://gist.github.com/5855936.git
# https://myowelt.blogspot.co.uk/2008/04/beautiful-correlation-tables-in-r.html

library(xtable)

corstarsl <- function(x, long = FALSE){ 
  require(Hmisc) 
  x <- as.matrix(x) 
  R <- rcorr(x)$r 
  p <- rcorr(x)$P 
  
  ## define notions for significance levels; spacing is important.
  mystars <- ifelse(p < .001, "***", ifelse(p < .01, "** ", ifelse(p < .05, "* ", " ")))
  
  ## trunctuate the matrix that holds the correlations to two decimal
  R <- format(round(cbind(rep(-1.11, ncol(x)), R), 3))[,-1] 
  
  ## build a new matrix that includes the correlations with their apropriate stars 
  Rnew <- matrix(paste(R, mystars, sep=""), ncol=ncol(x)) 
  diag(Rnew) <- paste(diag(R), " ", sep="") 
  rownames(Rnew) <- colnames(x) 
  colnames(Rnew) <- paste(colnames(x), "", sep="") 
  
  ## remove upper triangle
  Rnew <- as.matrix(Rnew)
  Rnew[upper.tri(Rnew, diag = TRUE)] <- ""
  Rnew <- as.data.frame(Rnew) 
  
  ## remove last column and return the matrix (which is now a data frame)
  Rnew <- cbind(Rnew[1:length(Rnew)-1])
  if (long == TRUE) {
    return(list(data.frame(t(Rnew), stringsAsFactors = FALSE), round(p, digits = 6)))
  } else {
    return(Rnew)
  }
}

#xtable(corstarsl(x, caption = "Correlation matrix with significance levels"))
#xtable(Hmisc::rcorr(x)$P, title = "Probability values", digits = 6)
