#!/bin/bash

#!/usr/bin/ksh





if [ $RT == 0 ]; then
  echo OK
fi 

if [ -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
fi

## ipa groups 
i=0; while  [ $i -lt 100 ] ;do echo $i;i=`expr $i + 1 `; echo $G|cut -f$i -d, ;sleep 2; done

i=0; while  [ $i -lt 5 ]; do clear;echo $i; nslookup gf0vxsas626p ;i=`expr $i + 1 `; sleep 4 ; done
i=0; while  [ $i -lt 50 ]; do echo $i; ls -l mysql.dump ;i=`expr $i + 1 `;df -h /export/home ; sleep 4 ; done
i=0; while  [ $i -lt 100 ]; do echo `date` >> /tmp/ps.out ; echo $i; ps -ef >> /tmp/ps.out; echo "############" >> /tmp/ps.out ;i=`expr $i + 1 `; sleep 1; done 
f=1;for m in $(cacaoadm list-modules|grep -v ^List|awk '{print $1}'); do echo "$m $(cacaoadm status $m|cut -d: -f2-4|paste -d_ -s -)"; done

FILE=check_ps.sh
for host in $H; do echo $host; scp -q /usr/local/icinga/libexec/${FILE} ${host}:/usr/local/nagios/libexec/${FILE}; done 
for host in $H; do scp -q /usr/local/icinga/libexec/${FILE} ${host}:/usr/local/nagios/libexec/${FILE}; done

### remove host-keys from know_host
cd /export/home/dstock/.ssh
for H in $HS; do grep -vi $H known_hosts > known_hosts-bk; cat known_hosts-bk > known_hosts; done

## nagios 
for i in `cat 20090916-all-unix-systems|cut -f1 -d:`; do A=`/usr/local/nagios/libexec/check_nrpe -H $i`; echo $i:$A >> /tmp/nrpe.out;done
for H in $HS; do A=`/usr/local/nagios/libexec/check_nrpe -H $H`; echo $H:$A >> /tmp/nrpe.out;done

## check nslookup for IP Address 
for i in $HS; do A=`nslookup $i|grep Add |grep -v "10.90.192.19"` ; echo $i:$A; done
for i in $HS;do A=`ssh $i netstat -nr|grep default`; echo $i:$A >> /tmp/default; done

cd /var/opt/SUNWsymon/cfg
for i in `ls -1 ./*dat`; do while read l; do echo "$i:$l" >> /tmp/out.dat;done < $i;  done
chown monitor /tmp/out.dat; cat /tmp/out.dat

## get interfaces 
for i in `ifconfig -a|grep UP|cut -f1 -d:|sort -u`;do echo $i;done 

## check metastat loop 
for i in 1-10 ; do echo $i; metastat -pc;sleep 5; done

grep -v smdadm /etc/group >/dev/null 2>&1 && groupadd -q 300 smdadm
grep -v smdadm /etc/passwd >/dev/null 2>&1 && groupadd -q 300 smdadm
########## WHILE 
## count done 
i=0; while  [ $i -lt 100 ] ;do echo $i;i=`expr $i + 1 ` ; done
i=0; while  [ $i -lt 100 ] ;do echo $i;i=`expr $i + 1 `; ls -l ;sleep 10 ; done
i=0; while  [ $i -lt 100 ] ;do echo $i; 	i=`expr $i + 1 ` ; done
  

## never ending loop
while [ 0 = 0 ];do sleep 10;ls -l /var/core;done
while [ 0 = 0 ];do sleep 30;ls -l /var/core;ls /var/core|wc -l;date;done
i=0; while  [ $i -lt 10 ] ;do /usr/local/nagios/libexec/check_ntp  -H gf01yntp21 -w 0.5 -c 1; sleep 4;i=`expr $i + 1`; done 

## READ FILE 
H=host; OUT=/tmp/tmp.out; FILE=/tmp/file
while read LINE; do echo "$host: $LINE" >> $OUT; done < $FILE

# afriend agt_ec verteilen

/usr/sbin/zoneadm list -iv
for ZP in `zlist|grep run|grep -v glob|awk '{print $4}'` ; do cp /tmp/afriend.* $ZP/root/tmp/ ; done
for ZP in `zlist|grep run|grep -v glob|awk '{print $2}'` ; do zlogin $ZP /tmp/afriend.sh ; done
for ZP in `zlist|grep run|grep -v glob|awk '{print $2}'` ; do zlogin $ZP ls -l /usr/local|grep afriend ; done

/tmp/job-nsca-cron.sh ; exit



# Zone profiles
for ZP in `zlist|grep run|grep -v glob|awk '{print $4}'` ; do cp /export/home/dstock/.profile $ZP/root/export/home/dstock/.profile ; done
for ZP in `zlist|grep run|grep -v glob|awk '{print $4}'` ; do chown -R dstock:adm $ZP/root/export/home/dstock/ ; done
for ZP in `zlist|grep run|grep -v glob|awk '{print $4}'` ; do ls -l $ZP/root/export/home/dstock/.profile ; done
for ZP in `zlist|grep run|grep -v glob|awk '{print $4}'` ; do ls -l $ZP/root/export/home/dstock/.profile ; done

for Z in `zlist|grep run|grep -v glob|awk '{print $2}'`; do zonecfg -z $Z info >> /tmp/zcfg.out; done ;chown monitor /tmp/zcfg.out

for i in $ZS; do zlogin $i cat /etc/shadow >> /tmp/$i.ck;done


## zone config 
for ZONE in `zlist|grep -v NAME|awk '{print $2}'`; do zonecfg -z $ZONE info|egrep "zonename|physical|swap" >> /tmp/zonecfg.rpt ; done
for ZONE in $ZONES; do zonecfg -z $ZONE "select capped-memory;set physical=4G;set swap=4G;end;verify;commit;exit"; done
for ZONE in $ZONES; do zonecfg -z $ZONE info|egrep "zonename|physical|swap" ; done

for ZONE in $ZONES; do prctl -r -n zone.max-swap -v 4g -t privileged -i zoneid $ZONE; done
for ZONE in `zlist|grep run|grep -v global|awk '{print $2}'`; do prctl -n zone.max-swap -i zone $ZONE >> /tmp/prtctl.out; done

# JASS
for ZP in `zlist|grep run|grep -v glob|awk '{print $4}'`;do ls -l $ZP/root/export/home/monitor/jass ; done

# compare 2 files and write lines that aren in both File1 into File3
while read LINE `cat FILE1`;do grep $LINE FILE2 >> FILE3; done 
while read FILE `ls -1`; do cat $FILE >> /tmp/file.log; done

# Do something in all zones
zoneadm list |grep -v global > /tmp/zone-list
while read ZONE; do echo "$ZONE":`date` ;done < /tmp/zone-list
while read ZONE; do zlogin $ZONE CMD ;done < /tmp/zone-list 
while read ZONE; do zlogin $ZONE CMD ;done < /tmp/zone-list 

## get the line above the STRING
for i in `grep -n STRING FILE |cut -f1 -d":"`; do head -$i FILE |tail -2; done

grep bad EventActionHistory.log-0706* |cut -f1 -d: |sort -u

#### AWK 
awk '{print FNR "\t" $0}' file 			## precead each line with a tab. 
awk '{print NR "\t" $0}' file			## precead each line with line number.
awk '{printf("%5d : %s\n", NR,$0)}' file	## precead line with line number and : 
awk 'END{print NR}' file			## count lines 
awk '{s=0; for (i=1; i<=NF; i++) s=s+$i; print s}' file 		## print the sums of the fields of every line
awk '{for (i=1; i<=NF; i++) s=s+$i}; END{print s}' file			## add all fields in all lines and print the sum
awk '{for (i=1; i<=NF; i++) if ($i < 0) $i = -$i; print }' file	 	## print every line after replacing each field with its absolute value
awk '{for (i=1; i<=NF; i++) $i = ($i < 0) ? -$i : $i; print }' file	## print every line after replacing each field with its absolute value
awk '{ total = total + NF }; END {print total}' file 	 		# print the total number of fields ("words") in all lines
awk '/Beth/{n++}; END {print n+0}' file					# print the total number of lines that contain "Beth"
awk '$1 > max {max=$1; maxline=$0}; END{ print max, maxline}' file	## print the largest first field and the line that contains it
awk '{ print NF ":" $0 } ' file						## print the number of fields in each line, followed by the line
awk '{ print $NF }' file 						## print the last field of each line
awk '{ field = $NF }; END{ print field }' file				## print the last field of the last line
awk 'NF > 4' file							## print every line with more than 4 fields
awk '$NF > 4' file 							# print every line where the value of the last field is > 4
awk '{sub(/^[ \t]+/, ""); print}'
awk '{sub(/[ \t]+$/, "");print}'
awk '{gsub(/^[ \t]+|[ \t]+$/,"");print}'
awk '{$1=$1;print}'           # also removes extra space between fields
awk '{sub(/^/, "     ");print}'
awk '{printf "%79s\n", $0}' file		## align all text flush right on a 79-column width
awk '{l=length();s=int((79-l)/2); printf "%"(s+l)"s\n",$0}' file 	## center all text on a 79-character width
awk '{sub(/foo/,"bar");print}'           # replaces only 1st instance
awk '{gsub(/foo/,"bar");print}'          # replaces ALL instances in a line
awk '/baz/{gsub(/foo/, "bar")};{print}'
awk '!/baz/{gsub(/foo/, "bar")};{print}'
awk '{gsub(/scarlet|ruby|puce/, "red"); print}'
awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' file*
awk '/\\$/ {sub(/\\$/,""); getline t; print $0 t; next}; 1' file*
awk -F ":" '{ print $1 | "sort" }' /etc/passwd
awk 'BEGIN { FS=":" } { print $1 | "sort" }' /etc/passwd 		## Print and sort the login names of all users
awk '{print $2, $1}' file
awk '{temp = $1; $1 = $2; $2 = temp}' file
awk '{ $2 = ""; print }'
awk '{for (i=NF; i>0; i--) printf("%s ",i);printf ("\n")}' file
awk 'a !~ $0; {a=$0}'
awk '! a[$0]++'                     # most concise script
awk '!($0 in a) {a[$0];print}'      # most efficient script
awk 'ORS=%NR%5?",":"\n"' file
awk 'NR < 11'
awk 'NR>1{exit};1'
awk '{y=x "\n" $0; x=$0};END{print y}'
awk 'END{print}'
awk '/regex/'
awk '!/regex/'
awk '/regex/{print x};{x=$0}'
awk '/regex/{print (x=="" ? "match on line 1" : x)};{x=$0}'
awk '/regex/{getline;print}'
awk '/AAA/; /BBB/; /CCC/'
awk '/AAA.*BBB.*CCC/'
awk 'length > 64'
awk 'length < 64'
awk '/regex/,0'
awk '/regex/,EOF'
awk 'NR==8,NR==12'
awk 'NR==52'
awk 'NR==52 {print;exit}'          # more efficient on large files
awk '/Iowa/,/Montana/'             # case sensitive
awk '/./'

N=`egrep '(^gf|^GF)' /etc/ipf/ippool.conf | sed -e 's/,//'` 
sed -ne '1,5p' < filename   ## print line 1-5 with sed
sed 'N; s/\n/: /' < filename    ## makes substitution over a newline 

for i in $N ; do nslookup $i | grep SERVFAIL > /dev/null && echo "wird nicht im DNS aufgeloest: $i "; done
