#!/usr/bin/perl
# This script adds a text identifier at the begining of the fastq header, simply enter the name of the fastq file, then the text you want to add to the begining of each fastq header - keep it simnple, no hashes or colons or stuff just text, numbers and underscores for spaces please


@files = @ARGV;

open(INFILE, "$ARGV[0]"); # opens fastq file
$filename = $ARGV[0];
print "$filename\n->\n";
$filename = $ARGV[1];
print "$filename\n";
open(OUT, ">$filename");

$header_change = $ARGV[2];
$header_change = "@".$header_change;

print "\nOK, starting.\n";

$count = 0;
while ($fastq_line = <INFILE>)
{
    if (substr($fastq_line,0,1) ne "@"){print OUT"$fastq_line"; next;}
 
    $fastq_line =~ s/@/$header_change/;
	print OUT"$fastq_line";$count ++;
}

print "\n\n$count lines changed\n\n";

close(OUT);
close(INFILE);
