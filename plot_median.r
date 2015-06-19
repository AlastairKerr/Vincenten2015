# Use data from EveryCen-boxplot.pl and process taking the ratio of ChIP/ Input 
## Rscript plot_median.r sample1 sample2 output 
 
args <- commandArgs(trailingOnly = TRUE)

# Load data 
sample1 <- read.table(args[1])
sample2 <- read.table(args[2])


library(dplyr)

#calculate the median per region 
sample1_median <- as.data.frame(sample1) %>% summarise_each(funs(median(., na.rm=TRUE) )) 
sample2_median <- as.data.frame(sample2) %>% summarise_each(funs(median(., na.rm=TRUE) )) 


# windows are 100bp, + - 25000bp from the centre of the centromere
Coords <- (1:499 * 100) -25000


#Plot 
pdf(paste(args[3], ".pdf", sep=""), width=15)
plot(Coords, log2(sample1_median), pch='.', col="red", 
	     xlab="Position", ylab="log2 of median ratio of reads: ChIP/Input")
lines (Coords, log2(sample1_median), pch='.', col="red", lw=3)
lines (Coords, log2(sample2_median), pch='.', col="darkblue", lw=3)
