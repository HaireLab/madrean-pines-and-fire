##glm.spprob.dnbr.R
## output regression coefficients to look for trends in fire and spp
## only one that is worthwhile is gam for overall
## try glm by island too
## use a uniform subsample across prob values

library(quantreg)
library(mgcv)

z<-read.table("spp.maxd.mod2.txt") #167244 rows this one w/out fire predictors
names(z)<-c("maxdnbr","x","y","opt","index","pinstr","pineng","pinari","pindis","pinchi","island")
z<-z[complete.cases(z$pinstr),]

## across islands

gam1<-gam(pinstr~s(maxdnbr), data=z)
gam2<-gam(pinari~s(maxdnbr), data=z)
gam3<-gam(pineng~s(maxdnbr), data=z)
gam4<-gam(pindis~s(maxdnbr), data=z)
gam5<-gam(pinchi~s(maxdnbr), data=z)


#mod1<-glm(pinstr~ maxdnbr, data=z)
x=z$maxdnbr
y=z$pinstr
plot(x,y,cex=.25,type="n",xlab="", ylab="")
mtext(paste("Burn severity"), line=2.5,font=2, side=1,cex=1.2)
mtext(paste("P. strobiformis"), line=2.5,font=2, side=2,cex=1.2)
#mtext(paste("Limits to Severity\n Across the Wilderness Gradient\n1984-2010",sep=""),font=2,cex=1.5)
points(x,y,cex=.5,col="black",pch=16)
abline(rq(y~x,tau=.5),col="blue",lwd=2)
taus <- c(.1,.2,.8,.9)
for( i in 1:length(taus)){
  abline(rq(y~x,tau=taus[i]),col="black",lwd=2)
}

taus <- c(.1,.2,.8,.9)
m1sum<-summary(rq(pinstr~maxdnbr,tau=taus,iid=F,data=z))

## for each island



## ex
tiff(file="./slides/WGrq.allyears_fig%03d.tif",width=6.1,height=6.8,units="in",res=300,compression="lzw")
par(mfrow=c(1,1))
x<-z$wg ## wilderness gradient
y<-z$dnbr ## neiborhood severity

plot(x,y,cex=.25,type="n",xlab="", ylab="")
mtext(paste("Wilderness Gradient"), line=2.5,font=2, side=1,cex=1.2)
mtext(paste("Neighborhood Severity"), line=2.5,font=2, side=2,cex=1.2)
mtext(paste("1984-2010",sep=""),font=2,cex=1.5)
#mtext(paste("Limits to Severity\n Across the Wilderness Gradient\n1984-2010",sep=""),font=2,cex=1.5)
points(x,y,cex=.5,col="black",pch=16)
abline(rq(y~x,tau=.5),col="blue",lwd=2)
taus <- c(.1,.2,.8,.9)
for( i in 1:length(taus)){
  abline(rq(y~x,tau=taus[i]),col="black",lwd=2)
}

dev.off()

## to access the coefficients for tau = taus[1]; first model z1
zlist[[1]][[1]][3]$coefficients
zlist[[1]][[1]][3]$coefficients[2,1] ## intercept for x1
