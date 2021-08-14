## all.islands.spp.fires.R
## use the sample of maxdnbr and the pred prob for spp--all islands
## find where ea spp is predicted to be most common
## fire regimes?

out<-'/cloud/project/plots/all.30.islands/'
out2<-'/cloud/project/plots/isl30.scatter/'
out3<-'/cloud/project/plots/maxdnbr.30islands/'

library(ggplot2)
library(ggpubr)
library(reshape2)
library(plyr)

#z<-read.table("spp.maxd.30isl.txt") #167244 rows
z<-read.table("spp.maxd.mod2.txt") #167244 rows this one w/out fire predictors
names(z)<-c("maxdnbr","x","y","opt","index","pinstr","pineng","pinari","pindis","pinchi","island")
z<-z[complete.cases(z$pinstr),]

x<-ddply(z[,6:11], .(island), numcolwise(mean))
xq<-ddply(z[,6:11], .(island), numcolwise(quantile))
x.max<-ddply(z[,6:11], .(island), numcolwise(max))
x.mean<-ddply(z[,6:11], .(island), numcolwise(mean))

write.table(x.max, "island.spp.max2.txt")
write.table(x.mean, "island.spp.mean2.txt")

## spp on ea island, hexbins
u<-unique(z$island)
for (i in 1:length(u)) {
  #xpression(paste("Mapped territories of different ", italic("C. austriacus")
  z1<-z[z$island==u[i],]
  ggplot(z1, aes(x, y, z=pinari)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette="Greens",limits=c(0, 0.9), direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0)) + 
    theme_dark() + guides(fill=guide_legend(title="Probability \nof presence")) +
    labs(title="P. arizonica") + theme(plot.title = element_text(size = 20, face = "bold.italic"))
  #ggsave(paste(out, "test.png", sep=""))
  ggsave(paste(out, u[i],".pinari.png", sep=""))
  
  ggplot(z1, aes(x, y, z=pindis)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette="Greens",limits=c(0,0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0)) +
    theme_dark()  + guides(fill=guide_legend(title="Probability \nof presence")) +
    labs(title="P. discolor") + theme(plot.title = element_text(size = 20, face = "bold.italic"))
  ggsave(paste(out,u[i],".pindis.png", sep=""))
  
  ggplot(z1, aes(x, y, z=pinstr)) + stat_summary_hex(bins=20) + 
    scale_fill_distiller(palette="Greens", limits=c(0, 0.9), direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0)) + 
    theme_dark() + guides(fill=guide_legend(title="Probability \nof presence")) +
    labs(title="P. strobiformis") + theme(plot.title = element_text(size = 20, face = "bold.italic"))
  ggsave(paste(out,u[i],".pinstr.png", sep=""))
  
  ggplot(z1, aes(x, y, z=pineng)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette="Greens", limits=c(0, 0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0)) + 
    theme_dark() + guides(fill=guide_legend(title="Probability \nof presence")) +
    labs(title="P. engelmannii") + theme(plot.title = element_text(size = 20, face = "bold.italic"))
  ggsave(paste(out,u[i],".pineng.png", sep=""))
  
  ggplot(z1, aes(x, y, z=pinchi)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette="Greens", limits=c(0, 0.9),direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0)) + 
    theme_dark() + guides(fill=guide_legend(title="Probability \nof presence")) +
    labs(title="P. chihuahuana") + theme(plot.title = element_text(size = 20, face = "bold.italic"))
  ggsave(paste(out,u[i],".pinchi.png", sep=""))
  
}

## scatter plots--all 30 islands
p1<-ggscatter(z, x="pinstr", y="maxdnbr", size=0.3, color="green",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold"))
ggpar(p1, xlab="P. strobiformis", ylab="Burn severity")
ggsave(paste(out2,"pinstr.scatter.png", sep=""), width=12,height=12)

p1<-ggscatter(z, x="pineng", y="maxdnbr", size=0.3, color="orchid",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold"))
ggpar(p1, xlab="P. engelmannii", ylab="Burn severity")
ggsave(paste(out2,"pineng.scatter.png", sep=""), width=12,height=12)

p1<-ggscatter(z, x="pinari", y="maxdnbr", size=0.3, color="yellow",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold"))
ggpar(p1, xlab="P. arizonica", ylab="Burn severity")
ggsave(paste(out2,"pinari.scatter.png",sep=""), width=12,height=12)

p1<-ggscatter(z, x="pinchi", y="maxdnbr", size=0.3, color="turquoise3",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold"))
ggpar(p1, xlab="P. chihuahuana", ylab="Burn severity")
ggsave(paste(out2,"pinchi.scatter.png",sep=""), width=12,height=12)

p1<-ggscatter(z, x="pindis", y="maxdnbr", size=0.3, color="orange",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold"))
ggpar(p1, xlab="P. discolor", ylab="Burn severity")
ggsave(paste(out2,"pindis.scatter.png",sep=""), width=12,height=12)

## scatter plots--selected islands
## strobiformis
u2<-u[c(5,8,12,21)]
z.str<-z[z$island %in% u2,]
p1<-ggscatter(z.str, x="pinstr", y="maxdnbr", size=0.3, color="green",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold", size=14))
ggpar(p1, xlab="P. strobiformis", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,1))
ggsave(paste(out2,"pinstr.scatter4.png", sep=""))
# engelmannii
u2<-u[c(8,9,13,23)]
z.eng<-z[z$island %in% u2,]
p1<-ggscatter(z.eng, x="pineng", y="maxdnbr", size=0.3, color="orchid",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold", size=14))
ggpar(p1, xlab="P. engelmannii", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,1))
ggsave(paste(out2,"pineng.scatter4.png", sep=""))
# arizonica
u2<-u[c(5,12,18,26)]
z.ari<-z[z$island %in% u2,]
p1<-ggscatter(z.ari, x="pinari", y="maxdnbr", size=0.3, color="yellow",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold",size=14))
ggpar(p1, xlab="P. arizonica", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,1))
ggsave(paste(out2,"pinari.scatter4.png",sep=""))
# chi
u2<-u[c(3,5,12,18)]
z.chi<-z[z$island %in% u2,]
p1<-ggscatter(z.chi, x="pinchi", y="maxdnbr", size=0.3, color="turquoise3",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold",size=14))
ggpar(p1, xlab="P. chihuahuana", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,1))
ggsave(paste(out2,"pinchi.scatter4.png",sep=""))
#discolor
u2<-u[c(4,18,21,26)]
z.dis<-z[z$island %in% u2,]
p1<-ggscatter(z.dis, x="pindis", y="maxdnbr", size=0.3, color="orange",facet.by=c("island"), cor.coef=TRUE) +  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold",size=14))
ggpar(p1, xlab="P. discolor", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,1))
ggsave(paste(out2,"pindis.scatter4.png",sep=""))

# 6 islands in prez
u2<-u[c(5, 21, 25,12,16,10)]
############## really only need to make the df once!!!!!!!!!
z.dis<-z[z$island %in% u2,]
z.dis$island <- factor(z.dis$island,levels=c("CHIRICAHUA", "PINALENO","SANTA-CATALINA","HUACHUCA-PATAGONIA",
                                             "MARIQUITA","EL-TIGRE"))
p1<-ggscatter(z.dis, x="pindis", y="maxdnbr", size=0.3, color="orange",facet.by=c("island"), 
              add="reg.line",add.params=list(color="black", linetype=1, size=1)) +
  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold",size=14))
ggpar(p1, xlab="P. discolor", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,0.75), font.x=c(14,"bold.italic"), font.y=c(14, "bold"))
ggsave(paste(out2,"pindis.scatter6.png",sep=""))

z.chi<-z[z$island %in% u2,]
z.chi$island <- factor(z.chi$island,levels=c("CHIRICAHUA", "PINALENO","SANTA-CATALINA","HUACHUCA-PATAGONIA",
                                             "MARIQUITA","EL-TIGRE"))

p1<-ggscatter(z.chi, x="pinchi", y="maxdnbr", size=0.3, color="turquoise3",facet.by=c("island"), 
              add="reg.line",add.params=list(color="black", linetype=1, size=1)) +
theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold",size=14))
ggpar(p1, xlab="P. chihuahuana", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,0.75), font.x=c(14,"bold.italic"), font.y=c(14, "bold"))
ggsave(paste(out2,"pinchi.scatter6.png",sep=""))

z.ari<-z[z$island %in% u2,]
z.ari$island <- factor(z.ari$island,levels=c("CHIRICAHUA", "PINALENO","SANTA-CATALINA","HUACHUCA-PATAGONIA",
                                             "MARIQUITA","EL-TIGRE"))

p1<-ggscatter(z.ari, x="pinari", y="maxdnbr", size=0.3, color="yellow",facet.by=c("island"), 
              add="reg.line",add.params=list(color="black", linetype=1, size=1)) +
  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold",size=14))
ggpar(p1, xlab="P. arizonica", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,0.75), font.x=c(14,"bold.italic"), font.y=c(14, "bold"))
ggsave(paste(out2,"pinari.scatter6.png",sep=""))

z.eng<-z[z$island %in% u2,]
z.eng$island <- factor(z.eng$island,levels=c("CHIRICAHUA", "PINALENO","SANTA-CATALINA","HUACHUCA-PATAGONIA",
                                             "MARIQUITA","EL-TIGRE"))

p1<-ggscatter(z.eng, x="pineng", y="maxdnbr", size=0.3, color="orchid",facet.by=c("island"), 
              add="reg.line",add.params=list(color="black", linetype=1, size=1)) +  
  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold", size=14))
ggpar(p1, xlab="P. engelmannii", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,0.75), font.x=c(14,"bold.italic"), font.y=c(14, "bold"))
ggsave(paste(out2,"pineng.scatter6.png", sep=""))

z.str<-z[z$island %in% u2,]
z.str$island <- factor(z.str$island,levels=c("CHIRICAHUA", "PINALENO","SANTA-CATALINA","HUACHUCA-PATAGONIA",
                                             "MARIQUITA","EL-TIGRE"))

p1<-ggscatter(z.str, x="pinstr", y="maxdnbr", size=0.3, color="green",facet.by=c("island"), 
              add="reg.line",add.params=list(color="black", linetype=1, size=1))  + 
  theme_dark() + theme(strip.text = element_text(colour = "white", face = "bold", size=14))
ggpar(p1, xlab="P. strobiformis", ylab="Burn severity", ylim=c(-500, 1050), xlim=c(0,0.75), font.x=c(14,"bold.italic"), font.y=c(14, "bold"))
ggsave(paste(out2,"pinstr.scatter6.png", sep=""))

## dnbr hexbins
# el gato
z.gato<-z[z$island=="EL-GATO",]
ggplot(z.gato, aes(x, y, z=maxdnbr)) + stat_summary_hex(bins=20) +  
  scale_fill_distiller(palette = "YlOrRd",limits=c(-150, 800),direction=1, breaks=c(0,200,400, 600))  +  theme_dark() + 
  guides(fill=guide_legend(title="dNBR")) +  labs(title="Burn Heterogeneity") +
  theme(plot.title = element_text(size = 20, face = "bold"))

ggsave(paste(out2,"maxdnbr.gato.png",sep=""))

# ppd
z.ppd<-z[z$island=="PELONCILLO-PAN",]
ggplot(z.ppd, aes(x, y, z=maxdnbr)) + stat_summary_hex(bins=20) +  
  scale_fill_distiller(palette = "YlOrRd",limits=c(-150, 800),direction=1, breaks=c(0,200,400, 600))  +  theme_dark() + 
  guides(fill=guide_legend(title="Burn severity")) 
ggsave(paste(out2,"maxdnbr.ppd.png",sep=""))

##  all islands
u<-unique(z$island)
for (i in 1:length(u)) {
 
  z.isl1<-z[z$island==u[i],]
  ggplot(z.isl1, aes(x, y, z=maxdnbr)) + stat_summary_hex(bins=20) +  
    scale_fill_distiller(palette = "YlOrRd",limits=c(-150, 800),direction=1, breaks=c(0,200,400, 600))  +  theme_dark() + 
    guides(fill=guide_legend(title="dNBR")) +  labs(title="Burn Heterogeneity") +
    theme(plot.title = element_text(size = 20, face = "bold"))
    ggsave(paste(out3,u[i],"maxdnbr.png",sep=""))
  
}

## just chiricahua, with high value gaps #########not working
zhs.ch<-z[z$island=="CHIRICAHUA",]
zhs.ch2<-zhs.ch[zhs.ch$maxdnbr<500,]

ggplot(zhs.ch2, aes(x, y, z=pinstr)) + stat_summary_hex(bins=20) + 
  scale_fill_distiller(palette="Greens", limits=c(0, 0.9), direction=1, breaks=c(0.2, 0.4,0.6,0.8, 1.0)) + 
  theme_dark() + guides(fill=guide_legend(title="Probability \nof presence")) +
  labs(title="P. strobiformis") + theme(plot.title = element_text(size = 20, face = "bold.italic"))
ggsave(paste(out,u[i],".pinstr.png", sep=""))
