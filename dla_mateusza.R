library(sp)
library(rgdal)
library(maptools)
wgs84 <-  CRS('+init=epsg:4326')

ramka <- data.frame(lon=rnorm(1000, 20, 2),lat=rnorm(1000, 50, 2), zjawiska=round((runif(1000)*5))) # jakies wspolrzedne

coordinates(ramka) <- ~lon+lat
proj4string(ramka) <- wgs84


library(raster)
X=seq(from=-10, to=40, by=0.25)
Y=rev(seq(from=35, to=75, by=0.25))

r <- raster(ncol=length(X), nrow=length(Y), xmn=X[1],
            xmx=X[length(X)], ymn=Y[length(Y)], ymx=Y[1]) ## stworzenie obiektu rastrowego
res(r) <- 0.25
proj4string(r) <- CRS('+init=epsg:4326')

tatam <- rasterize(ramka, r, field='zjawiska', fun=sum)
plot(tatam)
library(mapdata)
map('world',add=T)
