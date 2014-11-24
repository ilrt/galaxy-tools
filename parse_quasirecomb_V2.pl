#!/usr/bin/perl
# Calculates the size of fasta files
@files = @ARGV;
if ($files[1] eq "fix"){
	print "\nOK, fixing sam file.\n";
	&fix_mac($files[0]);
}
$POS = 0;
$genome = "";
$test = -1;
$G = 0;
$A = 0;
$T = 0;
$C = 0;
open(INFILE, "$ARGV[0]"); # opens quasirecomd output
open(OUT, ">minor_variants.txt");
open(OUTB, ">consensus.txt");
while($line = <INFILE>)
{
chomp $line;
	# split the line into an array called cells
	($POS,$A,$C,$G,$T) = split(/\t/, $line);
    $A = $A * 1; $G = $G * 1; $C = $C * 1; $T = $T * 1;
    print "$POS\t$a\t$A\t$C\t$G\t$T\n";
    $test = -1;
    $consensus = "N";
    if ($A > $test){$test = $A; $consensus = "A"; print "$test\n$consensus\n";}
    if ($C > $test){$test = $C; $consensus = "C"; print "$test\n$consensus\n";}
    if ($G > $test){$test = $G; $consensus = "G"; print "$test\n$consensus\n";}
    if ($T > $test){$test = $T; $consensus = "T"; print "$test\n$consensus\n";}
    if ($consensus eq "A") {$A = $A * -1;print OUT "$POS\t$A\t$C\t$G\t$T\n";}
    if ($consensus eq "C") {$C = $C * -1;print OUT "$POS\t$A\t$C\t$G\t$T\n";}
    if ($consensus eq "G") {$G = $G * -1;print OUT "$POS\t$A\t$C\t$G\t$T\n";}
    if ($consensus eq "T") {$T = $T * -1;print OUT "$POS\t$A\t$C\t$G\t$T\n";}
    if ($consensus eq "N") {print OUT "$POS\t0\t0\t0\t0\n";}
    $genome = $genome.$consensus;
    print "$POS\t$consensus\n";
}
print OUTB "$genome\n";
	
close(OUT);
close(OUTB);

sub fix_mac
{
	$filefix = $_[0];
	chomp $filefix;
	print "Correcting a file.\n";
	open (OUT, ">temp");
	open (INFILE, "$filefix");
	while (<INFILE>){s/[\r\n]+/\n/g; print OUT "$_";}
	close OUT;
	close INFILE;
	system("mv temp $filefix"); 
}
