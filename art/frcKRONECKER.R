# R-blogger
## R Helper Functions
#
## HFR#1 plotmat(): Simple plotting using matrix mat (filled with 0/nonzero int).
#  Where: mat - matrix; fn - file name (no extension); clr - color;
#         ttl - plot title; dflg - writing dump file flag (0-no/1-yes):
#         psz - picture size; cx - cex or scale.
plotmat <- function(mat, fn, clr, ttl, dflg=0, psz=2000, cx=3.0) {
  m = nrow(mat); d = 0; X=NULL; Y=NULL;
  pf = paste0(fn, ".png"); df = paste0(fn, ".dmp");
  # Building X and Y arrays for plotting from not equal to zero values in mat.
  for (i in 1:m) {
    for (j in 1:m) {if(mat[i,j]==0){next} else {d=d+1; X[d]=i; Y[d]=j} }
  };
  cat(" *** Matrix(", m,"x",m,")", d, "DOTS\n");
  # Dumping if requested (dflg=1).
  if (dflg==1) {dump(c("X","Y"), df); cat(" *** Dump file:", df, "\n")};
  # Plotting
  if (ttl!="") {
    plot(X,Y, main=ttl, axes=FALSE, xlab="", ylab="", col=clr, pch=20, cex=cx)}
  else {par(mar=c(0,0,0,0));
    plot(X,Y, axes=FALSE, xlab=NULL, ylab=NULL, col=clr, pch=20, cex=cx)};
  # Writing png-file
  dev.copy(png, filename=pf, width=psz, height=psz);
  # Cleaning
  dev.off(); graphics.off();
}

## HFR#2 plotv2(): Simple plotting using 2 vectors (dumped into ".dmp" file).
# Where: fn - file name; clr - color; ttl - plot title; psz - picture size;
#        cx - cex or scale.
plotv2 <- function(fn, clr, ttl, psz=600, cx=1.0) {
  cat(" *** START:", date(), "clr=", clr, "psz=", psz, "\n");
  pf = paste0(fn, ".png"); df = paste0(fn, ".dmp");
  source(df); d = length(X);
  cat(" *** Plot file -", pf, "Source dump-file:", df, d, "DOTS\n");
  # Plotting
  if (ttl!="") {
    plot(X,Y, main=ttl, axes=FALSE, xlab="", ylab="", col=clr, pch=20, cex=cx)}
  else {par(mar=c(0,0,0,0));
    plot(X,Y, axes=FALSE, xlab=NULL, ylab=NULL, col=clr, pch=20, cex=cx)};
  # Writing png-file
  dev.copy(png, filename=pf, width=psz, height=psz);
  # Cleaning
  dev.off(); graphics.off();
  cat(" *** END:", date(), "\n");
}

## Kronecker power of a matrix.
## Where: m - initial matrix, n - power.
matkronpow <- function(m, n) {
  if (n<2) {return (m)};
  r = m; n = n-1;
  for(i in 1:n) {r = r %x% m};
  return (r);
}

## Generate and plot Kronecker product based fractals.
## gpKronFractal(m, n, pf, clr, ttl, dflg, psz, cx):
## Where: m - initial matrix (filled with 0/int); n - order of the fractal;
## fn - plot file name (without extension); clr - color; ttl - plot title;
## dflg - writing dump file flag (0/1); psz - picture size; cx - cex.
gpKronFractal <- function(m, n, fn, clr, ttl, dflg=0, psz=2000, cx=3.5) {
  fign="Kpbf";
  cat(" *** START:", date(), "n=", n, "clr=", clr, "psz=", psz, "\n");
  if(fn=="") {fn=paste0(fign,"o", n)} else {fn=paste0(fn)};
  if(ttl!="") {ttl=paste0(ttl,", order ", n)};
  cat(" *** Plot file -", fn, "title:", ttl, "\n");
  r = matkronpow(m, n);
  plotmat(r, fn, clr, ttl, dflg, psz, cx);
  cat(" *** END:", date(), "\n");
}

mat <- matrix(sample(c(1, 0), 10, replace = TRUE),
              ncol = 2)

mod <- matrix(c(1,2,1,3,1,3,4, 1,0,0,2,0,4,1, 1,4,1,1,1,7,1, 1,0,1,1,1,0,1,
 1,0,1,1,1,0,1, 1,0,0,0,0,0,1, 1,1,1,1,1,1,1), ncol=7, nrow=7, byrow=TRUE)

M <- matrix(rnorm(rep(rep(sample(0:1), 7), 4)), ncol = 7, nrow = 7)

gpKronFractal(m = M, n = 4,
              fn = "out4.png", 
              clr = c("red", "blue", "cyan"), 
              ttl = "one", psz = 1000, cx = 10)
