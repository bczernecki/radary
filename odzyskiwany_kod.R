library(dplyr)
library(raster)
library(fields)

file <- "blob1.2017100519200000dBZ.cmax"
file <- "blob2.2017100519200000dBZ.cmax"
# a <-  readBin(file, numeric(), 810000) 
# a <-  readBin(file, numeric(), 810000) 
# a <-  readBin(file, what = "integer", 1000, size = 1, signed = F,endian = "big") 
#  a <- readBin(file, what = "integer", 810000, size = 1, signed = F,endian = "big") 
#  a <- readBin(file, "raw", 810000,endian="endian")
# #
a <- readBin(file, "int", 90000000, size=1,signed = F)
a <- a[-length(a)]
dxdy <- sqrt(length(a))
a[which(a==0)] <- NA
#b <- matrix(a, ncol=450, nrow=450, byrow = F)
b <- matrix(a, ncol=dxdy, nrow=dxdy, byrow = F)
# b <- matrix(rep(a, each=2), ncol=dxdy*2, nrow=dxdy, byrow = F) to jest dla maski jakosci
str(b)
mindbz = -31.5;
maxdbz = 95.5;
b <- (b/2-31.5)
b[which(b<0)] <- NA

r <- raster(x=t(b),xmn=11.812900,xmx=25.157600, ymn=48.133400, ymx=56.186500,
            crs=CRS("+proj=aeqd +lat_0=52.346900 +lon_0=19.092600 +ellps=sphere")) ## stworzenie obiektu rastrowego
plot(r)
map('world',add=T)
#res(r) <- 0.25
#proj4string(r) <- CRS('+proj=longlat +ellps=sphere +no_defs')
projection(r)
proj4string(r)

image(r, col=tim.colors(n=64), xlim=c(13,25))
#writeRaster(r, filename = "test.tif")
plot(r, col=tim.colors(42))
map('world',add=T)