## dnbr.hexbinplots.R
## re-do these...

library(ggplot2)
library(ggpubr)
library(wesanderson)
library(reshape2)
library(raster)
library(sf)

out<-'./plots/dnbr.hexbins/'

## random sample data 
z<-read.table("./data/spp.maxd.mod2.txt")
names(z)<-c("maxdnbr","x","y","opt","index","pinstr","pineng","pinari","pindis","pinchi","island")

## plot
##  all islands
pal3=wes_palette("Cavalcanti1", 100, type = "continuous")

u<-unique(z$island)
for (i in 1:length(u)) {
 
  dat.isl1<-z[z$island==u[i],]
  ggplot(dat.isl1, aes(x, y, z=maxdnbr)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette = "RdYlGn",direction=-1, limits=c(-150, 800), breaks=c(0,200,400, 600)) +  
    theme_dark() + guides(fill=guide_legend(title="Burn severity (dNBR)")) +  
    theme(legend.position = "top", legend.title=element_text(size=20)) +  labs(title="", x="Easting", y="Northing") 
    ggsave(paste(out,u[i],".png",sep=""), width=10, height=8)
  
}

