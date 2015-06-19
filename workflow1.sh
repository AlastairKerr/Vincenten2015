#!/bin/bash

#input is a fastq file '$1'
export DB=~genomes/s.cerevisiae/sacCer3/bwa_indexes/sacCer3

#bwa alignment: paper used version  0.7.5a-r405 
echo "## Aligning using bwa" 
bwa mem -t 30 $DB $1  > $2.sam 2> $1.err



#sam to bam
# samtools version used: 1.2
echo "## Converting sam to bam, and remove unmapped reads" 
samtools view -h -b -S -F 4 $2.sam > $2.bam
samtools view -h -b -S  $2.sam > $2-info.bam

# Used to check mapping % 
samtools flagstat $2-info.bam > $2.fs
rm $2-info.bam

#sort 
echo "## sorting bam"
samtools sort -@ 20 $2.bam $2-all



#remove 'dupicates' not usually useful as we expect saturation of read depth
echo "## removing duplicates" 
samtools rmdup -s $2-all.bam $2-rmdup.bam


#remove intermediate  #tidy up
echo "## remove intermediate & tidy up"
rm $2.bam 
gzip -9 $2.sam & 

#remove rDNA region
# bedtools version used : v2.17.0
echo "## intersecting"
bedtools intersect -v -abam $2-rmdup.bam -b rDNA.bed  > $2-rDNA-rmdup.bam
bedtools intersect -v -abam $2-all.bam -b rDNA.bed  > $2-rDNA-all.bam

#Scale to reads per milion mapped reads (RPM)
#bedgraph files used to to calculate reads over centromere
num1=`samtools flagstat  $2-rDNA-all.bam | grep nan|grep mapped | grep nan |cut -f1 -d ' '` 
num1b=`perl -e "print 1000000/$num1"` 
genomeCoverageBed -ibam $2-rDNA-all.bam -bg -scale $num1b >  $2-rDNA-all.bg 

echo "## processing coverage using a scale factor of $num1b"

num2=`samtools flagstat  $2-rDNA-rmdup.bam | grep mapped | grep nan |cut -f1 -d ' '`
num2b=`perl -e "print 1000000/$num2"` 
echo "## processing dedup coverage and using scale factor of $num2b"

genomeCoverageBed -ibam $2-rDNA-rmdup.bam -bg -scale $num2b >  $2-rDNA-rmdup.bg 

#create bigwig files for viewing
#used version 4 
wigToBigWig $2-rDNA-all.bg sacCer3.fa.lengths $2-all.bw &
wigToBigWig $2-rDNA-rmdup.bg sacCer3.fa.lengths $2-dedup.bw &

