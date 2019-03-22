#!/usr/bin/perl
##########################################################################################################################################
#  Author   :  AHMAD RIFKY IDRUS
#  DATE     : 2014-03-04
#  COMPANY  : PRIVATE
#  ACTION  :  TAT diameter measurement
#  HOW TO USE:            tshark -V -r <file name>|perl Tatmeasurev6.pl
#   EXAMPLE:              tshark -V -r Diameter.pcap -R diameter.cmd.code==272|perl Tatmeasurev6.pl 
#   or:
#                         tshark -V -r HTTP_SOAP.cap -Y "xml.cdata && (ip.dst==10.128.56.102||ip.src==10.128.56.102)"|perl Tatmeasurev3.txt
#
#	SPEED: 
#	process 512 MB diameter pcap = 50 secs
#    started  at Wed Mar  5 01:30:02 2014
#    executed stopped at Wed Mar  5 01:30:51 2014
#
#
#     SPEED:
#
#	Process 1,8 GB diameter pcaap = 2 minutes 44 seconds
#	started  at Wed Mar  5 01:34:40 2014
# range 100-100000 : 32352  percentage :67.84
# range 11-20 : 3  percentage :0.01
# range 21-30 : 72  percentage :0.15
# range 31-40 : 464  percentage :0.97
# range 41-50 : 3497  percentage :7.33
# range 51-61 : 6939  percentage :14.55
# range 62-80 : 4362  percentage :9.15
# executed stopped at Wed Mar  5 01:37:24 2014
#        OR
#  started  at Wed Mar  5 11:40:37 2014
# range 0-50 : 3523  percentage :7.39
# range 101-150 : 4473  percentage :9.38
# range 151-200 : 1327  percentage :2.78
# range 201-250 : 1044  percentage :2.19
# range 251-100000 : 21348  percentage :44.77
# range 51-100 : 15974  percentage :33.50
# executed stopped at Wed Mar  5 11:43:09 2014
#					
##########################################################################################################################################

  
 my %tatconfignya ;
 my %theresponse ;
 my %mysum ;


 ########### insert array untuk ranges #################;

while ( <DATA> ) {

@rangesdata = split /\|/ ;

#masukan rangne minimum sebagai key , = range maksimumnya
$tatconfignya{$rangesdata[0]} = $rangesdata[1];

$mymax{$rangesdata[0]} = $rangesdata[2];

#print "aduh $mymax{$rangesdata[0]} \n" ;

}


#################### measuring start #######################;

print "$query started  at ".(localtime),"\n";

while (<>) { 

#chomp;
#time since request is for http
#Response Time is for the Diameter

if (($_ =~ "Response Time") || ($_ =~ "Time since request")) {
@eachresponse=split/\s+/;  # kalau semicolon  -->  @a=split/\;/;

if ( $_ =~" since "){
$myresponse =  1000 * $eachresponse[4] ;
}
else
{
$myresponse =  1000 * $eachresponse[3] ;
}
$myresponse = int($myresponse);

push @myrespcollection, $myresponse;


foreach (sort keys %tatconfignya) {
        
               #print "check $myresponse with group minimum  $_  for $myresponse and  $tatconfignya{$_}" ;
              if ( $_ > $myresponse )  {
               $myidentifier = "$_";
               $mysum{$myidentifier} +=1;
               
             																	 }

            							 }
            							 
            							 
            							# print " hasil $myresponse $myidentifier \n" ;
            							 
            							 $mytotal +=1;
            							 $mysigmaresp = $mysigmaresp + $myresponse ;
            				}			 
}

#############################result##################################;

foreach ( sort {$a<=>$b} keys %mysum) {
print " range < " ;
printf ("%6s", "$_ :") ;  #buat string kasih 10 spasi
#print " $mysum{$_} " ;
printf ("%6i", $mysum{$_}) ;      #buat integer  kasih space 6 right adjustment
$percentage = 100* $mysum{$_} / $mytotal ;
print " percentage :" ;
printf ("%6.2f", $percentage) ;  #buat floating alias yang ada komanya kasih space 6 right adjustment
#printf ("%.2f", $percentage) ;
print "\n";
}

use List::Util qw(max maxstr min minstr); 
my $mymaxtat = max @myrespcollection;
my $mymintat = min @myrespcollection;
print " Total tnx: $mytotal \n" ;
$myrata2 = $mysigmaresp / $mytotal ;
print " average " ;
printf ("%6.2f", $myrata2) ;
print " ms \n";

print " TAT max " ;
printf ("%6.2f", $mymaxtat) ;
print " ms \n";

print " TAT min " ;
printf ("%6.2f", $mymintat) ;
print " ms \n";

print "$query executed stopped at ".(localtime),"\n";



__DATA__
0|10|a0
11|20|a0
21|30|a0
31|40|a0
41|50|a0
51|60|a0
61|70|a0
71|80|a0
81|84|a0
85|90|a0
91|100|a0
101|150|a2
151|200|ac
201|250|a
251|500|b
501|1000|c
1001|2000|d
2001|3000|e
3001|1000000|f
81|84|a0
85|90|a0
91|100|a0
101|150|a2
151|200|ac
201|250|a
251|500|b
501|1000|c
1001|2000|d
2001|3000|e
3001|1000000|f