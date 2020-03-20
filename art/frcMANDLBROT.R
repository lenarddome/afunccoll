# mandelbrot_vectorized.R
# Myles Harrison
# http://www.everydayanalytics.ca

# z_n + 1 = {z^2}_n + c

# parameters
cols <- colorRampPalette(c("black","yellow","red","cyan"))(11)
xmin = -.58
xmax = -.40
nx = 500
ymin = -.58
ymax = -.40
ny = 500
n=1000

# variables
x <- seq(xmin, xmax, length.out=nx)
y <- seq(ymin, ymax, length.out=ny)
c <- outer(x,y*1i,FUN="+")
z <- matrix(0.0, nrow=length(x), ncol=length(y))
k <- matrix(0.0, nrow=length(x), ncol=length(y))

for (rep in 1:n) { 
    print(rep)
    index <- which(Mod(z) < 2)
    z[index] <- z[index]^2 + c[index]
    k[index] <- k[index] + 1
}

dev.copy()
png(filename="mand008.png", width = 2160, height = 1080)
image(x,y,k, col=cols)
dev.off()



