#!/bin/ksh 
#set -x

##########
# Variables
##########
DATE=`date +%Y%m%d_%H%M%S`
PRE="/export/home/dstock/scripts" 
TMP_OUT="/export/home/dstock/logs/ans-$$"
TLOG="/export/home/dstock/logs/${DATE}-ck.trans"
OUT="/export/home/dstock/logs/${DATE}-ck.out"

SSH="/usr/bin/ssh -q -o ConnectTimeout=10 -o BatchMode=yes -i /export/home/dstock/.ssh/id_rsa" 
# SSH="/usr/bin/ssh -q -o ConnectTimeout=10 -i /export/home/dstock/.ssh/id_rsa" 
SCP="/usr/bin/scp -q -i /export/home/dstock/.ssh/id_rsa" 

#################################
# LIST 
L="${PRE}/lists/hosts"
#L="${PRE}/lists/tmp"
#L="${PRE}/lists/satalite-active.list"
# L="${PRE}/lists/active-hw.list"
# L="${PRE}/lists/satalite-active-px.list"
# L="${PRE}/lists/satalite-active-qa.list"
# L="${PRE}/lists/satalite-active-te.list"
# L="${PRE}/lists/bigdata.list"
# L="${PRE}/lists/reference-sys.list"

LIST=`cat $L`
WC=`wc -w $L|awk '{print $1}'`

ID=`whoami`
if [ $ID = root ]; then
  echo "You shouldn't run this script as root. Change to your user. "
  exit
fi

################################
DoPING()
{
IP=`nslookup $host|grep Address|tail -1|cut -f2 -d":"|grep -v $PRE196.198`
if [ -n $IP ]; then 
 PING=$(/bin/ping -c 1 $IP |grep transmitted|cut -f3 -d","|cut -f1 -d"%")
 CNT=`cat -n $1 |grep ${NAME}$|awk '{print $1}'`
 if [ $PING -eq 0 ]; then
        DoCheck 
	echo $host:$PING
 else
       STAT="NOTOK"
 fi
fi 
}

DoCheck ()
{
CNT=`cat -n $L |grep $host|awk '{print $1}'|cut -f1 -d';'`

##########################
## prefetch checks
#/usr/lib64/nagios/plugins/check_nrpe -H ${host} -c check_procs -a '-c 1:2 -a rhsmcertd' >>  $TMP_OUT
# /usr/lib64/nagios/plugins/check_nrpe -H ${host} -c check_procs -a '-c 1:2 -a oddjobd' >>  $TMP_OUT
#/usr/lib64/nagios/plugins/check_nrpe -H ${host} -c check_disk -a '-w 20% -c 15% -p /var' >>  $TMP_OUT
#/usr/lib64/nagios/plugins/check_nrpe -H ${host} -c check_disk -a '-w 20% -c 15% -p /boot' >>  $TMP_OUT
#/usr/lib64/nagios/plugins/check_nrpe -H ${host} -c check_disk -a '-w 20% -c 15% -p /' >>  $TMP_OUT
$SSH ${host} sudo subscription-manager status |grep Overall >>  $TMP_OUT

## setup auth
# $SCP ~/.ssh/authorized_keys ${host}:~/authorized_keys
# $SCP ~/.bashrc ${host}:~/
# $SSH ${host} ls -l /home|grep dstock 
# $SCP ${host}:/tmp/rpm-report-* /tmp/
# $SCP ~/scripts/push-ssh-auth.sh ${host}:/tmp/push-ssh-auth.sh
# $SSH ${host} ./push-ssh-auth.sh
# $SSH ${host} mkdir ./.ssh
# $SSH ${host} mv ~/authorized_keys ~/.ssh/
# $SCP ~/scripts/monitoring/check_uc4_procs_v9 ${host}:/tmp/check_uc4_procs_v9
# $SCP ~/scripts/satellite/part_bigdata_hdfs.sh ${host}:/tmp/
# $SSH ${host} rm ./push-ssh-auth.sh

FILE=check_mounts.sh
BASE="/tmp"
# BASE="/opt/DiBaicinga/libexec"
# $SCP ${BASE}/${FILE} ${host}:${BASE}/${FILE}; echo $? >> $TMP_OUT
# $SCP ${BASE}/${FILE1} ${host}:${BASE}/${FILE1}; echo $? >> $TMP_OUT
# $SCP ${BASE}/${FILE2} ${host}:${BASE}/${FILE2}; echo $? >> $TMP_OUT
# $SSH ${host} ${BASE}/${FILE} >> $TMP_OUT

##########
## work with ip 
# nslookup $host|grep Address|grep -v "$PRE$PRE198"|cut -f2 -d: >> $TMP_OUT
## Icinga antrag
# Host: IP: Anwendung: OS Template
# A=`host $host|awk '{print $4}'`; echo $A": RSIB: RHEL6" >> $TMP_OUT
# A=`host $host|awk '{print $4}'`; echo $A": RSIB: RHEL-DMZ" >> $TMP_OUT
# A=`host $host|awk '{print $4}'`; echo $A": RSIB: RHEL-Standard" >> $TMP_OUT

##########
## stats from confi data
# 1-NAME: 2-ID: 3-KERNEL: 4-RELEASE: 5-VERSION: 6-CSTAGE: 7-APPLICATION: 8-WARTUNG-CIF: 9-WARTUNG-GRP: 10-ANW: 11-EMAIL: 12-CONTACT: 13-REGDATE: 14-PRODUCT
# grep ${host} /APPL/dstock/share/data/satellite-patch-report.data |cut -f11,11,11,11,11,11,11,11,11,11,11,12,13 -d: >> $TMP_OUT
# grep ${host} /APPL/dstock/share/data/uname.data >> $TMP_OUT
# grep ${host} /APPL/dstock/share/data/cacti.data >> $TMP_OUT
# grep ${host} /APPL/dstock/share/data/cacti_host-status.data|cut -f3 -d: |cut -f6 -d'.' >> $TMP_OUT
# grep ${host} /APPL/dstock/share/data/vmware.data >> $TMP_OUT
# grep ${host} /APPL/dstock/share/data/all-host-anwendung.rpt >> $TMP_OUT
# grep ${host} /APPL/dstock/share/data/uname.data
# grep ${host} /APPL/dstock/share/data/uname.data

# ~/scripts/security/poodle.sh ${host} 443 >> $TMP_OUT

########################
# $SSH ${host} 
# $SSH ${host} locate ldapsearch >> $TMP_OUT
# scp -q /APPL/dstock/BUILD/icinga/clients/linux/configs/nrpe.cfg ${host}:/etc/opt/DiBaicinga/nrpe.cfg; echo $? >> $TMP_OUT
# $SSH ${host} /usr/bin/ldapsearch -x -LLL -h gf01sxmg047p.corp.int -D cn=proxyagent,ou=profile,dc=corp,dc=int -w proxy4ldap uid=dstock >> $TMP_OUT
# /APPL/icinga/libexec/check_nrpe -H ${host} >> $TMP_OUT
# /APPL/icinga/libexec/check_nrpe -H ${host} -c check_disk -a '-w 20% -c 15% -p /' >> $TMP_OUT
# /APPL/icinga/libexec/check_nrpe -H ${host} -c check_ntp -a '-H $IP' >> $TMP_OUT
# /APPL/icinga/libexec/check_nrpe -H ${host} -c check_ntp -a '-H $IP' >> $TMP_OUT
# BASE="/opt/DiBaicinga/libexec"
# $SSH ${host} sudo ls -l /opt/DiBaicinga/libexec >> $TMP_OUT
#$SSH ${host} sudo ip addr >> $TMP_OUT
#$SSH ${host} sudo lsblk >> $TMP_OUT
# $SSH ${host} sudo ifup /etc/sysconfig/network-scripts/ifcfg-bond0 >> $TMP_OUT
#echo "" >> $TMP_OUT
#$SSH ${host} netstat -nr >> $TMP_OUT
#$SSH ${host} cat /etc/sysconfig/network|grep GATEWAY|cut -f2 -d'=' >> $TMP_OUT
#$SSH ${host} ifconfig -a | sed -rn '2s/ .*:(.*)$/\1/p' >> $TMP_OUT
#$SSH ${host} sudo ifconfig >> $TMP_OUT
# $SSH ${host} sudo cat /proc/net/bonding/bond0 >> $TMP_OUT
#$SSH ${host} sudo cat /etc/sysconfig/network-scripts/ifcfg-eth* >> $TMP_OUT
#$SSH ${host} sudo cat /etc/sysconfig/network-scripts/ifcfg-bond0 >> $TMP_OUT
# $SSH ${host} sudo /usr/local/icinga/libexec/diba_baseline_unittest.sh >> $TMP_OUT
# $SSH ${host} sudo /bin/rhncfg-client channels >> $TMP_OUT
#$SSH ${host} ls -l /etc/opt/DiBaicinga/nrpe.cfg >> $TMP_OUT
# $SSH ${host} '/opt/DiBaicinga/libexec/check_disk  -w 20% -c 15% -p /' >> $TMP_OUT
# $SSH ${host} /opt/DiBaicinga/libexec/check_ntp  -H gf01yntp21 -w 0.5 -c 1 >> $TMP_OUT
# $SSH ${host} /opt/DiBaicinga/libexec/check_logfiles -f /etc/opt/DiBaicinga/System-logfile.cfg >> $TMP_OUT
# $SSH ${host} ls -l /APPL/icinga/ >> $TMP_OUT
# $SSH ${host} cat /tmp/lsof.out>> $TMP_OUT
# $SSH ${host} uptime >> $TMP_OUT
# $SSH ${host} ifconfig -a >> $TMP_OUT
#$SSH ${host} date > /var/tmp/ds.test >> $TMP_OUT
#$SSH ${host} cat /var/tmp/ds.test >> $TMP_OUT
# $SSH ${host} cat /proc/mounts >> $TMP_OUT
# $SSH ${host} cat /etc/ntp.conf >> $TMP_OUT
# $SSH ${host} yum list *release* >> $TMP_OUT
# $SSH ${host} ls -l /export >> $TMP_OUT
# $SSH ${host} ls -l /etc/snmp/snmpd.conf >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/bin/update.config_local.sh >> $TMP_OUT
#$SSH ${host} ls -l /usr/local/bin/update_to_release_ng.sh >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/bin/cgi_vm_reinstall.sh >> $TMP_OUT
# $SSH ${host} ls -l /usr/openv/netbackup/bp.conf >> $TMP_OUT
# $SSH ${host} ls -l /BIGDATA/home >> $TMP_OUT
# $SSH ${host} sudo "sed -i -e 's/SERVER = nbu10/SERVER = nbu50/g' /usr/openv/netbackup/bp.conf" 
# $SSH ${host} sudo cat /usr/openv/netbackup/bp.conf >> $TMP_OUT
# $SSH ${host} cat /tmp/userlist >> $TMP_OUT
# $SSH ${host} sudo chage -E -1 -I -1 -m 0 -M 99999 -W 7 nessus >> $TMP_OUT
# $SSH ${host} sudo grep nessus /etc/shadow  >> $TMP_OUT
# $SSH ${host} sudo /usr/sbin/sestatus |grep status >> $TMP_OUT
# $SSH ${host} sudo puppet agent -t --debug --noop  >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/set_ldap_hostsallowedlogin.sh -n p_cs_sv >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/set_ldap_hostsallowedlogin.sh -n iti_as >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/set_ldap_hostsallowedlogin.sh -n iti_jeea >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/set_ldap_hostsallowedlogin.sh -l >> $TMP_OUT
#$SSH ${host} sudo /usr/local/bin/set_ldap_hostsallowedlogin.sh -u >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/diba_unittests.sh >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/prefetch.sh 0 >> $TMP_OUT
# $SSH ${host} sudo grep gcc /var/log/yum.log* >> $TMP_OUT
#$SSH ${host} sudo ls -l /etc/sudoers.d/ >> $TMP_OUT
# $SSH ${host} sudo rhncfg-client get /usr/local/bin/cgi_vm_reinstall.sh>> $TMP_OUT
# $SSH ${host} ps -ef |grep yum >> $TMP_OUT
#$SSH ${host} sudo yum clean all >> $TMP_OUT
# $SSH ${host} sudo yum -y downgrade ksh-20120801-21.el6.x86_64 >> $TMP_OUT
#$SSH ${host} sudo ls -l /etc/sudoers.d/ >> $TMP_OUT
# $SSH ${host} sudo cat /etc/sudoers.d/sudoers_pj_bd >> $TMP_OUT
# $SSH ${host} sudo cat /tmp/this-is-a-test-file.txt >> $TMP_OUT
# $SSH ${host} ls -l  /opt/DiBaicinga/libexec/config/auslastung.cfg >> $TMP_OUT
# $SSH ${host} cat  /opt/DiBaicinga/libexec/config/auslastung.cfg >> $TMP_OUT
# $SSH ${host} sudo cat /usr/local/bin/update.config.sh |grep relrpmversion|grep -v '#' >> $TMP_OUT
# $SSH ${host} sudo yum search --showduplicates diba-rel|grep 201507 >> $TMP_OUT
# $SSH ${host} sudo rm -f /tmp/rhncfg-backup* >> $TMP_OUT
# $SSH ${host} sudo rm -f /tmp/bashunit* >> $TMP_OUT
# $SSH ${host} sudo  >> $TMP_OUT
# $SSH ${host} getent passwd afinke >> $TMP_OUT
# $SSH ${host} rm /tmp/userlist 
#$SSH ${host} who >> $TMP_OUT
# $SSH ${host} sudo pf -h|egrep -v "tmpfs|Mounted|boot|home|mapper">> $TMP_OUT
##  bigdata checks
#$SSH ${host} sudo ls -l /etc/sudoers.d/aaexpenv_dev_de >> $TMP_OUT
#$SSH ${host} sudo /usr/local/bin/sudo_tmp_user.sh gufische >> $TMP_OUT
#$SSH ${host} sudo rm -f /etc/sudoers.d/aaexpenv_dev_de >> $TMP_OUT
# $SSH ${host} sudo adduser -u 50016 sare >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/bin/cgi_vm_reinstall.sh >> $TMP_OUT
# $SSH ${host} df -TP -x tmpfs -x nfs >> $TMP_OUT

# $SSH ${host} sudo ls -l /dev/sd* >> $TMP_OUT
# $SSH ${host} df -h >> $TMP_OUT
#$SSH ${host} ls -l /APPL >> $TMP_OUT
#$SSH ${host} /sbin/tune2fs -l /dev/sdc1|grep count: >> $TMP_OUT

#$SSH ${host} hostname >> $TMP_OUT
# $SSH ${host} sudo df -h >> $TMP_OUT
# $SSH ${host} sudo mv /etc/yum.repos.d/epel.repo /tmp/ >> $TMP_OUT
#$SSH ${host} sudo rpm -i http://gf0vsxmg060p/pub/katello-ca-consumer-latest.noarch.rpm >> $TMP_OUT
#$SSH ${host} sudo subscription-manager register --org=$ORG --activationkey=akey_t_rhel6_j2ee >> $TMP_OUT
#$SSH ${host} sudo subscription-manager attach >> $TMP_OUT
#$SSH ${host} sudo subscription-manager repos --enable=rhel-*-satellite-tools-*-rpms >> $TMP_OUT
#$SSH ${host} sudo yum -y install katello-agent >> $TMP_OUT
#$SSH ${host} sudo chkconfig goferd on >> $TMP_OUT

#$SSH ${host} lsblk >> $TMP_OUT
# $SSH ${host} grep was /etc/passwd >> $TMP_OUT
#$SSH ${host} find /BIGDATA/ -ls  >> $TMP_OUT
#$SSH ${host} find /etc/init.d/ -ls  >> $TMP_OUT
# $SSH ${host} rpm -qa |grep -i ssacli >> $TMP_OUT
# $SSH ${host} rpm -qa |grep -i git >> $TMP_OUT
#$SSH ${host} rpm -qa |grep -i diba-rel >> $TMP_OUT
# $SSH ${host} cat /usr/openv/netbackup/bp.conf >> $TMP_OUT
##  bigdata checks end 
#$SSH ${host} grep server /etc/chrony.conf >> $TMP_OUT
# $SSH ${host} sudo /usr/local/bin/pushlocalcfg2sat.sh /etc/chrony.conf >> $TMP_OUT
# $SSH ${host} ls -la /tmp|wc -l >> $TMP_OUT
# $SSH ${host} ls -la /tmp >> $TMP_OUT
# $SSH ${host} ls -la /usr/openv/netbackup/|grep bp.conf >> $TMP_OUT
# $SSH ${host} ls -la  /var/dope/klif |grep IDA_D_KF_IF_VERT_ANGEBOT_ZWIFI_2015_04_22_15.38.29.162.pdf >> $TMP_OUT
# $SSH ${host} cat /usr/openv/netbackup/bp.conf >> $TMP_OUT
# $SSH ${host} cat /var/local/systeminfo.info >> $TMP_OUT
# $SSH ${host} cat /tmp/hpconfig.rpt  >> $TMP_OUT
# $SSH ${host} cat /proc/partitions  >> $TMP_OUT
# $SSH ${host} cat /etc/fstab |grep klif  >> $TMP_OUT
# $SSH ${host} cat /etc/ntp.conf  >> $TMP_OUT
# $SSH ${host} mount >> $TMP_OUT
# $SSH ${host} mount|grep nfs >> $TMP_OUT
# $SSH ${host} /sbin/route|grep default >> $TMP_OUT
# $SSH ${host} /sbin/route -n >> $TMP_OUT
# $SSH ${host} grep -i YUMUPDATEALL /usr/local/bin/update.config.sh >> $TMP_OUT
# $SSH ${host} rpm -qa |grep subscription-manager >> $TMP_OUT
# $SSH ${host} rpm -qa |grep kernel-2 >> $TMP_OUT
# $SSH ${host} rpm -qa |grep vmware-tools-esx-nox >> $TMP_OUT
# $SSH ${host} rpm -qa |grep uc4 >> $TMP_OUT
# $SSH ${host} rpm -qa |grep ksh >> $TMP_OUT
# $SSH ${host} rpm -qi mod_ssl |grep -i version >> $TMP_OUT
# $SSH ${host} rpm -qa |grep -i diba-rel >> $TMP_OUT
# $SSH ${host} rpm --query --all --queryformat '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n'|sort  >> $TMP_OUT
# $SSH ${host} cat /etc/aliases|grep ing-diba >> $TMP_OUT
# $SSH ${host} cat /tmp/sw-rpm-qa.txt >> $TMP_OUT
# $SSH ${host} /sbin/chkconfig --list was >> $TMP_OUT
# $SSH ${host} ls -l /etc/sysconfig/iptables  >> $TMP_OUT
# $SSH ${host} ps -ef | grep netbackup >> $TMP_OUT
# $SSH ${host} ps -ef |grep yum >> $TMP_OUT
# $SSH ${host} ps -ef |grep rhn >> $TMP_OUT
# $SSH ${host} netstat -na |grep 53 >> $TMP_OUT
# $SSH ${host} free >> $TMP_OUT
# $SSH ${host} sudo init 0 >> $TMP_OUT
# $SSH ${host} echo 'echo `date` hello_dan > /tmp/nsca_test' >> /opt/local/nagios/agent/nsca_cron_daily 
# $SSH ${host} cat /opt/local/nagios/agent/nsca_cron_daily >> $TMP_OUT
# $SSH ${host} cat /etc/security/limits.d/90-nproc.conf |grep nproc>> $TMP_OUT
# $SSH ${host} ps axms|wc -l  >> $TMP_OUT
# $SSH ${host} top -b -H -n1|head -6 >> $TMP_OUT
# $SSH ${host} ls -l /export/home/dstock >> $TMP_OUT
# $SSH ${host} ps -ef |grep nrpe >> $TMP_OUT
# $SSH ${host} ps -ef |grep yum >> $TMP_OUT
# $SSH ${host} ps -ef |grep esd >> $TMP_OUT
# $SSH ${host} grep auth /etc/*syslog.conf |grep -v "#" >> $TMP_OUT
# $SSH ${host} ls -l /opt |grep symon >> $TMP_OUT
# $SSH ${host} ls -l /opt/local/nagios/agent/|grep nsca >> $TMP_OUT
# $SSH ${host} ls -l /opt/local/|grep nagios >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/nagios/libexec >> $TMP_OUT
# $SSH ${host} ls -l /opt/local/nagios/agent >> $TMP_OUT
# $SSH ${host} grep -i ing-diba /etc/aliases >> $TMP_OUT
# $SSH ${host} hostname >> $TMP_OUT
# $SSH ${host} uname -a >> $TMP_OUT
# $SSH ${host} echo $LANG >> $TMP_OUT
# $SSH ${host} env|grep -i SHELL >> $TMP_OUT
# $SSH ${host} umask >> $TMP_OUT
# $SSH ${host} ls -l /BIGDATA  >> $TMP_OUT
# $SSH ${host} crontab -l >> $TMP_OUT
# $SSH ${host} grep nagios /var/adm/messages|tail -10 >> $TMP_OUT
# $SSH ${host} /usr/bin/svcs -x >> $TMP_OUT
# $SSH ${host} /usr/sbin/arp -a|grep SP | grep -i sxcs >> $TMP_OUT
# $SSH ${host} cat /etc/inet/ntp.conf >> $TMP_OUT
# $SSH ${host} ps -ef |grep icinga >> $TMP_OUT
# $SSH ${host} ps -ef |grep mysql  >> $TMP_OUT
# $SSH ${host} cat /var/local/systeminfo.info >> $TMP_OUT
# $SSH ${host} cat /etc/syslog.conf >> $TMP_OUT
# $SSH ${host} cat /etc/rsyslog.conf >> $TMP_OUT
# $SSH ${host} cat /etc/ntp.conf >> $TMP_OUT
# $SSH ${host} ntpq -p >> $TMP_OUT
# $SSH ${host} cat /etc/passwd >> $TMP_OUT
# $SSH ${host} cat /etc/group >> $TMP_OUT
# $SSH ${host} cat /etc/redhat-release >> $TMP_OUT
# $SSH ${host} cat /etc/hosts|grep mailhost >> $TMP_OUT
# $SSH ${host} ps -efo zone,pid,user,args|grep global |grep -v grep >> $TMP_OUT
# $SSH ${host} ps -ef |grep esd  >> $TMP_OUT
# $SSH ${host} ps -ef |grep set_home.sh  >> $TMP_OUT
# $SSH ${host} ps -ef  >> $TMP_OUT
# $SSH ${host} df -h >> $TMP_OUT
# $SSH ${host} df -h |grep -i j2ee >> $TMP_OUT
# $SSH ${host} du -dk / | sort -nru | head -30 >> $TMP_OUT
# $SSH ${host} /usr/sbin/prtdiag -v >> $TMP_OUT
# $SSH ${host} ls -l /var/adm/exacct/zstat-process |awk '{print $5,$9}' >> $TMP_OUT
# $SSH ${host} ls -l /etc/rc3.d/ |grep -i was  >> $TMP_OUT
# $SSH ${host} ls -l /opt/zone*  >> $TMP_OUT
# $SSH ${host} ls -l /var/tmp/System-logfile.*  >> $TMP_OUT
# $SSH ${host} ls -l /opt/local/nagios/agent/System-logfile.cfg >> $TMP_OUT
# $SSH ${host} cat /opt/local/nagios/agent/System-logfile.cfg >> $TMP_OUT
# $SSH ${host} /usr/sbin/zoneadm list -iv  >> $TMP_OUT
# $SSH ${host} /usr/bin/prstat -Z 1 1 | grep -i ${host} >> $TMP_OUT
# $SSH ${host} /usr/bin/rcapstat -g 2 2 >> $TMP_OUT
# $SSH ${host} /usr/bin/prctl -i zone ${host} >> $TMP_OUT
# $SSH ${host} grep $PRE168 /etc/syslog.conf >> $TMP_OUT
# $SSH ${host} ls -l  /var/adm/exacct/zstat-process > $TMP_OUT
# $SSH ${host} ls -l /var|grep core> $TMP_OUT
# $SSH ${host} ls -l /usr/local/nagios/libexec/check_prtdiag.sh >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/nagios/libexec/ >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/nagios/libexec/check_tempurature.sh >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/nagios/libexec/check_zone* >> $TMP_OUT
# $SSH ${host} date >> $TMP_OUT
# $SSH ${host} cat /etc/inet/ntp.conf >> $TMP_OUT
# $SSH ${host} cat /etc/fstab >> $TMP_OUT
# $SSH ${host} cat /etc/syslog.conf >> $TMP_OUT
# $SSH ${host} /usr/bin/netstat -i|awk '{print $1,$6,$8}' >> $TMP_OUT
# $SSH ${host} ls -l /usr/local/nagios/libexec/check_mailq >> $TMP_OUT
# $SSH ${host} ls -l /opt/local/nagios >> $TMP_OUT
# $SSH ${host} ls -l /opt/local/nagios/agent/System-logfile.cfg >> $TMP_OUT
# $SSH ${host} "cp /tmp/fsmon.sh /var/opt/SUNWsymon/bin; cp /tmp/check_multi_process.sh /var/opt/SUNWsymon/bin"
## test if fs ro is
#$SSH ${host} date > /var/tmp/test-fs 
#$SSH ${host} cat /var/tmp/test-fs >> $TMP_OUT
#$SSH ${host} grep "\sro[\s,]" /proc/mounts| grep -v tmpfs >> $TMP_OUT
#$SSH ${host} mount >> $TMP_OUT

## Transfer check
TRANS=$?

echo "${host}: ${CNT}-${WC}: ${IP}: ${TRANS}"

## TRANS
if [ $TRANS = 0 ]; then
        echo $host:$IP:OK >> $TLOG
else
        echo $host:$IP:NOTOK:$TRANS >> $TLOG
fi

## TMP REPORT
if [ -a $TMP_OUT ]; then 
	while read LINE; do echo "$host: $LINE" >> $OUT; done < $TMP_OUT
        echo "" >> $OUT
	rm $TMP_OUT
fi

## REPORT
# echo "${host}:${IP}:${ANS}" >> $OUT

}

##########
# Main Scripts
##########
if [ -f $TMP_OUT ];then 
	rm $$TMP_OUT
fi 

if [ $# -eq 0 ]; then 
        LIST=$LIST
        for host in ${LIST}
        do
                IP=`nslookup $host|grep Address|grep -v "$PRE$PRE198"|cut -f2 -d:`
                DoCheck 
        done
else
        host=$1
        IP=`nslookup $host|grep Address|grep -v "$PRE$PRE198"|cut -f2 -d:`
        DoCheck
fi 

echo " 
======================= " 
cat ${OUT}
echo " 
====== Trans =============== "
echo "OK count : `grep :OK ${TLOG} |wc -l`"
echo "NOT-OK count : `grep NOTOK ${TLOG} |wc -l`"
echo " 
echo ====== Log =================="
echo ${OUT}
echo ${TLOG}

