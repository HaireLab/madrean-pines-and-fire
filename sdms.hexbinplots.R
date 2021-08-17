## sdms.hexbinplots.R
## make heat maps of the terrain + ndvi predict models
## for ea of the 30 islands that had fires from 1985-2011

library(ggplot2)
library(ggpubr)
library(reshape2)
library(raster)
library(sf)

out<-'./plots/sdms.hexbins/'
sdmpath<-"../skyisland.pines/data/raster/spatial.predict30m"
homedir<-getwd()

## random sample data 
z<-read.table("./data/spp.maxd.mod2.txt")
names(z)<-c("maxdnbr","x","y","opt","index","pinstr","pineng","pinari","pindis","pinchi","island")
z<-z[complete.cases(z$pinstr),] # 30 no data for spp
coordinates(z)<-~ x + y
crs(z)<-'+proj=utm +zone=12 +datum=WGS84 +units=m +no_defs'
z.geo<-spTransform(z, '+proj=longlat +datum=WGS84 +no_defs') # to match sdms
## read in the predict models, stack
sdmlist<-list.files(sdmpath, "mask")
setwd(sdmpath)
s<-stack(sdmlist)
## sample
ex1<-extract(s, z.geo, method="bilinear", df=TRUE)
z.df<-data.frame(z.geo)
dat<-cbind(z.df[,c(9,10,11)], ex1)
dat[is.na(dat)]<-0
setwd(homedir)

## plot
##  all islands
u<-unique(dat$island)
for (i in 1:length(u)) {
  dat.isl1<-dat[dat$island==u[i],]
  ggplot(dat.isl1, aes(x, y, z=pinari.topo.ndvi30.mask)) + stat_summary_hex(bins=20) +  
   scale_fill_distiller(palette="Greens",limits=c(0,0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0))  + 
    theme_dark() + guides(fill=guide_legend(title="dNBR")) + theme(legend.position = "top", legend.title=element_text(size=20)) + 
    labs(title="", x="Easting", y="Northing") + guides(fill=guide_legend(title="Predicted probability")) 
    ggsave(paste(out,u[i],".pinari.png", sep=""), height=8, width=10)
   
   ggplot(dat.isl1, aes(x, y, z=pinchi.topo.ndvi30.mask)) + stat_summary_hex(bins=20) +  
   scale_fill_distiller(palette="Greens",limits=c(0,0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0))  + 
    theme_dark() + guides(fill=guide_legend(title="dNBR")) + theme(legend.position = "top", legend.title=element_text(size=20)) + 
    labs(title="", x="Easting", y="Northing") + guides(fill=guide_legend(title="Predicted probability")) 
    ggsave(paste(out,u[i],".pinchi.png", sep=""), height=8, width=10)
   
   ggplot(dat.isl1, aes(x, y, z=pindis.topo.ndvi30.mask)) + stat_summary_hex(bins=20) +  
   scale_fill_distiller(palette="Greens",limits=c(0,0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0))  + 
    theme_dark() + guides(fill=guide_legend(title="dNBR")) + theme(legend.position = "top", legend.title=element_text(size=20)) + 
    labs(title="", x="Easting", y="Northing") + guides(fill=guide_legend(title="Predicted probability")) 
     ggsave(paste(out,u[i],".pindis.png", sep=""), height=8, width=10)
   
   ggplot(dat.isl1, aes(x, y, z=pineng.topo.ndvi30.mask)) + stat_summary_hex(bins=20) +  
   scale_fill_distiller(palette="Greens",limits=c(0,0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0))  + 
    theme_dark() + guides(fill=guide_legend(title="dNBR")) + theme(legend.position = "top", legend.title=element_text(size=20)) + 
    labs(title="", x="Easting", y="Northing") + guides(fill=guide_legend(title="Predicted probability")) 
      ggsave(paste(out,u[i],".pineng.png", sep=""), height=8, width=10)
   
   ggplot(dat.isl1, aes(x, y, z=pinstr.topo.ndvi30.mask)) + stat_summary_hex(bins=20) +  
   scale_fill_distiller(palette="Greens",limits=c(0,0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0))  + 
    theme_dark() + guides(fill=guide_legend(title="dNBR")) + theme(legend.position = "top", legend.title=element_text(size=20)) + 
    labs(title="", x="Easting", y="Northing") + guides(fill=guide_legend(title="Predicted probability")) 
    ggsave(paste(out,u[i],".pinstr.png", sep=""), height=8, width=10)
   
}
