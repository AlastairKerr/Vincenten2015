
#command line a args for RScript
args <- commandArgs(trailingOnly = TRUE)

#read input + chip pairs of data for 2 samples
rmi <- read.table(args[1], header=T) #sample1 input
rmc <- read.table(args[2], header=T) #sample1 chip

rwi <- read.table(args[3], header=T) #sample2 input
rwc <- read.table(args[4], header=T) #sample2 chip

cols <- c("CEN1","CEN2","CEN3","CEN4","CEN5","CEN6","CEN7","CEN8","CEN9","CEN10","CEN11","CEN12","CEN13","CEN14","CEN15","CEN16")

#create a plot for each CEN
for(i in cols){
  #each plot names after cen
   #create a svg file for each CEN
  svg(paste(args[1],i,".svg", sep=""))
   
 par(cex.lab=1.4)
  # init plot 
  plot(rwc$Position, log2(rwc[[i]]/rwi[[i]] ),   
      xlim=c(-10000,10000), 
       ylim=c(-2,5), 
       pch='.', xlab="Position", ylab="Sample/Input")
# add lines for each
  lines(rwc$Position, log2( rwc[[i]]  / rwi[[i]] ),  col="red",  lwd=3)
  lines(rwc$Position, log2( rmc[[i]]  / rmi[[i]] ),  col="blue", lwd=3)


  axis(1, lwd=2)
  axis(2, lwd=2)
}         
    
