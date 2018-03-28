#!/bin/sh
set -x
######################################################
# 
# Version 0.1
######################################################
######################################################
# Variablen
######################################################
export USAGE="./$0 mount1 mount2 mount3 ... mount9 "

OK=0
WARNING=1
CRITICAL=2
UNKNOWN=3
 
TMP_FILE=/tmp/NFS_CHECK_MMT

> $TMP_FILE

MESSAGE=OK
STATUS=$OK
MNTS=""

###########################################################
# System Variable
###########################################################
if [ $# -eq 0 ]; then
        MESSAGE="$USAGE"
        STATUS=$UNKNOWN
        echo $STATUS: $MESSAGE
        exit $STATUS
else
        while [ $# -gt 0 ]; do
                MNTS="$MNTS $1"
                shift
        done
fi

while true ; do
	case "$1" in
        -v|--verbose) VERBOSE=1 ; outputDebug "Verbose Mode ON" ; shift ;;
        -h|--help) echo "Usage: $0 [-w percent warning] [-c percent critical]"; exit 0;;
        -w|--warn*|--WARN*) TWARN=$1;;
        -c|--crit*|--CRIT*) TCRIT=$1;;
        *) echo "Internal error! - found $1 and $2" ; exit 3 ;;
	esac
done 

###########################################################
# Funktions
###########################################################

###########################################################
# Script
###########################################################
# echo "BOND: DEV: STAT: SPEED: DUPLEX: FAILURES" 
for FILE in `ls $DIR|grep bond`; do 
        for INTERFACE in `grep Interface $DIR/$FILE|awk '{print $3}'`; do 
                STAT=`grep "Interface: $INTERFACE" $DIR/$FILE -A 4 |grep Status:|awk '{print $3}'`
                        if [ $STAT != "up" ]; then 
                                STATUS=$CRITICAL
                                WERT=`expr $WERT + 4`
                        fi 
                SPEED=`grep "Interface: $INTERFACE" $DIR/$FILE -A 4 |grep Speed:|awk '{print $2}'`
                DUPLEX=`grep "Interface: $INTERFACE" $DIR/$FILE -A 4 |grep Duplex:|awk '{print $2}'`
                        if [ $DUPLEX != "full" ]; then 
                                STATUS=$WARNING
                                WERT=`expr $WERT + 1`
                        fi 
                CNT=`grep "Interface: $INTERFACE" $DIR/$FILE -A 4 |grep Count:|awk '{print $4}'`
                        if [ $CNT -ne 0 ]; then 
                                STATUS=$WARNING
                                WERT=`expr $WERT + 1`
                        fi 
                MESSAGE="$MESSAGE $FILE $INTERFACE $STAT $SPEED $DUPLEX $CNT;"
                PERF="$PERF $FILE;$INTERFACE;$STAT;$SPEED;$DUPLEX;$CNT"
        done

done 

###########################################################
# Report results
###########################################################

###########################################################
# END
###########################################################
echo "Interface Bonding - $ALERT: $MESSAGE | $PERF"
exit $STATUS

####### end of sample ###############################################################################################################
#!/bin/sh
set -x
######################################################
# Dan Stock
# Version 0.1
######################################################
######################################################
# Variablen
######################################################

###########################################################
# Funktions
###########################################################

###########################################################
# Script
###########################################################

###########################################################
# Report results
###########################################################

###########################################################
# END
###########################################################

#### end of blank ####################################################################################################

#!/bin/ksh
set -x 

#
################################################
AUTHOR="dstock" 
VERSION="0.1"
USAGE="SCRIPT"  
################################################
SCRIPT="script.sh"
FUNKTION="the funktion"
################################################
            
########################
# Variables
########################

DATE=`date +%Y.%m.%d_%H%M`
LOG="/var/tmp/$SCRIPT-log"
TMP_OUT="ans-$$"

########################
# Funktions 
########################
### Set debuging

F_LOG()
{
   typeset meldg=$*
   echo  `date +%y/%m/%d" "%T` $meldg >> $LOG
}

########################
# Script
########################
### if example #########				  
if [[ "$1" = "x" ]]; then
        set -x
fi

if [ $# -eq 0 ]
then
    echo "USAGE: $0 newhostname"
else
	FILE=$1
fi

####
if [ -f $FILE ]; then
  gunzip $FILE.gz
  tar xvf $FILE
  rm $FILE
else
  log "$FILE existiert nicht!"
fi

# -----------------
# if check Ans OK
# -----------------
if [ $? -ne 0 ]; then 
	STATUS=NOTOK								   
	exit 1
else
	STATUS=OK								   
	exit 1
fi

## check if ans is empty
if [ -n $OS1 ]; then
   OS=$OS1
else
   OS=NN
fi


### case example #######
case $1 in 
	2) TIME=120	;;
	3) TIME=180 ;;																				  
	*) print "Select something else."; exit 1;;	
esac					   


###########################
if [ $# -eq 0 ] ; then
    TEMP="-h"
else 
    TEMP=`getopt -o vhm -l 'help,verbose,missingok,minwarn:,mincrit:,maxwarn:,maxcrit:' -- "$@"`
fi

while test -n "$1"; do
    case "$1" in
        --help|-h)
            print_help
            exit $ST_UK
            ;;
        --version|-v)
            print_version $PROGNAME $VERSION
            exit $ST_UK
            ;;
        --interval|-i)
            interval=$2
            shift
            ;;
        --warning|-w)
            warn=$2
            shift
            ;;
        --critical|-c)
            crit=$2
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            print_help
            exit $ST_UK
            ;;
    esac
    shift
done


while true ; do
    case "$1" in
        -v|--verbose) VERBOSE=1 ; outputDebug "Verbose Mode ON" ; shift ;;
        -h|--help) echo "Usage: $0 [--minwarn size] [--maxwarn size] [--mincrit size] [--maxcrit size] [-m|--missingok]  [-v|--verbose] <list of files or directies>" ; exit 0;;
        -m|--missingok) outputDebug "Allow missing files" ; MISSINGOK=1 ; shift ;;
        --minwarn) outputDebug "Option $1 is $2" ; MINWARN=$2 ; shift 2;;				   
        --maxwarn) outputDebug "Option $1 is $2" ; MAXWARN=$2 ; shift 2;;
        --mincrit) outputDebug "Option $1 is $2" ; MINCRIT=$2 ; shift 2;;
        --maxcrit) outputDebug "Option $1 is $2" ; MAXCRIT=$2 ; shift 2;;
        --) shift ; break ;;
        *) echo "Internal error! - found $1 and $2" ; exit 3 ;;
    esac
done

##########################


### while example ###### 
while read LINE;do 
	grep $LINE FILE3 
		if [ $? -ne 0 ];then 
			echo $LINE >> POS
		else
			echo $LINE >> NEG
		fi
done < FILE2


###
i=0										   
while [ $i -lt 10 ];do 
	sleep 30
	ls -l /var/core
	ls /var/core|wc -l
	date
	i=`expr $i + 1 `
done

## get line 10-20 of a large file 


#### read all the varibles after a script -
##  ./script.sh var1 var2 .....

MNTS=""
while [ $# -gt 0 ]; do 
     	MNTS="$MNTS $1"
      	shift
done 

###	script timeout
#!/usr/bin/ksh
#
echo $$
#
TIMEOUT=5
#
( sleep $TIMEOUT; [ "`ps -ef|cut -c 10-15|grep $$`" -eq $$ ] && kill $$ ) &
#
sleep 10
echo "ENDE"


MYSELF=`ps -ef | grep $0 | grep -v grep | wc -l`
[ 3 -lt $MYSELF ] && exit 2


########################
# End of Script
########################

#################
# default Variable values 
################
$# number of variables
$1 first variable given   
$$ pid 
$0 proc name 
$? return code from cmd

### Pattern matching Operators
For example: ">>start=!finish+finish" would match anything that began with "start" and ended with "finish".
The '?' operator is a synonym for the operation "{0,1}". Read as: "Zero or one occurrence."
The '*' operator is a synonym for the operation "{0,}". Read as: "Zero or more occurrences."
The '+' operator is a synonym for the operation "{1,}". Read as: "One or more occurrences."
The '=' operator is a synonym for the operation "{1}". Read as: "One occurrence."

### if patterns 
## String Comparison Operators Operator  True if... 
str = pat[5] str matches pat. 
str != pat str does not match pat. 
str1 < str2 str1 is less than str2. 
str1 > str2 str1 is greater than str2. 
-n str   str is not null (has length greater than 0).   not empty
-z str   str is null (has length 0). 				    is empty

Test Comparison 
-lt Less than 
-le Less than or equal 
-eq Equal 
-ge Greater than or equal 
-gt Greater than 
-ne Not equal 

Operator  True if... 
-a file - file exists 								
-d DIR - file is a directory 
-f file - file is a regular file (i.e., not a directory or other special type of file)
 
-r file - You have read permission on file 
-s file - file exists and is not empty 
-w file - You have write permission on file 
-x file - You have execute permission on file, or directory search permission if it is a directory
 
-L link - link exists 
-O file You own file 
-G file Your group ID is the same as that of file 
file1 -nt file2 file1 is newer than file2[8] 
file1 -ot file2 file1 is older than file2 

S1 && S2	execute statement1(S1) and if status 0, execute statement2(S2)
S1 || S2	execute statement1(S1) and if status is not 0, execute statement2(S2)




## 
grep -v smdadm /etc/group >/dev/null 2>&1 && groupadd -q 300 smdadm



H_=""
H_="<TH></TH>"


##### job_  ############################################################################################################################
#!/bin/ksh
#
################################################
# Filename:     job_cookbook.sh
# Authors:      Dan Stock
#
# History:      --.--.-- Dan Stock 
################################################

########################
# Variables 
########################
MYSCRIPT="job_CallScript_install.sh"
FILE=/var/opt/SUNWsymon/bin/CallScript.tar
FILE1=/var/opt/SUNWsymon/bin/CallScript_Check_Scripts.tar

SUNMCDIR="/var/opt/SUNWsymon/bin"
VAR="/var/opt/SUNWsymon"
PROTOKOLL="/var/opt/SUNWsymon/log/ManagedJob-$MYSCRIPT.log"


########################
# Funktions 
########################


ende()
{
   typeset code=$1

   # Fehlercode protokollieren
   if [ $code != "0" ]; then
      log "FehlercodeENDE: $code"
   fi

   # Dateien loeschen
   host=`hostname`
   if [ $host != "$SMCHOST" && "$host" != "$SMCBACK" ]; then
      /usr/bin/rm $SUNMCDIR/$MYSCRIPT
   fi

   # Module loeschen
   host=`hostname`
   if [ $host != "$SMCHOST" && "$host" != "$SMCBACK" ]; then
      /usr/bin/grep -v "filemon+" $VAR/cfg/base-modules-d.dat > $VAR/cfg/base-modules-d.dat.tmp
      /usr/bin/mv $VAR/cfg/base-modules-d.dat.tmp $VAR/cfg/base-modules-d.dat
   fi

   log "ENDE: $MYSCRIPT:`date` ############"

   # Protokoll-Datei als Mail versenden
   #####/usr/bin/mailx -s "SunMC-Softwareverteilung $MYSCRIPT $FILE `uname -n`" d.stock@ing-diba.de < $PROTOKOLL
   exit 
}

restart()
{									
	/opt/SUNWsymon/sbin/es-stop -a
	cat /var/opt/SUNWsymon/cfg/base-modules-d.dat > /var/opt/SUNWsymon/cfg/base-modules-d.dat-tmp
	sort -u /var/opt/SUNWsymon/cfg/base-modules-d.dat-tmp 
	mv /var/opt/SUNWsymon/cfg/base-modules-d.dat-tmp /var/opt/SUNWsymon/cfg/base-modules-d.dat
	/opt/SUNWsymon/sbin/es-start -a
}

########################							
# EOF
########################
cat > /etc/init.d/uc4 <<'EOF'
#!/sbin/sh
#
 
case "$1" in
	start)
        su - uc4 -c "/export/home/uc4/smgr/bin/smgrctl start export"
        ;;
	stop)
        su - uc4 -c "/export/home/uc4/smgr/bin/smgrctl stop export"
         ;;
	*)
        echo "Usage: $0 { start | stop }"
        exit 1
        ;;
 esac
 exit 0
 EOF

########################
# Script
########################
log "START:  $MYSCRIPT: ##########"

host=`hostname`
if [ $host = "$SMCHOST" ]; then
   log "auf $host wird der Job $MYSCRIPT nicht ausgefuehrt!! "
   ende "0"
fi

### 1. Aktion: CallScript auspacken ###
log "tar-File $FILE  auspacken"
if [ -f $FILE ]; then
  gunzip $FILE.gz
  tar xvf $FILE
  rm $FILE
else
  log "$FILE existiert nicht!"
fi

ende "0"

########################
# End of Script
########################

# tcl tk operands
dstock: *(TEST)||^(NO_ALARM)
dstock: *(TEST)|^(NO_ALARM)     - doesn't hit with either NO_ALARM 
dstock: *(TEST)&^(NO_ALARM)		- doesn't hit with either 

###############
# Variables 
###############
# commands
##########
CAT=/bin/cat
CUT=/bin/cut
PWD=/bin/pwd
AWK=/bin/awk
GREP=/bin/grep
SED=/bin/sed
PSE="/bin/ps -e"
CMD_ZONENAME=/bin/zonename
[ -x $CMD_ZONENAME ] && PSE="/usr/bin/ps -z `$CMD_ZONENAME`"
ECHO=/bin/echo
FGREP=/bin/fgrep
EGREP=/bin/egrep
MV=/bin/mv
CP=/bin/cp
CHMOD=/bin/chmod
PROGNAME=$0
LS="/usr/bin/ls" 
CAT="/usr/bin/cat"
GREP="/usr/bin/grep"
EGREP="/usr/bin/egrep"
ZLOGIN=" /usr/sbin/zlogin"
CP="/usr/bin/cp"
MAILX=" /usr/bin/mailx"
SED="/usr/bin/sed"
AWK="/usr/bin/awk"

DATE=`date +%Y%m%d%H%M`					### 200610040925
DATE=`date +%Y%m%d`					### 20061004
DATE=`date +%d.%m.%y_%H%M`			### 04.10.06_0925
DATE=`date +%d%m%y_%H%M`			### 041006_0925
DATE=`date +%Y.%m.%d_%H:%M`					### 2006.10.04_09:25

LOG=/var/log
DATE=`date +%d%m%y

## sections of the shadow
    for LINE in `grep $U /etc/shadow`; do 
	USER=`echo $LINE|cut -f1 -d":"
	PWD=`echo $LINE|cut -f2 -d":"
	LASTCHANG=`echo $LINE|cut -f3 -d":"
	MIN=`echo $LINE|cut -f4 -d":"
	MAX=`echo $LINE|cut -f5 -d":"
	INACTIVE=`echo $LINE|cut -f6 -d":"
	EXPIRE=`echo $LINE|cut -f7 -d":"
	FLAG=`echo $LINE|cut -f8 -d":"


#################################
# The exit codes returned are:
#       0 - operation completed successfully
#       1 -
#       2 - usage error
#       3 - httpd could not be started
#       4 - httpd could not be stopped
#       5 - httpd could not be started during a restart
#       6 - httpd could not be restarted during a restart
#       7 - httpd could not be restarted during a graceful restart
#       8 - configuration syntax error

#################################
case $(/usr/bin/uname -r) in
        5.5.1*) OSVERS=5 ;;
        5.6*)   OSVERS=6 ;;
        5.7*)   OSVERS=7 ;;
        5.8*)   OSVERS=8 ;;
        5.9*)   OSVERS=9 ;;
        5.10*)  OSVERS=10 ;;
        *)      print -u2 "`date` ERROR: Unsupported OS version"
                exit 1 ;;
esac


case $1 in 
	2) TIME=120	;;
	3) TIME=180 ;;
	5) TIME=300 ;;
	8) TIME=480 ;;																					  
	*) print -u2 "Unsupported time in min."
		exit 1;;
esac


case "$SECURE_SHELL_COMMUNICATION" in 
	yes|Yes|YES|Y|y|ja|Ja|JA|j|J)
	do this
      ;;
   *)
	exit 
      ;;
esac



########################
# Funktions
########################

F_START ()
{
	echo "Start -- Press Return"
	read a
	set -x
}


F_STOP ()
{
	echo "Stop -- Press Return"
	read a
	set +x
}

DoChg_Funk ()
{
        echo " +++ files with "rwx" for "other" will be listed. Please change rigths manually later!" 
        if [ $NISPLUS -eq 1 ];then
                echo " +++ ATTENTION: This change could not be done within NIS+"
                echo " +++ NOT DONE !!!"
        else
                find / -local -type f -perm -o=rwx -ls  | tee -a $OF
                echo " --- done" 
        fi
}

F_MAIL ()
{
	LOG=/tmp/DB.log
	cat $LOG | mailx -s "`uname -n`:" d.stock@ing-diba.de 
}

DoCk_Funk_is_file_present ()
{
	if [ -d $FILE ];then
	do
		echo " --- OK: $FILE is present" | tee -a $OF
	else
		echo " +++ NOT OK: $FILE is not present" | tee -a $OF
	fi
}

checkRoot ()
{
if [ "`id | cut -d '(' -f 1`" != "uid=0" -a "$TEST" != "YES" ]
then
${ECHO} "\nThis script must be executed by root."
${ECHO} "Aborting...\n"
exit 1
fi
}

F_Ck_YN ()
{
	if [ "$1" = "y" -o "$1" = "n" ]
		then
		$ECHO "... $1"
	else
		$ECHO "Invalid input - try again.\n"
	fi
}



###### Count up from 5
START=5
for COUNT in "1 2 3 5 "; do  
NR="`expr $START + 1`"

done 

########################
# Script
########################

### =======================
# if examples
### =======================

## two ways of checking and then running a script - one with if the other a short cut
[ -f /usr/sbin/vxdisk ] && vxdisk list | grep rootdg | grep online ; [ $? -eq "0" ] && mailx -s test d.stock@ing-diba.de < /dev/null
if [ -f /usr/sbin/vxdisk ] ; then vxdisk list | grep rootdg | grep online ; if [ $? -eq "0" ] ; then mailx -s test d.stock@ing-diba.de < /dev/null ; fi ; fi 


# check if the script has a second variable
if [ $# -eq 0 ]; then 
for HOST in `cat ${LIST}`
do 

done 
else 
        HOST=$1
fi



# -----------------
# check on dir then make it
# -----------------
DIR="/tmp/whatever"
if [[ ! -d $DIR ]]; then
	/usr/bin/mkdir $DIR
fi


if [ $# -eq 0 ]; then 
	echo "Usage: report_host_summary.sh <HOSTNAME> "
else
	HOST=$1
fi 

# -----------------
# if check Ans OK
# -----------------
if [ $? -ne 0 ]
${ECHO} "Error determining local IP or local Agent port." 
${ECHO} "Aborting execution."											   
exit 1
fi

# -----------------
# Check if the ssh for Monitor worked
# -----------------
CMD="/usr/bin/uname -n"
F_CMD ()													   
{
ssh -f monitor@$i $CMD & > /dev/null 2>&1
if
        [ $? -eq 0 ]; then
        export F=555
        STATNET="Link ok"
else
        export F=544
        STATNET="No Link"
fi
}


### Set debuging
if [[ "$1" = "x" ]]; then
        set -x
fi


# -----------------
# check on files
# -----------------
# make if not there
FILE="whatever"
if [[ ! -f $FILE ]]; then
	touch  $FILE
fi

# warn if FILE is empty. 
FILE="whatever"
if [[ ! -s $FILE ]]; then
	mailx -s "NOT OK !!! -  $FILE is empty" d.stock@ing-diba.de
else
	mailx -s "OK - $FILE is full" d.stock@ing-diba.de
fi

# warn if Return String is empty. 
if [ $? -ne 0 ];then 
	echo $LINE >> NEG
else
	echo $LINE >> POS
fi
										   

# -----------------
# Y/N response
# -----------------
echo "Should this value be changed [y/n] \c" | tee -a $OF
read ANS
if [ "$ANS" = "y" ];then
    DoChanges1 | tee -a $OF
else
    echo " ??? Answer not equal to y, no action" | tee -a $OF
fi

#!/bin/ksh
while read LINE
do
grep $LINE FILE2
        if [ $? -ne 0 ];then 
                echo "Do you want to reinstall $LINE? [y/n];"
                read ANS
                if [ "$ANS" = "y" ];then
                        echo "reinstall: $LINE" >> LOG
                else
                        echo "no reinstall: $LINE" >> LOG
                fi
        else
                echo $LINE >> NEG
        fi
done < FILE1


# -----------------
# check on OS
# -----------------
OS=`/bin/uname -s`
COMMAND_ROOT=""
if [ "${OS}" = "SunOS" ]; then
   COMMAND_ROOT="/usr"
elif [ "${OS}" = "Linux" ]; then
   COMMAND_ROOT=""
fi

# -----------------
OSVER=`uname -r | cut -f1 -d "."`                                       
OSVERS=`uname -r | cut -f2 -d "."`   
if [ $OSVER -gt 5 -o \( $OSVER -eq 5 -a $OSVERS -ge 10 \) ]             
  then ZONESW="-G"                                                      
  else ZONESW=""                                                        
fi                                                                      
if [ $OSVER -gt 5 -o \( $OSVER -eq 5 -a $OSVERS -ge 8 \) ]              
  then PKGFILE=cmxv6.ds                                                 
  else PKGFILE=cmxv4.ds                                                 
fi 

# -----------------
### check if script is executed with parameters
if [ $# -eq 0 ]
then
    echo "USAGE: $0 newhostname"
fi

### check if the result is less than 10. 
if (( ${DD} < 10 ));then
        DD=0${DD}
fi


### check if ssh connection worked
audit_on () #Fehlerbehandlung Sendeseite
{
ssh -f monitor@$i "/usr/bin/uname -n" & > /dev/null 2>&1
if
        [ $? -eq 0 ]; then
        STATUS="Link ok"
else
        STATUS="No Link"
fi
}
	
	
### =======================	#################################
# AWK and SED
### =======================	#################################
# -----------------
## NAWK
F_TIME_APP ()
{
nawk -v pt=$POST_TIME -v nr=$NR '/TAG_TIME_APP/ {printf("if ((%d - server_gmt_offset) > compare_time) {\ndocument.img%d.src \nTAG_TIME_APP\n",pt,nr);next} {print}' copy.3.html > copy.3.html.tmp
mv $DIR/copy.3.html.tmp $DIR/copy.3.html
}

nawk '/Event occurred/ {host=$NF} /Status Message/ {gsub(/.*:/,""); MSG=$0} /Module Specification/ {gsub(/.*:/,""); printf ("%11s%-37s:%s\n", host,$0,MSG)}' $LOGS >> $LOG-tmp 

## Convert Seconds to Time
# in Delphi
function SecToTime(Sec: Integer): string;
var
   H, M, S: string;
   ZH, ZM, ZS: Integer;
begin
   ZH := Sec div 3600;
   ZM := Sec div 60 - ZH * 60;
   ZS := Sec - (ZH * 3600 + ZM * 60) ;
   H := IntToStr(ZH) ;
   M := IntToStr(ZM) ;
   S := IntToStr(ZS) ;
   Result := H + ':' + M + ':' + S;
end;

#ksh
TIME=`perl -e '$t=time; print "$t\n";'`
CI_TIME=`grep $DAY $LOG|head -1 |cut -f2 -d"-"`
CO_TIME=`echo "$DATE - $TIME"|cut -f2 -d"-"`

DIFF="`expr $CO_TIME - $CI_TIME`"
HRS="`expr $DIFF / 3600`"
REM="`expr $DIFF % 3600`"
MIN="`expr $REM / 60`" 

echo "Diff: $HRS hrs : $MIN min"


# Convert Small letters to capitals
AGENT=`echo "$AGENT" | tr "[a-z]" "[A-Z]" `

# get the first feild with nawk. 
cat -n $LOGS |grep "Alarm"| nawk '$1=='${ALARM}' {print}' |head -1


## get the percentage of an interger

				while read LINE; do
					CK=`echo $LINE|grep -i ^[A-Z]` 
					if [ $? = 0 ]; then
						FRU=$LINE
						# echo $FRU
					else 
						PS=`echo $LINE|awk '{print $1}' |sed 's/V//'|cut -f1 -d"#"` 
						USE=`echo $LINE|cut -f2 -d:	|sed 's/V//'` 
					fi
					TWERT=`echo "scale=2; 100 * ${PS} / ${USE}"|bc` 
					WERT=`expr 100 - $TWERT`
					if [ $WERT < 0 ]; then; WERT=`expr $WERT * -1`; fi  
					F_ALERT
					/bin/echo "$STATUS;$MESSAGE"  
					# echo "$FRU: $PS: $USE: $WERT"
				done < $LOG


# -----------------
sed 's/original string/string wanted/' file > file.tmp; mv file.tmp file

sed 's/[a-z][a-z][a-z][a-z][a-z][a-z][a-z][a-z]/[A-Z]+/g' /etc/hosts > /tmp/hosts-tmp; more /tmp/hosts-tmp

sed 's/a/A/g' /tmp/hosts-tmp > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/b/B/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/c/C/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/d/D/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/e/E/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/f/F/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/g/G/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/h/H/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/i/I/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/j/J/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/k/K/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/l/L/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/m/M/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/n/N/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/o/O/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/p/P/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/q/Q/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/r/R/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/s/S/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/t/T/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/u/U/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/v/V/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/w/W/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/x/X/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/y/Y/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-sm
sed 's/z/Z/g' /tmp/hosts-sm > /tmp/hosts-lg; mv /tmp/hosts-lg /tmp/hosts-tmp
more /tmp/hosts-tmp


# ----------------
# translate to upper case. 
tr -s '[:lower:]' '[:upper:]' < /etc/hosts > /etc/hosts-tmp; mv /etc/hosts-tmp /etc/hosts 

let DD=`date +%d`-1


### =======================	 #################################
# While examples  
### =======================	 #################################
LIST_FILE_HOST=inventory.list
# while read line
while read HOST `cat ${LIST_FILE_HOST}`
do 
    echo $HOST
done

# while 
while read line `grep -n ${HOST} modules |cut -d: -f1`
do 
    MOD=`cat -n ${LOG_FILE_MODUL} |grep $line -1 |cut -f2`
    echo ${HOST}:${MOD}
done

### Compare two files
while read LINE
do 
	grep $LINE FILE3 
		if [ $? -ne 0 ];then 
			echo $LINE >> POS
		else
			echo $LINE >> NEG
		fi
done < FILE2


## One liners
while read LINE; do echo "`uname -n`: $LINE"; done < /tmp/passwd

zoneadm list > /tmp/list
while read ZONE; do echo "$ZONE":`date` ;done < /tmp/list

ssh ${host} cat /etc/passwd > /tmp/ans; while read LINE; do echo "$host: $LINE"; done < /tmp/ans


### =======================
# Example distribute in Zone
### =======================
LS="/usr/bin/ls" 
CAT="/usr/bin/cat"
GREP="/usr/bin/grep"
EGREP="/usr/bin/egrep"
ZLOGIN=" /usr/sbin/zlogin"
CP="/usr/bin/cp"
MAILX=" /usr/bin/mailx"
SED="/usr/bin/sed"
AWK="/usr/bin/awk"

## Multipul patterns with grep
grep -e pattern_one -e pattern_two file



### =======================
#  for examples 
### =======================
for file in `ls -1 /var/tmp/dir/`
do 
	grep $LINE FILE2 
        if [ $? -ne 0 ];then 
                echo $LINE >> POS
        else
                echo $LINE >> NEG
                echo "Do you want to keep this? [y/n]"
				read ANS
				if [ "$ANS" = "y" ];then
    				cp $file /var/opt/SUNWsymon/sbin
					echo " Keep $file in Monitoring." | tee -a $LOG						   [
    			else
    				echo " $file is in Archiv." | tee -a $LOG
fi	
        fi
done < FILE1 



### =======================
# Debuging 
### =======================
# Debug ON means the logfile is appended to.
# Debug OFF means the logfile is over-written with each action.
# The logfile is ($ESDIR|$PADIR)/log/HALEventAction-mail.sh.out
#
 
DEBUG="OFF"
DEBUG="ON"


# Detailed Debug ON:  message body will be written to the logfile.
# Detailed Debug OFF: message body will NOT be written to the logfile.
# The logfile is ($ESDIR|$PADIR)/log/HALEventAction-mail.sh.out
#

DETAILED_DEBUG="OFF"
#DETAILED_DEBUG="ON"

DEBUG=`echo $DEBUG | tr -s '[:lower:]' '[:upper:]'`
if [ "$DEBUG" = "ON" ] || [ "$DEBUG" = "YES" ]
then
    echo " " >> $ERRFILE
else
    $CP /dev/null $ERRFILE
fi


### =======================
# Cool one liners
### =======================
# check directory every 10 seconds for any new entries. 
while [ 0 = 0 ];do sleep 10;ls -l /var/core;done
while [ 0 = 0 ];do sleep 30;ls -l /var/core;ls /var/core|wc -l;date;done

# compare 2 files and write lines that aren in both File1 into File3
while read LINE `cat FILE1`;do grep $LINE FILE2 >> FILE3; done 

while read FILE `ls -1`; do cat $FILE >> /tmp/file.log; done




																		


########################
# End of Script
########################





#################################################################################################
#### Script Template
#################################################################################################

#!/bin/ksh
#################################################
#
# Autor  
# erstellt am 
# Version 1.0
#
# Funktion:
#
#################################################

#### Variablen setzen
MYSCRIPT=""
FILE=""

# Kommandos: "basename" und "dirname" werden in SunMC nicht ausgefuehrt
SUNMCDIR="/var/opt/SUNWsymon/bin"
PROTOKOLL="/var/opt/SUNWsymon/log/ManagedJob.log"

##### Funktion: log
log()
{
   typeset meldg=$*
   echo  `date +%y/%m/%d" "%T` $meldg >> $PROTOKOLL
}
##### Funktion: ende
ende()
{
   typeset code=$1

   # Fehlercode protokollieren
   if [ $code != "0" ]; then
      log "FehlercodeENDE: $code"
   fi																							  



   log "ENDE: $MYSCRIPT:`date` ############"

   # Protokoll-Datei als Mail versenden
   #####/usr/bin/mailx -s "SunMC-Softwareverteilung $MYSCRIPT $FILE `uname -n`" a.kuhn@ing-diba.de < $PROTOKOLL
   exit 
}

##### Protokoll-Header
log "START:  $MYSCRIPT: ##########"



###  Aktion: My script. ### 


ende "0"



for i in `ls $EDIR/`; do

  ## extract IP and fqdn from file name
  IP=`echo $i|cut -f1 -d"_"`;
  NAME=`echo $i|cut -f2 -d"_"`;
  NO_PING=`echo $i|cut -f3 -d"_"`;


# wenn NO_PING = 0 dann nicht pingen
   if [ "$NO_PING" != "NOPING" ]; then
      PING=$(/usr/sbin/ping   -s $IP 3 2  |grep transmitted|cut -f3 -d","|cut -f 1 -d"%")
   else
      PING=0
   fi

  if [ $PING -eq "0" ]; then
    ## Host is up
    echo "Server $IP ($NAME): ping OK ##########################";
    echo "Server $IP ($NAME): ping OK ##########################" >> $LOG;

    ## now checking the ports
    for j in `cat $EDIR/$i`; do
      RET=`/usr/local/bin/nmap -r --host_timeout 15000 --initial_rtt_timeout 15000 -P0 -p $j $IP|grep $j/tcp`;
        echo "$NAME:$RET"
        echo "$NAME:$RET" >> $LOG
    done
  else
	echo "Server not responding to ping: $PING";
	echo "Server not responding to ping: $PING" >> $LOG;
  fi
done



Special shell variables 
There are some variables which are set inally by the shell and which are 
available to the user: 


    $1 - $9       these variables are the positional parameters.
    $0            the name of the command currently being executed.
    $argv[20]     refers to the 20th command line argument
    $#            the number of positional arguments given to this
                  invocation of the shell.
    $?            the exit status of the last command executed is
                  given as a decimal string.  When a command
                  completes successfully, it returns the exit status
                  of 0 (zero), otherwise it returns a non-zero exit
                  status.
    $$            the process number of this shell - useful for
                  including in filenames, to make them unique.
    $!            the process id of the last command run in
                  the background.
    $-            the current options supplied to this invocation
                  of the shell.
    $*            a string containing all the arguments to the
                  shell, starting at $1.
    $@            same as above, except when quoted : 
                  "$*" expanded into ONE long element : "$1 $2 $3"
                  "$@" expanded into THREE elements : "$1" "$2" "$3"
    shift   : $2 -> $1 ...)


special characters 


The special chars of the Korn shell are :
    $  \  #  ?  [  ]  *  +  &  |  (  )  ;  `  "  '
- A pair of simple quotes '...' turns off the significance of ALL enclosed 
  chars
- A pair of double quotes "..." : idem except for $ ` " \
- A '\' shuts off the special meaning of the char immediately to its right.
  Thus, \$ is equivalent to '$'.
- In a script shell :
    #       : all text that follow it up the newline is a comment
    \       : if it is the last char on a line, signals a continuation line
              qui suit est la continuation de celle-ci


Evaluating shell variables 
The following set of rules govern the evaluation of all shell variables. 


    $var                  signifies the value of var or nothing,
                          if var is undefined.
    ${var}                same as above except the braces enclose
                          the name of the variable to be substituted.
    +-------------------+---------------------------+-------------------+
    | Operation         | if str is unset or null   | else              |
    +-------------------+---------------------------+-------------------+
    | var=${str:-expr}  | var= expr                 | var= ${string}    |
    | var=${str:=expr}  | str= expr ; var= expr     | var= ${string}    |
    | var=${str:+expr}  | var becomes null          | var= expr         |
    | var=${str:?expr}  | expr is printed on stderr | var= ${string}    |
    +-------------------+---------------------------+-------------------+


The if statement 
The if statement uses the exit status of the given command 


        if test
        then
            commands     (if condition is true)
        else
            commands     (if condition is false)
        fi


if statements may be nested: 


        if ...
        then ...
        else if ...
        ...
        fi
        fi


Test on numbers : 


    ((number1 == number2))
    ((number1 != number2))
    ((number1   number2))
    ((number1 >  number2))
    ((number1 = number2))
    ((number1 >= number2))
        Warning : 5 different possible syntaxes (not absolutely identical) :
            if ((x == y))
            if test $x -eq $y
            if let "$x == $y"
            if [ $x -eq $y ]
            if [[ $x -eq $y ]]


Test on strings: (pattern may contain special chars) 


    [[string  =  pattern]]
    [[string  != pattern]]
    [[string1   string2]]
    [[string1 >  string2]]
    [[ -z string]]                  true if length is zero
    [[ -n string]]                  true if length is not zero
        Warning : 3 different possible syntaxes :
            if [[ $str1 = $str2 ]]
            if [ "$str1" = "$str2" ]
            if test "$str1" = "$str2"


Test on objects : files, directories, links ... 


    examples :
            [[ -f $myfile ]]            # is $myfile a regular file?
            [[ -x /usr/users/judyt ]]   # is this file executable?
    +---------------+---------------------------------------------------+
    | Test          | Returns true if object...                         |
    +---------------+---------------------------------------------------+
    | -a object     | exist; any type of object                         |
    | -f object     | is a regular file or a symbolic link              |
    | -d object     | is a directory                                    |
    | -c object     | is a character special file                       |
    | -b object     | is a block special file                           |
    | -p object     | is a named pipe                                   |
    | -S object     | is a socket                                       |
    | -L object     | is a symbolic (soft) link with another object     |
    | -k object     | object's "sticky bit" is set                      |
    | -s object     | object isn't empty                                |
    | -r object     | I may read this object                            |
    | -w object     | I may write to (modify) this object               |
    | -x object     | object is an executable file                      |
    |               |        or a directory I can search                |
    | -O object     | I ownn this object                                |
    | -G object     | the group to which I belong owns object           |
    | -u object     | object's set-user-id bit is set                   |
    | -g object     | object's set-group-id bit is set                  |
    | obj1 -nt obj2 | obj1 is newer than obj2                           |
    | obj1 -ot obj2 | obj1 is older than obj2                           |
    | obj1 -ef obj2 | obj1 is another name for obj2 (equivalent)        |
    +---------------+---------------------------------------------------+


The logical operators 
You can use the && operator to execute a command and, if it is successful, 
execute the next command in the list. For example: 


        cmd1 && cmd2


cmd1 is executed and its exit status examined. Only if cmd1 succeeds is 
cmd2 executed. You can use the || operator to execute a command and, if it 
fails, execute the next command in the command list. 


        cmd1 || cmd2


Of course, ll combinaisons of these 2 operators are possible. Example : 


        cmd1 || cmd2 && cmd3


Math operators 
First, don't forget that you have to enclose the entire mathematical 
operation within a DOUBLE pair of parentheses. A single pair has a 
completely different meaning to the Korn-Shell. 

 
        +-----------+-----------+-------------------------+
        | operator  | operation | example                 |
        +-----------+-----------+-------------------------+
        | +         | add.      | ((y = 7 + 10))          |
        | -         | sub.      | ((y = 7 - 10))          |
        | *         | mult.     | ((y = 7 * 4))           |
        | /         | div.      | ((y = 37 / 5))          |
        | %         | modulo    | ((y = 37 + 5))          |
        |           | shift     | ((y = 2#1011  2))       |
        | >>        | shift     | ((y = 2#1011 >> 2))     |
        | &         | AND       | ((y = 2#1011 & 2#1100)) |
        | ^         | excl OR   | ((y = 2#1011 ^ 2#1100)) |
        | |         | OR        | ((y = 2#1011 | 2#1100)) |
        +-----------+-----------+-------------------------+
        


Controlling execution 


    goto my_label
    ......
    my_label:
  -----
    case value in
        pattern1) command1 ; ... ; commandN;;
        pattern2) command1 ; ... ; commandN;;
            ........
        patternN) command1 ; ... ; commandN;;
    esac
        where : value    value of a variable
                pattern  any constant, pattern or group of pattern
                command  name of any program, shell script or ksh statement
        example 1 :
            case $advice in
                [Yy][Ee][Ss])   print "A yes answer";;
                [Mm]*)          print "M followed by anything";;
                +([0-9))        print "Any integer...";;
                "oui" | "bof")  print "one or the other";;
                *)              print "Default";;
        example 2 :     Creating nice menus
            PS3="Enter your choice :"
            select menu_list in English francais
            do
                case $menu_list in
                    English)  print "Thank you";;
                    francais) print "Merci";;
                    *)        print "???"; break;;
                esac
            done
  -----
    while( logical expression)
    do
        ....
    done
    while :                 # infinite loop
        ....
    done
    while read line         # read until an EOF (or <crtl_d> )
    do
        ....
    done  fname             # redirect input within this while loop
    until( logical expression)
    do
        ....
    done <fin >fout         # redirect both input and output
  -----
    for name in 1 2 3 4     # a list of elements
    do
        ....
    done
    for obj in *            # list of every object in the current directory
    do
        ....
    done
    for obj in * */*        # $PWD and the next level below it contain
    do
        ....
    done
  -----
    break;                  # to leave a loop (while, until, for)
    continue;               # to skip part of one loop iteration
                            # nested loops are allowed in ksh
  ----
    select ident in two # a list of identifiers
    do
        case $ident in
            one) ....... ;;
            two) ..... ;;
            *) print "none" ;;
        esac
    done


Debug mode 


    > ksh -x script_name
  or, in a 'shell script' :
    set -x          # start debug mode
    set +x          # stop  debug mode


Examples 
Example 1 : loops, cases ... 


    #!/bin/ksh
    USAGE="usage :  fmr [dir_name]"	# how to invoke this script
    print "
        +------------------------+
        | Start fmr shell script |
        +------------------------+
    "
    function fonc 
    {
    echo "Loop over params, with shift function"
    for i do
        print "parameter $1"    # print is equivalent to echo
        shift
    done                        # Beware that $# in now = 0 !!!
    }
    echo "Loop over all ($#) parameters : $*"
    for i do
        echo "parameter $i"
    done
                                #----------------------
    if (( $# > 0 ))             # Is the first arg. a directory name ?
    then
        dir_name=$1
    else
        print -n "Directory name:"
        read dir_name
    fi
    print "You specified the following directory; $dir_name"
    if [[ ! -d $dir_name ]]
    then
        print "Sorry, but $dir_name isn't the name of a directory"
    else
        echo "-------- List of directory $dir_name -----------------"
        ls -l $dir_name
        echo "------------------------------------------------------"
    fi
                                  #----------------------
    echo "switch on #params"
    case $# in
        0) echo "command with no parameter";;
        1) echo "there is only one parameter : $1";;
        2) echo "there are two parameters";;
        [3,4]) echo "3 or 4 params";;
        *) echo "more than 4 params";;
    esac
                                  #----------------------
    fonc 
    echo "Parameters number (after function fonc) : $#"
                                  #------- To read and execute a command 
    echo "==> Enter a name"
    while read com 
    do 
        case $com in
            tristram) echo "gerard";;
            guglielmi) echo "laurent";;
            dolbeau) echo "Jean";;
            poutot) echo "Daniel ou Claude ?";;
            lutz | frenkiel) echo "Pierre";;
            brunet) echo "You lost !!!"; exit ;;
            *) echo "Unknown guy !!! ( $com )"; break ;;
        esac
        echo "==> another name, please"
    done
                                  #------ The test function :
    echo "Enter a file name"
    read name
    if [ -r $name ] 
    then echo "This file is readable" 
    fi
    if [ -w $name ] 
        then echo "This file is writable"
    fi
    if [ -x $name ] 
        then echo "This file is executable" 
    fi
                                  #------ 
    echo "--------------- Menu select ----------"
    PS3="Enter your choice: "
    select menu_list in English francais quit
    do
        case $menu_list in
            English)   print "Thank you";;
            francais)  print "Merci.";;
            quit)       break;;
            *)       print " ????";;
        esac
    done
    print "So long!"


Example 2 : switches 


    #!/bin/ksh
    USAGE="usage: gopt.ksh [+-d] [ +-q]"    # + and - switches
    while getopts :dq arguments             # note the leading colon
    do
      case $arguments in
        d) compile=on;;                     # don't precede d with a minus sign
       +d) compile=off;;
        q) verbose=on;;
       +q) verbose=off;;
       \?) print "$OPTARG is not a valid option"
           print "$USAGE";;
      esac
    done
    print "compile=$compile - verbose= $verbose"


Example 3 


    ###############################################################
    # This is a function named 'sqrt'
    function sqrt            # square the input argument
    {
        ((s = $1 * $1 ))
    }
    # In fact, all KornShell variables are, by default, global
    # (execpt when defined with typeset, integer or readonly)
    # So, you don't have to use 'return $s'
    ###############################################################
    # The shell script begins execution at the next line
    print -n "Enter an integer : "
    read an_integer
    sqrt $an_integer
    print "The square of $an_integer is $s"


Example 4 


    #!/bin/ksh
    ############ Using exec to do I/O on multiple files ############
    USAGE="usage : ex4.ksh file1 file2"
    if (($# != 2))                    # this script needs 2 arguments
    then
        print "$USAGE"
        exit 1
    fi
 
    ############ Both arguments must be readable regular files
    if [[ (-f $1) && (-f $2) && (-r $1) && (-r $2) ]]
    then                              # use exec to open 4 files
        exec 3 <$1                    # open $1 for input
        exec 4 <$2                    # open $2 for input
        exec 5> match                 # open file "match" for output
        exec 6> nomatch               # open file "nomatch" for output
    else                              # if user enters bad arguments
        print "$        USAGE"
        exit 2
    fi
    while read -u3 lineA              # read a line on descriptor 3
    do
        read -u4 lineB                # read a line on descriptor 4
        if [ "$lineA" = "$lineB" ]
        then                          # send matching line to one file
            print -u5 "$lineA"
        else                          # send nonmatching lines to another
            print -u6 "$lineA; $lineB"
        fi
    done
    
    print "Done, today : $(date)"     # $(date) : output of 'date' command
    date_var=$(date)                  # or put it in a variable
    print " I said $date_var"         # and print it...


Example 5 


    ############ String manipulation examples ##################
    read str1?"Enter a string: "
    print "\nYou said : $str1"
    typeset -u  str1                  # Convert to uppercase
    print "UPPERCASE: $str1"
    typeset -l str1                   # Convert to lowercase
    print "lowercase: $str1"
    typeset +l str1                   # turn off lowercase attribute
    read str2?"Enter another one: "
    str="$str1 and $str2"             #concatenate 2 strings
    print "String concatenation : $str"
        # use '#'  to delete from left
        #     '##' to delete all
        #     '%'  to delete all
        #     '%%' to delete from right
    print "\nRemove the first 2 chars -- ${str#??}"
    print "Remove up to (including) the first 'e' -- ${str#*e}"
    print "Remove the first 2 words -- ${str#* * }"
    print "\nRemove the last 2 chars -- ${str%??}"
    print "Remove from last 'e' -- ${str%e*}"
    print "Remove the last 2 tokens -- ${str% * *}"
    print "length of the  string= ${#str}"
    ########################
    # Parsing strings into words :
    typeset -l line                     # line will be stored in lowercase
    read finp?"Pathname of the file to analyze: "
    read fout?"Pathname of the file to store words: "
    # Set IFS equal to newline, space, tab and common punctuation marks
    IFS="
        ,. ;!?"
    while read line                     # read one line of text
    do                                  # then Parse it :
        if [[ "$line" != "" ]]          # ignore blank lines
        then
            set $line                   # parse the line into words
            print "$*"                  # print each word on a separate line
        fi
    done < $finp > $fout                # define the input & output paths
    sort $fout | uniq | wc -l           # UNIX utilities


