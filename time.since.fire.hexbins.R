## time.since.fire.hexbins.R
## use the fire perimeters to calc tsf
## output hexbin plots


library(ggplot2)
library(ggpubr)
library(wesanderson)
library(reshape2)
library(raster)
library(sf)

out<-'./plots/timesincefire.hexbins/'

## random sample data 
z<-read.table("./data/spp.maxd.mod2.txt")
names(z)<-c("maxdnbr","x","y","opt","index","pinstr","pineng","pinari","pindis","pinchi","island")
z<-z[complete.cases(z$pinstr),] # 30 no data for spp
coordinates(z)<-~ x + y
crs(z)<-"+proj=utm +zone=12 +datum=WGS84 +units=m +no_defs"
## fire perims, select year <2012 to match dnbr and times burned data
perims<-read_sf("../skyislands.SIRC/fire.regimes/data/sp/perims.centxy.attributes.shp")
perims2<-perims[perims$Year < 2012,]

## sample
o1<-over(z, as_Spatial(perims2))
o1$tsf<-2011 - as.numeric(o1$Year)
dat<-cbind(data.frame(z), o1)
#dat[is.na(dat$N.fires100m), 14]<-0 # na's prob due to mismatch btwn fire perimeter and times burned layer

## plot
##  all islands
u<-unique(dat$island)
for (i in 1:length(u)) {
 
  dat.isl1<-dat[dat$island==u[i],]
  ggplot(dat.isl1, aes(x, y, z=tsf)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette = "Blues", direction=-1, limits=c(0,26) ) + #,breaks=c(2,5,10,15, 20)) +  
    theme_dark() + guides(fill=guide_legend(title="Time since fire (yrs)")) +  
    theme(legend.position = "top", legend.title=element_text(size=20)) +  labs(title="", x="Easting", y="Northing") 
    ggsave(paste(out,u[i],".png",sep=""), width=10, height=8)
  
}


