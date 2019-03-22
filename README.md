 <b> The function is</b> :
to create distribution measurement Turn Around Time Statistic for the response time/Turn Around Time of Diameter, Http or other protocol that have Response time or 'Since' parameter in Tcpdump. So the user able to determine in which quartile (Q95,Q90 etc) their response time has resided.
 
 <b> Dependency :</b>
 - perl environment version 18 onwards (if work on lesser version it's okay but me the dev build with 18 onwards)
 - tshark  (please note some deprecated tshark version still use -R instead of -Y)
 
 <b>HOW TO USE</b>: tshark -V -r <file name> -Y <wireshark premise filter> |perl Tatmeasurev6.pl
 
 <b> EXAMPLE </b>:  
           
           tshark -V -r Diameter.pcap -R diameter.cmd.code==272|perl Tatmeasurev6.pl 
           
           tshark -V -r HTTP_SOAP.cap -Y "xml.cdata && (ip.dst==192.168.1.A||ip.src==192.168.1.AB)"|perl Tatmeasurev6.pl

<b> Output range </b>: in miliseconds unit


Output example:

  started  at Wed Mar  5 11:40:37 2014
  
range 0-50 : 3523  percentage :7.39

range 101-150 : 4473  percentage :9.38

range 151-200 : 1327  percentage :2.78

range 201-250 : 1044  percentage :2.19

range 251-100000 : 21348  percentage :44.77

range 51-100 : 15974  percentage :33.50

executed stopped at Wed Mar  5 11:43:09 2014

