 HOW TO USE: tshark -V -r <file name>|perl Tatmeasurev6.pl
 
 EXAMPLE:  tshark -V -r Diameter.pcap -R diameter.cmd.code==272|perl Tatmeasurev6.pl 
           
           tshark -V -r HTTP_SOAP.cap -Y "xml.cdata && (ip.dst==10.128.56.102||ip.src==10.128.56.102)"|perl Tatmeasurev3.txt


Output example:

  started  at Wed Mar  5 11:40:37 2014
  
range 0-50 : 3523  percentage :7.39

range 101-150 : 4473  percentage :9.38

range 151-200 : 1327  percentage :2.78

range 201-250 : 1044  percentage :2.19

range 251-100000 : 21348  percentage :44.77

range 51-100 : 15974  percentage :33.50

executed stopped at Wed Mar  5 11:43:09 2014

