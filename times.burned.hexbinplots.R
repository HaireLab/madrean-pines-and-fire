## times.burned.hexbinplots.R
## make similar graphs to the dnbr max heat maps
## for ea of the 30 islands that had fires from 1985-2011

library(ggplot2)
library(ggpubr)
library(wesanderson)
library(reshape2)
library(raster)
library(sf)

out<-'./plots/times.burned.hexbins/'

## random sample data 
z<-read.table("./data/spp.maxd.mod2.txt")
names(z)<-c("maxdnbr","x","y","opt","index","pinstr","pineng","pinari","pindis","pinchi","island")
z<-z[complete.cases(z$pinstr),] # 30 no data for spp
coordinates(z)<-~ x + y
## times burned
tb<-raster("./data/N.fires100m.tif")
crs(z)<-crs(tb)

## sample
ex1<-extract(tb, z, method="simple", df=TRUE)
dat<-cbind(data.frame(z), ex1)
#dat[is.na(dat$N.fires100m), 14]<-0 # na's prob due to mismatch btwn fire perimeter and times burned layer

## plot
##  all islands


u<-unique(dat$island)
for (i in 1:length(u)) {
 
  dat.isl1<-dat[dat$island==u[i],]
  ggplot(dat.isl1, aes(x, y, z=N.fires100m)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette = "Spectral",direction=1, limits=c(1,5),breaks=c(1,2,3,4)) +  
    theme_dark() + guides(fill=guide_legend(title="Times burned")) +  
    theme(legend.position = "top", legend.title=element_text(size=20)) +  labs(title="", x="Easting", y="Northing") 
    ggsave(paste(out,u[i],".png",sep=""), width=10, height=8)
  
}



