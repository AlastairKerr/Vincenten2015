#  Scripts for the Vincenten et al 2015 paper 

# Title:  

The kinetochore controls crossover recombination during meiosis

# Authors

Nadine Vincenten Lisa-Marie Kuhl, Isabel Lam, Ashwini Oke, Alastair Kerr, Andreas Hochwagen, Jennifer Fung, Scott Keeney, Gerben Vader and Adele L. Marston


# Files: 


workflow1.sh        # details of the mapping process

CENTROMERE.gff      # location of the regions of interest

rDNA.bed           # rDNA regions excluded from analysis

EveryCen-boxplot.pl # perl script for preparing the data for R 

plot-every-cen.r    # create R plots for each centromere 

plot_median.r #Plots for fig 3 B & C 



# Details: 

In each chromosome a 50kb region is examined with the centromere in
the centre. (i.e. centromere with 25kb flanks) 500 windows, each 100bp
are taken across this region in each chromosome and the ratio of reads
(normalised to RPM) over input is taken. So for each window we have 16
values, (one per chromosome) 

