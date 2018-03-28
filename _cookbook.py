#!/usr/bin/env python
# -*- coding: utf-8 -*-

## api doc 
https://$SERVER.int/apidoc/v2.html 

######################################################
# IMPORT Modules
######################################################
desc=""" this script does xyz """
import re, os, sys, commands, json, argparse

import xmlrpclib
import ConfigParser
import json
import commands
import argparse
import requests
import shlex
import logging
from subprocess import PIPE
import subprocess

## SAT5 client session
import xmlrpclib, ConfigParser
cfg_parser = ConfigParser.SafeConfigParser()
cfg_parser.readfp(open("/export/home/config"))
cfg_parser.readfp(open("/etc/sysconfig/rhof", "r"))
SATELLITE_URL = cfg_parser.get("rhof", "rhns_url")
SATELLITE_LOGIN = cfg_parser.get("rhof", "rhns_user")
SATELLITE_PASSWORD = cfg_parser.get("rhof", "rhns_password")
client = xmlrpclib.Server(SATELLITE_URL, verbose=0)
session = client.auth.login(SATELLITE_LOGIN, SATELLITE_PASSWORD)

###########################################
## tips vsphere api
# http://code.google.com/p/pysphere/wiki/GettingStarted
import xmlrpclib, ConfigParser
from pysphere import VIServer
cfg_parser = ConfigParser.SafeConfigParser()

cfg_parser.readfp(open("/etc/sysconfig/rhof", "r"))
vsphere_user=cfg_parser.get("vsphere","vsphere_user")
vsphere_password=cfg_parser.get("vsphere","vsphere_password")



##################################################################
## pyVIM new python module for vmware 
from pyVmomi import vim, vmodl
from pyVim import connect
from pyVim.connect import Disconnect
import xmlrpclib, ConfigParser



si = connect.Connect(vsphere_server, 443, vsphere_user, vsphere_password)



####################################################
## comprehensions
####################################################
## list comprehensions 
nums = [1,2,3,4,5,6,7,8,9,10]

## print a list of numbers 
my_list = [ n for n in nums ] 

## square n - n*n for each n in nums
my_list = [ n*n for n in nums ]

##  print n if it is an even number
my_list = [ n for n in nums if n%2 == 0 ] 

## letter and number pair for 'abcd' and '0123' cartesian product 
my_list = [ (letter, num) for letter in 'abcd' for num in range(4) ]
# [('a', 0), ('a', 1), ('a', 2), ('a', 3), ('b', 0), ('b', 1), ('b', 2), ('b', 3), ('c', 0), ('c', 1), ('c', 2), ('c', 3), ('d', 0), ('d', 1), ('d', 2), ('d', 3)]


## dictitonary comprehensions
# Code that creates a set of all the first letters in a sequence of words
names = ['Bruce','Clark','Peter','Logan','Wade']
heros = ['Batman','Superman','Spiderman','Wolverine','Deadpool']

my_dict = {name: hero for name, hero in zip (names, heros)}
my_dict = {name: hero for name, hero in zip (names, heros) if name != 'Peter'}

first_letters = {w[0] for w in words}

flipped = {value: key for key, value in original.items()}

## set comprehensions
nums = [1,1,2,2,3,3,3,6,4,5,6,7,8,8,9,10]
my_set = {n for n in nums}


## generator expressions
my_gen = ( n*n for n in nums) 
for i in my_gen: 
  print i 


##################################################################
## safe parser read the section in the config file
from ConfigParser import SafeConfigParser
sparser = SafeConfigParser()
sparser.read('/etc/sysconfig/rhof')

## get all the appl types in the config file
for section_name in sparser.sections():
  print 'Section:', section_name
  for name, value in sparser.items(section_name):
    print '  %s ' % (name)


############################################
## cgi
############################################
import os
import cgi
import cgitb; cgitb.enable()

if os.environ.has_key('QUERY_STRING'):
  is_cgi = True
  query_data = cgi.parse_qs(os.environ['QUERY_STRING'])
  if query_data.has_key('hostname'):
    HOST = query_data['hostname'][0]
  else:
    successMsg += "No comment given.<br>\n"
print "Content-type: text/html\r\n\r\n";
print "%s \n" % (HOST)


############################################
## option parser for arguments
############################################
## add a argument parser
from optparse import OptionParser
opt_parser = OptionParser(usage="usage: ")
opt_parser.add_option('-n', '--name', help='enter system name to reinstall')
(options, args) = opt_parser.parse_args()

if len(args) != 0:
  opt_parser.error("wrong number of arguments")

print options
print args

args = opt_parser.parse_args()
NAME=args.name



####################################
## Sat 6 api / sat6
####################################

 
import ConfigParser
import shlex
import logging
import ipaddress
import pprint
pp=pprint.PrettyPrinter(indent=4)

## Set the Configuration
sat_parser = ConfigParser.SafeConfigParser()
arg_parser = argparse.ArgumentParser()
sat_parser.readfp(open(CONFIG_FILE, "r"))

parser = ConfigParser.SafeConfigParser()
parser.readfp(open(CONFIG_FILE,"r"))
SAT_LOGIN =  parser.get("sat6", "USERNAME")
SAT_PASSWORD =  parser.get("sat6", "PASSWORD")
SAT_API =  parser.get("sat6", "SAT_API") + "/api/v2/"
ANSIBLE_HOME = parser.get("ansible", "ANSIBLE_HOME")
SSL_VERIFY = True # Ignore SSL for now

### funktions
def get_json(url):
  r = requests.get(url, auth=(SAT_LOGIN, SAT_PASSWORD), verify=SSL_VERIFY)
  return r.json()

def get_results(url):
  jsn = get_json(url)
  if not jsn.get('error'):
    if jsn.get('results'):
      return jsn['results']
    elif 'results' not in jsn:
      return jsn
    else:
      print "No results found"
      return None








###################################################
import json
import sys
import requests

URL = "https://"
SAT_API = "%s/katello/api/v2/" % URL
KATELLO_API = "%s/katello/api/" % URL
POST_HEADERS = {'content-type': 'application/json'}
USERNAME = "admin"
PASSWORD = ""
SSL_VERIFY = False
ORG_NAME = "Default_Organization"
ENVIRONMENTS = ["Development", "Testing", "Production"]






def get_json(location):
  """
  Performs a GET using the passed URL location
  """
  r = requests.get(location, auth=(USERNAME, PASSWORD), verify=SSL_VERIFY)
  return r.json()

def post_json(location, json_data):
  """
  Performs a POST and passes the data to the URL location
  """
  result = requests.post(
  location,
  data=json_data,
  auth=(USERNAME, PASSWORD),
  verify=SSL_VERIFY,
  headers=POST_HEADERS)
  return result.json()


# function for satellte connection
def get_json(url):
  r = requests.get(url, auth=(SAT_LOGIN, SAT_PASSWORD), verify=SSL_VERIFY)
  return r.json()

# function for return results
def get_results(url):
  jsn = get_json(url)
  if not jsn.get('error'):
    if jsn.get('results'):
      return jsn['results']
    elif 'results' not in jsn:
      return jsn
    else:
      print "No results found"
      return None

def get_hostid(hostname):
  url = SAT_API + "hosts/" + hostname
  print(url) 
  results = get_results(url)
  if not results:
    print "Server not found."
    sys.exit(1)
  host_id = results.get("id")
  return str(host_id)



def main():
  """
  Main routine that creates or re-uses an organization and
  lifecycle environments. If lifecycle environments already
  exist, exit out.
  """
  # Check if our organization already exists
  org = get_json(SAT_API + "organizations/" + ORG_NAME)
  # If our organization is not found, create it
  if org.get('error', None):
    org_id = post_json(
      SAT_API + "organizations/",
      json.dumps({"name": ORG_NAME}))["organization"]["id"]
    print "Creating organization: \t" + ORG_NAME
  else:
    # Our organization exists, so let's grab it
    org_id = org['id']
    print "Organization '%s' exists." % ORG_NAME

    # Now, let's fetch all available lifecycle environments for this org...
    envs = get_json(
      SAT_API + "organizations/" + str(org_id) + "/environments/")

    # ... and add them to a dictionary, with respective 'Prior' environment
    prior_env_id = 0
    env_list = {}
    for env in envs['results']:
      env_list[env['id']] = env['name']
      prior_env_id = env['id'] if env['name'] == "Library" else prior_env_id
      # Exit the script if at least one lifecycle environment already exists

    if all(environment in env_list.values() for environment in ENVIRONMENTS):
        print "ERROR: One of the Environments is not unique to organization"
        sys.exit(-1)
        # Create lifecycle environments

    for environment in ENVIRONMENTS:
          new_env_id = post_json(
            SAT_API + "organizations/" + str(org_id) + "/environments/",
            json.dumps(
              {
                "name": environment,
                "organization_id": org_id,
                "prior": prior_env_id}
            ))["id"]
          print "Creating environment: \t" + environment
          prior_env_id = new_env_id

if __name__ == "__main__":
  main()




####################################
## run a script on system 
####################################
import xmlrpclib
from datetime import date, datetime, time, timedelta
from sys import argv
import socket
import os

id = [] #Satellite server ID
script = "#!/bin/sh \n yum update -y"

def schedule_script():
    earliest_occurrence = xmlrpclib.DateTime()
    print earliest_occurrence
    client.system.scheduleScriptRun(key, id, "root", "root", 300, script, earliest_occurrence)

schedule_script()

client.auth.logout(session)

########################################

############## config channels
## get the config channel names
all_configchannels = client.configchannel.listGlobals(session)
pp.pprint(all_configchannels)

for ch in all_configchannels: ch.get('name')  

## get the rel version in all channels 
LIST=[]
U_FILE=['/usr/local/bin/update.config.sh']
TAG='\nrelrpmversion\S+' 

for ch in all_configchannels:       
 if '-te-' in ch.get('label'):                               
  LIST.append(ch.get('label'))               
  CONF_CHN=ch.get('label')               
  try: 
   INFO = client.configchannel.lookupFileInfo(session, CONF_CHN, U_FILE)
   CONTENT=INFO[0].get('contents')
  except: 
   CONTENT='nn'
  # print CONF_CHN, CONTENT
  if 'nn' != CONTENT:        
   M=re.search(r"(\nrelrpmversion\S+)", CONTENT)                                                                    
   if M: 
     print CONF_CHN +": "+M.group().replace('\n','') 
  else: 
    LIST.append(CONF_CHN) 

  
     print CONF_CHN +': no file' 
     

## list the files in a conf-chn
CH='cfg-sap-te-rhel-server-5'
all_files=client.configchannel.listFiles(session, CH)                     
for file in all_files: file.get('path')               

## get the contents of a file 
file_paths=[]
file_paths.append('/usr/local/bin/update.config.sh')
info=client.configchannel.lookupFileInfo(session, CH, file_paths)
pp.pprint(info) 

# this info needs to be replaced ( relrpmversion="20121026.1611-1" ) 

client.configchannel.createOrUpdatePath()
for 'file' in all_files: ch.get('path') 

client.configchannel.create(session, 'test_config_ds', 'test config ds', 'test desc') 
client.configchannel.deleteChannels(session, ['test_config_ds']) 

'adm_conf_test_PX_rhel5_PX'
'adm_conf_test_QA_rhel5_QA'
'adm_conf_test_TE_rhel5_TE'

STAGES=['PX', 'QA', 'TE']
for x in STAGES: 
  print(x)
  print(LABEL+'_'+x, NAME+'_'+x, DESC+'_'+x)
  client.configchannel.create(session, LABEL+'_'+x, NAME+'_'+x, DESC+'_'+x)

LABEL='label_ds_test'
NAME='name - ds test'
DESC='desc - ds test'

##
ID=1000010849
all_cfg_files = client.system.config.listFiles(session, ID, 1)


# px sat

client = xmlrpclib.Server(server, verbose=0)
session = client.auth.login(user, key)

# te sat
      
client_t = xmlrpclib.Server(server_t, verbose=0)                
session_t = client_t.auth.login(user, key)

## counter 
CNT = 0 
CNT += 1

##################################
## compare two lists
first_list=[1000024507, 1000024504, 1000024484, 1000024502]
secnd_list=[1000024509, 1000024507, 1000024504, 1000024484, 1000024502]

[x for x in first_list if x not in secnd_list] + [x for x in secnd_list if x not in first_list]


### compare to files
list1=[]
list2=[]
with open("sat5.hosts","r") as f:
  content = f.readlines()
  for line in content:
    list1.append(line.strip())

with open("sat6.hosts","r") as f:
  content = f.readlines()
  for line in content:
    list2.append(line.strip())

print(len(list1))
print(len(list2))
list(set(list1) - set(list2))

diff=[a for a in list1+list2 if (a not in list2)]


###################################


## use the set funktion to compare to lists 
ci = [1000024507, 1000024504, 1000024484, 1000024502]
sci = [1000024509, 1000024507, 1000024504, 1000024484, 1000024502]     

len(ci)
len(sci)
sorted(ci)
sorted(sci)
si.intersection(sci)
dir(si)
si.difference(sci)
sci.difference(si)



## erratas, security check
ADVISORY="RHSA-2013:0532"

SYSTEMS=client.errata.listAffectedSystems(session, ADVISORY)
pp.pprint(SYSTEMS) 
for i in SYSTEMS: 
  i.get('name') 

INFO=client.errata.getDetails(session, ADVISORY) 
pp.pprint(INFO) 


## create a list form hosts file

H=[]
with open ('/home/dstock/scripts/lists/hosts') as f:
  content = f.readlines()
  for line in content:
    H.append(int(line.split('\n')[0])) 

## list active host in group 
## group: # grp: grp, group, 
## set the values
ID=1000025842
client.system.getCustomValues(session,ID)
client.system.getName(session,ID)
client.system.getName(session,ID).get('name')

client.system.getId(session,NAME) 
client.system.getId(session,NAME)[0].get('id')

client.system.setCustomValues(session,ID,C)
client.system.setCustomValues(session,ID,E)

VL_ITI_AE_BCA@ing-diba.int

U={'URL': ''}
E={'systemowner_email': ''}
C={'Contact': ''}
A={'Anwendung': ''}
L={'ldapgroup': ''}
W={'Wartung': '27NOV'}
W={'Wartung': '1'}
W={'Wartung': '2'}
W={'Wartung': '3'}
T={'Tranch': '0'}
T={'Tranch': '1'}
T={'Tranch': '2'}
T={'Tranch': '3'}

## more than one at a time
H=client.systemgroup.listActiveSystemsInGroup(session, 'wk_te_nn')          
H=[1000024022, 1000024385, 1000024222, 1000024402, 1000024223, 1000024225, 1000024224, 1000024227]

for ID in H: client.system.getName(session,ID)
for ID in H: client.system.getName(session,ID).get('name')
for ID in H: client.system.getCustomValues(session,ID)
for ID in H: client.system.setCustomValues(session,ID,A)
for ID in H: client.system.setCustomValues(session,ID,C)
for ID in H: client.system.setCustomValues(session,ID,E)
for ID in H: client.system.setCustomValues(session,ID,W)
for ID in H: client.system.setCustomValues(session,ID,T)
for ID in H: client.system.setCustomValues(session,ID,L)

for CIF in [T, W, C, E]: 
for CIF in [W, T]: 
for CIF in [A, L]: 
 for ID in H: 
  print(ID,CIF) 
  client.system.setCustomValues(session,ID,CIF) 

HL=[]
for NAME in H:
  ID=client.system.getId(session,NAME)[0].get('id')
  HL.append(ID)

H=HL

#############################################
## calender 
##############################################
DIC={}

M=calendar.monthcalendar(year,month)
DLIST=[]
WLIST=[]
for w in M:
  for d in w: 
    if d in LIST: 
      DLIST.append(TIME,JOB)
    WLIST.append(d) 

  if w not in L:
    L[w]=''

for d in w:
  L[d]=LIST

GS=[g['name'] for g in client.systemgroup.listAllGroups(session) if g['name'].startswith('Tranche Notfall')]
for G in GRS:
  DIC[G]=client.systemgroup.listActiveSystemsInGroup(session, G)

for GR,IDS in DIC.iteritems():
  LIST=[]
  for ID in IDS:
    LIST.append(client.system.getName(session,ID['id'])['name'])
  DIC[GR]=LIST


## https://docs.python.org/2/library/calendar.html#calendar.Calendar.itermonthdates
## http://pymotw.com/2/calendar/
import calendar

## TextCalendar
# show a month as text output
c = calendar.TextCalendar(calendar.SUNDAY)
c.prmonth(2015, 7)

## HTMLCalendar
# show month in HTML format
c = calendar.HTMLCalendar(calendar.SUNDAY)
print c.formatmonth(2007, 7)

## yeardays2calendar
# Calling yeardays2calendar() produces a sequence of month row lists.
# Each list includes the months as another list of weeks. 
# The weeks are lists of tuples made up of day number (1-31) and weekday number (0-6). 
# Days that fall outside of the month have a day number of 0.

pprint.pprint(calendar.Calendar(calendar.MONDAY).yeardays2calendar(2015, 2))

# formatyear
print calendar.TextCalendar(calendar.SUNDAY).formatyear(2007, 2, 1, 1, 2)

## Calculating Dates
pprint.pprint(calendar.monthcalendar(2015, 7))
pprint.pprint(calendar(calendar.SUNDAY).monthcalendar(2015, 7))

## get the patch day of the month. 
for month in range(1, 13):
    # Compute the dates for each week that overlaps the month
    c = calendar.monthcalendar(2015, month)
    first_week = c[0]
    second_week = c[1]
    third_week = c[2]
    # If there is a Thursday in the first week, the second Thursday
    # is in the second week.  Otherwise the second Thursday must 
    # be in the third week.
    if first_week[calendar.MONDAY]:
        meeting_date = first_week[calendar.WEDNESDAY]
    else:
        meeting_date = second_week[calendar.WEDNESDAY]
    print '%3s: %2s' % (month, meeting_date)

... 
  1:  7
  2:  4
  3:  4
  4:  8
  5:  6
  6:  3
  7:  8
  8:  5
  9:  9
 10:  7
 11:  4
 12:  9

## 
## http://www.tutorialspoint.com/python/python_date_time.htm
year=2015
calendar.month(year,month,w=2,l=1)   
calendar.calendar(year,w=2,l=1,c=6)                                                                                   

## Returns a list of lists of ints. Each sublist denotes a week. Days outside month month of year year are set to 0; days within the month are set to their day-of-month, 1 and up.

month=6
calendar.monthcalendar(year,month)
> [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20, 21], [22, 23, 24, 25, 26, 27, 28], [29, 30, 0, 0, 0, 0, 0]]
month=7
calendar.monthcalendar(year,month)
> [[0, 0, 1, 2, 3, 4, 5], [6, 7, 8, 9, 10, 11, 12], [13, 14, 15, 16, 17, 18, 19], [20, 21, 22, 23, 24, 25, 26], [27, 28, 29, 30, 31, 0, 0]]

##############################################
##  get the release version 

DATE='201508'          
#### set variables
DIRS = os.listdir('/usr/src/redhat/RPMS/')
FILES=[]
U_FILE=['/usr/local/bin/update.config.sh']
EXCEPTIONS=['-none-']
DICT={}
VER_LIST=[]
RPM_LIST=[]
VER_LATEST=''
PAT1='diba-release-'
PAT2='-rhel-'
PAT3='-server-'

FILES = [os.path.join(dp, f) for dp, dn, fn in os.walk(os.path.expanduser("/usr/src/redhat/RPMS/")) for f in sorted(fn) if DATE in f]

for FILE in FILES:
  PATH=ntpath.split(FILE)[0]
  file=ntpath.split(FILE)[1]
  ARCH=re.split(PAT2, file)[1].split(PAT3)[0]
  RHEL=re.split(PAT3, file)[1].split('-')[0]
  VER=re.split(PAT3+RHEL+'-', file)[1].split('.'+ARCH)[0]
  if 'PAE' in VER:
    VER=VER.replace('PAE-','')
  APP=re.split(PAT1, file)[1].split(PAT2)[0]
  APP=APP.replace('os-','')
  OS='NO-OS'
  CHN='diba-'+APP+'-te-rhel-'+ARCH+'-server-'+RHEL
  CONF_CHN = 'cfg-'+APP+'-te-rhel-server-'+RHEL
  if 'os-' in APP:
    APP=APP.split('os-')[1]
    OS='OS'
  RPM_LIST.append((file, PATH, CHN, CONF_CHN, VER, APP))
  print(APP+':'+VER+':'+CHN+':'+FILE)


for i in RPM_LIST:
  FILE=i[0]
  PATH=i[1]
  CHN=i[2]
  CONF_CHN=i[3]
  VER=i[4]
  APP=i[5]
  if 'diba-release-os' not in i[0]:
    print(APP+':'+VER+':'+CHN)





##############################################
## logscans
##############################################
import commands

cmd = 'find /logs/qa/ibr/ -mtime -1 -type f' 
(files) = commands.getstatusoutput(cmd)
pprint.pprint(calendar.monthcalendar(2015, 7))
for file in files: 
  cmd = 'zgrep -i error '+file 
  errors = commands.getstatusoutput(cmd)
  if errors: 
    print(file, errors) 

for file in files:                                                                         
  if isinstance(file, str):                                                                     
    if 'gz' in file: 
       cmd = 'zgrep -i error '+file
       errors = commands.getstatusoutput(cmd)
       if errors: 
         print(file, errors) 

cmd = 'zgrep -i error '+PATH+'/*/messages*' 
(status, output) = commands.getstatusoutput(cmd)

##############################################
## send an email from python 

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
 
def py_mail(SUBJECT, BODY, TO, FROM):
    """With this function we send out our html email"""
    # Create message container - the correct MIME type is multipart/alternative here!
    MESSAGE = MIMEMultipart('alternative')
    MESSAGE['subject'] = SUBJECT
    MESSAGE['To'] = TO
    MESSAGE['From'] = FROM
    MESSAGE.preamble = """
Your mail reader does not support the report format.
Please visit us <a href="http://www.mysite.com">online</a>!"""
    # Record the MIME type text/html.
    HTML_BODY = MIMEText(BODY, 'html')
    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case
    # the HTML message, is best and preferred.
    MESSAGE.attach(HTML_BODY)
    # The actual sending of the e-mail
    server = smtplib.SMTP('smtp.gmail.com:587')
    # Print debugging output when testing
    if __name__ == "__main__":
        server.set_debuglevel(1)
    # Credentials (if needed) for sending the mail
    server.starttls()
    server.login(FROM)
    server.sendmail(FROM, [TO], MESSAGE.as_string())
    server.quit()
 
if __name__ == "__main__":
    """Executes if the script is run as main script (for testing purposes)"""
    email_content = """
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>html title</title>
  <style type="text/css" media="screen">
    table{
        background-color: #AAD373;
        empty-cells:hide;
    }
    td.cell{
        background-color: white;
    }
  </style>
</head>
<body>
  <table style="border: blue 1px solid;">
    <tr><td class="cell">Cell 1.1</td><td class="cell">Cell 1.2</td></tr>
    <tr><td class="cell">Cell 2.1</td><td class="cell"></td></tr>
  </table>
</body>
"""
    TO = 'd.stock@ing-diba.de'
    FROM = 'linuxadmin@ing-diba.de'
    py_mail("Test email subject", email_content, TO, FROM)



### ---oOo---- ########

### html table from a hammer cvs command 
msg='<html><head><title>CV report</title></head><body><table>'
for line in C: 
  for i in line: 
    msg+='<tr>'
    for i in line.split(','):
      msg+=('<td>'+i+'</td>')
    msg+='</tr>'

msg+='</table></body></html>'


########
import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEImage import MIMEImage
from email.MIMEBase import MIMEBase
from email import Encoders


## send the report as email attachment.
sender = 'linuxadmin@ing-diba.de'
recipient = 'd.stock@ing-diba.de'
receivers = 'd.stock@ing-diba.de'
recipients = ['dirk.janssen@ing-diba.de','daniel.stock@ing-diba.de']

SUBJECT=(' - ')
MSG = ('Hi Martin, ... ')
msg = MIMEText(MSG)
msg['Subject'] = SUBJECT
msg['From'] = sender
msg['To'] = receivers

msg = MIMEMultipart()
msg.attach(MIMEText(MSG))
msg.attach(MIMEText(html))


s = smtplib.SMTP('localhost')
s.sendmail(sender, receivers, msg.as_string())
s.quit()

## read file and add to letter
msg.attach(MIMEText(file("text.txt").read()))

## send the report as email attachment.
f = file(LOG)
msg = MIMEMultipart()
msg.attach(MIMEText(MSG))
part = MIMEBase('application', "octet-stream")
part.set_payload(open(LOG, "rb").read())
Encoders.encode_base64(part)
part.add_header('Content-Disposition', 'attachment; filename="/var/tmp/sat6-host-report-meinl.csv"')
msg.attach(part)

### try to send and check status
try:
  s = smtplib.SMTP('localhost')
  s.sendmail(sender, receivers, msg.as_string())
  s.quit()
except smtplib.SMTPException:
  print "Error: unable to send email"



##############################################
## example of main
def compare_2_icinga ( host ):
  print('icinga')

def compare_2_cacti ( host ):
  print('cacti')

def main():
   for host in SAT:
   compare_2_cacti('SERVER')
   compare_2_icinga('SERVER')

if __name__ == "__main__":
    main()

#############################################
list = [1, 2, 3]
tuple = (1, 2, 'hello')
dic = {'key1': 'value1', 'key2': 'value2'}
str = 'this is a string'

############################################
## cgi 
############################################
import os
import cgi
import cgitb; cgitb.enable()

if os.environ.has_key('QUERY_STRING'):
  is_cgi = True
  query_data = cgi.parse_qs(os.environ['QUERY_STRING'])
  if query_data.has_key('hostname'):
    HOST = query_data['hostname'][0]
  else:
    successMsg += "No comment given.<br>\n"

print "Content-type: text/html\r\n\r\n";
print "%s \n" % (HOST)   

###########################################
## confluence api
import sys, os, urllib2, xmlrpclib
import socket
import cgi

cf_user = 'svcvcsconflup'
cf_server = "confluence"
cf_Url = "https://%s/rpc/xmlrpc" % cf_server

server = xmlrpclib.ServerProxy(cf_Url)
token = server.confluence1.login(cf_user,cf_password)

## create new system dok 
pageId=77343607

## rekick start script debug
for vsphere_server in vsphere_host:
  print vsphere_server
  server.connect(vsphere_server, vsphere_user, vsphere_password)
  vmlist = server.get_registered_vms()






LOG=open('/tmp/vsphere-info.data_tmp', 'w+')
LIST=open('/tmp/vsphere-system.list', 'w+')

## create a list of all hosts on a vsphere server
def ListHosts(): 
  print ('ListHosts: '+vsphere_server)
  LIST=[]
  FLIST=open('/tmp/vsphere-system-'+vsphere_server+'.list', 'w+')
  server.connect(vsphere_server, vsphere_user, vsphere_password)
  vmlist = server.get_registered_vms()
  for system in vmlist:
    system = system.split(' ',1)[1].split('/')[0]
    system = system.lower()
    if 'sxbd' in system:
      FLIST.write(system+'\n')
      LIST.append(system)       
      print(system)
  FLIST.close()

def HostInfos(): 
  print ('HostInfos: '+vsphere_server) 
  DLIST=open('/tmp/vsphere-system-'+vsphere_server+'.data', 'w+')
  server.connect(vsphere_server, vsphere_user, vsphere_password)
  with open ('/tmp/vsphere-system-'+vsphere_server+'.list') as FLIST: 
    content = FLIST.readlines()
    for sys in content: 
      sys=sys.replace('\n','')
      vm = server.get_vm_by_name(sys) 
      STATUS = vm.get_status()
      properties = vm.get_properties()
      NUM_CPU = properties['num_cpu']
      MEM = properties['memory_mb']
      try:
        MAC = properties['net'][0]['mac_address']
      except:
        MAC='nn'
      CD="nn"
      DISKS=[] 
      for p in properties['devices']:
        S=properties['devices'][p]['summary']
        T=properties['devices'][p]['type']
        L=properties['devices'][p]['label']
        if 'VirtualDisk' in T:
           DISK=(L,S)
           DISKS.append(DISK)
        if 'VirtualCdrom' in T:
           CD=S
      DISKS=str(DISKS)  
      print(sys,STATUS,NUM_CPU,MEM,MAC,DISKS) 
      DLIST.write(system+':'+STATUS+':'+str(NUM_CPU)+':'+str(MEM)+':'+MAC+':'+DISKS+'\n')
    DLIST.close()      

for vsphere_server in vsphere_servers:
  ListHosts () 
  HostInfos() 


  
      # return sys + STATUS + NUM_CPU + MEM + MAC + DISKS


 



# create a list of all hosts on all vsphere server
for vsphere_server in vsphere_servers:
  print('connecting to: '+vsphere_server)
  server.connect(vsphere_server, vsphere_user, vsphere_password)
  print('Connected')
  vmlist = server.get_registered_vms()
  for system in vmlist:
    system = system.split(' ',1)[1].split('/')[0]
    if 'sx' or 'SX' in system:
      LIST.write(system+'\n')
      print(system)

LIST.close()

## get infomation about hosts from one vsphere server 




## restart a vm 
def vmrestart(): 
  server = VIServer()
  try: 
    server.connect (vsphere_host, vsphere_user,vsphere_password)
  except:
    print "Could not connect to vsphere Server %s. Plese check your credentials\n" %vsphere_host
  try:
    vm2 = server.get_vm_by_name (vm_name)
  except:
    print "Could not connect to vm %s\n" %options.vm_name
    sys.exit (1)
  vm2.power_on ()
 for lists 
list=[]
for system in vmlist: 
  system = system.split(' ',1)[1].split('/')[0]
  list.append(system)


## END vspher
################################
for line in 'satellite-patch-report.data':
  host=line.split('.')[0]

ITEM_LIST  = range(0,10) 
for ITEM in ITEM_LIST: 
  if list is None: 
    list = []
  list.append(ITEM) 

## find duplicats in a list

LIST=[1,2,3,4,4,4,5,6,7,7]
set([x for x in LIST if LIST.count(x) > 1])

duplicateHost = client.system.listDuplicatesByHostname(session)
pp.pprint(duplicateHost) 
H=[ID, ID2, ID3]
for ID in H: client.system.getName(session,ID)
client.system.deleteSystems(session, H) 

duplicateIP = client.system.listDuplicatesByIp(session)

H=[]
for d in duplicateHost:            
  for i in d.get('systems'):                                               
    AGE=i.get('last_checkin')                                                          
    # print(AGE) 
    S=str(AGE) 
    # type(AGE) 
    # print(S) 
    # type(S) 
    if '20141120T10' in S: 
      # print(AGE) 
      i.get('systemName')                                                                      
      i.get('systemId')                                                                                    
      H.append(i.get('systemId').replace('\n','')) 


duplicateIP = client.system.listDuplicatesByIp(session)
H=[]
for d in duplicateHost:
  for i in d.get('systems'):
    AGE=i.get('last_checkin')
    S=str(AGE)
    NAME=i.get('systemName')
    ID=str(i.get('systemId')) 
    INFO=(NAME+':'+ID+':'+S)
    H.append(INFO)


## need a sort in pyhton - i used excel 

## ldapsearch to file 
import commands 
#cmd="ldapsearch -x -LLL -h gf01sxmg47.corp.int -D cn=proxyagent,ou=profile,dc=corp,dc=int -w proxy4ldap uid=*"  
cmd="ldapsearch -D cn=proxyagent,ou=profile,dc=corp,dc=int -w proxy4ldap  -x -b ou=people,dc=corp,dc=int uid=* > /tmp/ldap.out"
(status, output) = commands.getstatusoutput(cmd)

ldap=dict() 
## need to use dn: uid=ito_asu,ou=people,dc=corp,dc=int as the start
## need to add list of hostsallowedlogin: in list dict()
with open('/tmp/ldap.out') as f:
  for line in f:
    if line.startswith('dn: uid='):
      LIST=[]
      UID=(line.split('=')[1]).split(',')[0]
      ldap[UID]=dict()
    for x in ['loginShell:','givenName:','sn:','homeDirectory:','uidNumber:','mail:','gidNumber:']:
      if line.startswith(x):
        ITEM={x:(line.split(': ')[1]).rstrip('\n')}
        if ITEM:
          LIST.append(ITEM) 
          ldap[UID]=LIST
        else: 
          LIST.append('nn') 
          ldap[UID]=LIST
 
for key,value in ldap.iteritems():
  print (key,value) 



########################################################
## dictionaries
########################################################
mig_dic=dict()


if not mig_dic.has_key(hg):
  mig_dic[hg]=list()
if system not in mig_dic.iteritems():
  mig_dic[hg].append(system)

for key,value in mig_dic.iteritems():
  print(key,value)



Dict=dict()
def addtodict(Key,Item,Value):
  if Key not in Dict[Key]:
    Dict[Key]=dict()
    Dict[Key][Item]=Value
  elif Key in Dict[Key]:
    Dict[Key][Item]=Value



keyword_dict = {
 'systemname': system,
 'systemshort' : shortname,
 'id' : str(system_id),
 'ip': ip,
 'appl': appl,
 'stage': stage,
 'systemowner_email' : owner,
 'installdate' : regDateString,
 'saturl' : satURL,
 'applreleaserpm' :  supposedAppReleaseRPM,
 'vmIframeUrl' : vmIframeUrl,
 'ilolink' : ilolink,
}

for key,value in keyword_dict.iteritems():     
  print key, value 

#### Groups #############################################
## find custom WK groups
GRP_LIST = [g['name'] for g in client.systemgroup.listAllGroups(session) if g['name'].startswith('wk_')]
DAY_LIST=['SA','SO','MO','DI','MI','DO','FR']
CUST_LIST=[]

# Automatic patching from TE start on a Friday 2 days after RPM Build DDAY and ends 11 days after build day. 
# Automatic patching from QA start on a Friday 16 days after RPM Build DDAY and ends 29 days after build day. 
# Automatic patching from PX start on a Friday 30 days after RPM Build DDAY and ends 37 days after build day. 
DAY_DIC={'SA':1,'SO':2,'MO':3,'DI':4,'MI':5,'DO':6,'FR':0}

for GRP in GRP_LIST: 
 for DAY in DAY_LIST:
  if DAY in GRP:
    print (DAY,GRP) 
    G=GRP.split('_')[0:5]
    G='_'.join(G)
    if G not in CUST_LIST: 
      CUST_LIST.append(G) 
    print(G) 

CUST_LIST

for WK in CUST_LIST:
 if 'px' in WK:
  DDAY=30
 if 'qa' in WK: 
  DDAY=16
 if 'te' in WK: 
  DDAY=2
 for k,v in DAY_DIC.iteritems():
    if k in WK:
       UT=WK.split('_')[4]
       HR=UT[0:2]
       MIN=UT[2:4]
       UD=v+DDAY
       print(WK,k,v,DDAY,UD,UT,MIN,HR) 




for WK in CUST_LIST:
  if 'px' in WK:
    print(WK)
  MD=20
  MT='00 13'
  ## still need to convert the DAY "MO, SO,.." into the crontab date. day of month in crontab form 33 days after dday.
  UD=32
  UUD=get_date(cron_format_day,int(UD))
  MUD=get_date(output_format,int(UD))
  UT=WK.split('_')[4]
  HR=UT[0:2]
  MIN=UT[2:4]
  CUT=(MIN+' '+HR)
  RT=int(HR)+1
  RT=(MIN+' '+str(RT))
  print(MT,MD,CUT,HR,MIN,RT)
  CHANGE="chg"
  print >> CRON_FILE, ('%s %s * root /opt/rh-soe/bin/ci_info_mail-group.sh %s "%s:%s Uhr" "%s" %s' % (MT, MD, WK, HR, MIN, CUT, CHANGE ))
  print >> CRON_FILE, ('%s %s * root /opt/rh-soe/bin/ci_update-group.sh %s ' % (CUT, MD, WK))

  else:
    pass 
    # print "false"

## rhof case funktions

client.systemgroup.create(session, GRP, GRP)
client.systemgroup.delete(session, GRP)

## list all groups
client.systemgroup.listAllGroups(session)

## get the hosts in a group
client.systemgroup.listActiveSystemsInGroup(session, GRP)

## add a host to a group, remove with False
GRP='ds_temp' 
client.systemgroup.addOrRemoveSystems(session, WK, ID, True)
H=[1000026029, 1000019603, 1000019061]

## add the host to group 
for ID in H: client.systemgroup.addOrRemoveSystems(session, GRP, ID, True)
for ID in H:
 try:
   print ID
   client.systemgroup.addOrRemoveSystems(session, GRP, ID, True)
 except:
   print (str(ID)+' not in group: '+GRP)

## remove the host
for ID in H: client.systemgroup.addOrRemoveSystems(session, GRP, ID, False)
for ID in H:
 try: 
   client.systemgroup.addOrRemoveSystems(session, GRP, ID, False) 
 except:
   print (str(ID)+' not in group: '+GRP)
 
client.systemgroup.create(session, GRP, GRP)
client.systemgroup.delete(session, GRP)

GR=[g['name'] for g in client.systemgroup.listAllGroups(session) if g['name'].startswith('Service')]  
pp.pprint(GR)

## add system(s) to a group
GR='tmp_release-27'
H=[1000019095, 1000019584, 1000024862, 1000013099, 1000019440, 1000018641, 1000016730, 1000010140]
H=[1000010141,1000018038,1000017458,1000019263,1000026589,1000022922,1000022784,1000022782,1000022785,1000022783]
# for ID in H: myRHOF.client.systemgroup.addOrRemoveSystems(myRHOF.session, GR, ID, True)

myRHOF.getAllSystemsFromGroup(GR)   

LIST=[]
GR=[g['name'] for g in client.systemgroup.listAllGroups(session) if g['name'].startswith('WK3.1')]
GRP='WK3.1-all'  
for G in GR:
  H=myRHOF.getAllSystemsFromGroup(G)
  I = H
  for ID in I: 
     myRHOF.client.systemgroup.addOrRemoveSystems(myRHOF.session, GRP, ID, True)
  LIST.append(myRHOF.getAllSystemsFromGroup(G))

## notfall list
DIC={}
GS=[g['name'] for g in client.systemgroup.listAllGroups(session) if g['name'].startswith('Tranche Notfall')]
for G in GRS:
  DIC[G]=client.systemgroup.listActiveSystemsInGroup(session, G)

for GR,IDS in DIC.iteritems():              
  LIST=[]
  for ID in IDS:               
    LIST.append(client.system.getName(session,ID['id'])['name']) 
  DIC[GR]=LIST

           
## tips
#######
# cmd 
import sys
import commands
import os

def list(dir):
  cmd = 'ls -l ' + dir
  print 'about to do this: ', cmd
  # return 
  (status, output) = commands.getstatusoutput(cmd) 
  if status: 
    print sys.stderr 'there was an error:', output
    sys.exit(1)
  print output	
	
# list dir
def LIST(dir):
  files = os.listdir(dir)
  print files,
    for file in files: 
	  

### read each line in file into a list 
L=[]
with open ('tmp') as f:
  content = f.readlines()
  for line in content:
    L.append(line.split('\n')[0])

### get the ID in Satellite from the list L
H=[]
for i in L: 
  NAME = (i+'.corp.int') 
  H.append(client.system.getId(session,NAME)[0].get('id')) 




D={}
with open ('/tmp/tmp.wk') as f: 
  content = f.readlines()                                                                                             
  for line in content:                                                                                                
     ID=line.split('\n')[0].split(' ')[0]                                                                              
     URL=line.split('\n')[0].split(' ')[2]
     D[ID]=URL

for ID,URL in D.iteritems():     
  ID=int(ID)
  U={'URL': URL}
  client.system.setCustomValues(session,ID,U)


###  check two items in an if 
if "noday" not in DD and "td" in DD :
  print DD 


####################################################
## sort a crontab based on month, day, hour and min. 
from operator import itemgetter, attrgetter, methodcaller

L=[]
with open('/tmp/ci_update-wk-app-groups') as f:
  content = f.readlines() 
  for line in content: 
    if '###' not in line: 
      L.append(line.split(' '))


CONTENT=sorted(L, key=itemgetter(3,2,1,0))
sorted(L, key=itemgetter(3,2,1,0), reverse=True) 

LOG = open("/tmp/log", "w+")

## 2nd method 
for D in range(35): 
  print D 
with open('/tmp/ci_update-wk-app-groups') as f:
  content = f.readlines()
  for line in content:


####################################################


      line.split(' ')[:4]  # returns the min,hr,day,month 
      line.split(' ')[4:]  # returns everything after that

## sort the L list based on the 4th colum
sorted(L, key=lambda year: year[3]) 


pp.pprint(sorted(content))  



with open(fname) as f:
    content = f.readlines()


 
#########################################################
	## set a funktion to history in python  

def hi():
 import readline
 for i in range(readline.get_current_history_length()):
  print readline.get_history_item(i)

# call it so 
hi()
	 
	#####
	## ConfigParser 
	import ConfigParser
	parser = ConfigParser.ConfigParser()


	##################################################################
	from ConfigParser import SafeConfigParser
	parser = SafeConfigParser()
	parser.read('/etc/sysconfig/rhof')

	## get all the appl types in the config file
	for section_name in parser.sections():
	 if 'continuous_integration_apps' in section_name: 
	    print 'Section:', section_name
	    # print '  Options:', parser.options(section_name)
	    for name, value in parser.items(section_name):
		# print '  %s = %s' % (name, value)
		print '  %s ' % (name)
	    print



	parser = SafeConfigParser()
	parser.read('rhof-tmp')                              

	U_FILE=['/usr/local/bin/update.config.sh']

	for name, value in parser.items('continuous_integration_base_release_versions'): 
	 # print(name,value)  
	 ## get the config channel out of the name
	 APP=name.split('.')[0]
	 STAGE='px'
	 RH=name.split('.')[1].split('-')[-1]
	 # print(APP,STAGE,RH) 
	 CHAN='cfg-'+APP+'-'+STAGE+'-rhel-server-'+RH
	 print(CHAN) 
	 # check for 32 bit version 
	 if 'i386' in name: 
	  TAG='\nrelrpmversion32='
	  # print name,TAG
	 try: 
	   INFO = client.configchannel.lookupFileInfo(session, CHAN, U_FILE)
	   CONTENT=INFO[0].get('contents')
	   for i in CONTENT.split('\n'):
	     if 'relrpmversion' in i:
	       if '#relrpmversion' not in i: 
		 # print(i) 
		 NEW_VERSION=i.split('=')[1]
		 print (CHAN, NEW_VERSION)  
	 except: 
	   print ('ERR - '+CHAN) 


	## 1st try
	for section_name in parser.sections():                  
	  for name, value in parser.items(section_name):                
	    print(section_name,name,value)                       





	##################################################################
	def ConfigSectionMap(section):
	  dict1 = {}
	  dict(Config.items('Section'))
	  options = Config.options(section)
	  for option in options:
	    try:
	      dict1[option] = Config.get(section, option)
	      if dict1[option] == -1:
		DebugPrint("skip: %s" % option)
	    except:
	      print("exception on %s!" % option)
	      dict1[option] = None
	    return dict1


	Config = ConfigParser.ConfigParser()
	Config.read("/etc/harvest.conf")
	print ConfigSectionMap("files").values()


	parser.read('rhof')  # open the file read
	parser.sections()   # list the sections of the file
	parser.items('vsphere')   # get the key and value out of section
	parser.options('vsphere') # get the key from the section 
	parser.get('vsphere', 'vsphere_host')     # get the value for that key             

	parser.read('rhof')
	parser.sections()
	parser.items('vsphere')
	parser.options('vsphere')
	parser.get('vsphere', 'vsphere_host') 
	parser.read('test') 
	parser.add_section('test_section') 
	parser.section()
	parser.config.write('test')
	parser.write()
	fh=open('test', 'r+') 
	fh=open('test', 'w+') 
	parser.read(fh) 
	parser.add_section('test_section') 
	parser.write(fh) 
	parser.read(fh) 
	parser['test_section']['user'] = 'dstock'
	parser.set('test_section', 'user', 'dstock') 
	parser.write(fh) 
	parser.read(fh) 
	parser.get('test_section', 'user')
	parser.set('test_section', 'user', 'danny') 
	parser.get('test_section', 'user')
	parser.write(fh) 

	[continuous_integration_base_release_versions]
	[continuous_integration_apps]

	#####
	## os module
	import os
	os.chdir('/export/home/dstock/tmp/')
	os.listdir('/export/home/dstock/tmp/')

	##### 
	## regex - regular expressions re search funk
	##
	pattern = """
	^                   # beginning of string
	M{0,4}              # thousands - 0 to 4 M's
	(CM|CD|D?C{0,3})     # hundreds - 900 (CM), 400 (CD), 0-300 (0 to 3 C's),
			    #            or 500-800 (D, followed by 0 to 3 C's)
	(XC|XL|L?X{0,3})    # tens - 90 (XC), 40 (XL), 0-30 (0 to 3 X's),
			    #        or 50-80 (L, followed by 0 to 3 X's)
	(IX|IV|V?I{0,3})    # ones - 9 (IX), 4 (IV), 0-3 (0 to 3 I's),
			    #        or 5-8 (V, followed by 0 to 3 I's)
	$                   # end of string
	"""
	##

	##

	import re
	def FIND(pat, text): 
	  match = re.search(pat, text, re.IGNORECASE)
	  if match: print match.group()
	  else: print "not found"
	  
	# call it  
	FIND('iig', 'piiig', re.IGNORECASE)  
	:kitten123
	>>> FIND(r':\w+', 'blah blah :kitten123kkk& balll blah')  
	>>> FIND(r':.+', 'blah blah :kitten123kkk& balll blah')  

	. any char
	\w word char
	\d digit
	\s whitespace 
	\S none whitespace 
	+ one or more
	* zero or more  

	########################################################
	# start of sat section 
	########################################################
	import sys
	sys.path.append('/opt/rhof/lib')
	sys.path.append('/opt/rh-soe/lib')
	from rhof import RHOF
	myRHOF=RHOF()

	## pprint
	import pprint 
	pp = pprint.PrettyPrinter(indent=2)

	## Tips RHOF
	# connection
	import xmlrpclib
	ser er = "http://SERVER/rpc/api"
	client = xmlrpclib.Server(server, verbose=0)
	session = client.auth.login(user, key)

	sys.path.append('/opt/rhof/lib')
	from rhof import RHOF
	myrhof = RHOF()
	myrhof.client
	myrhof.session


	# examples
	## get a list of user on Sat.
	U = client.user.list_users(session)   

	## get a list of all CIF, cif labels
	CIF_LABEL=[c['label'] for c in client.system.custominfo.listAllKeys(session)]      
	GET_CIFS=client.system.getCustomValues(session,ID)

	## get channel info
	# list which config channels a system is in. 
	client.system.config.listChannels(session,ID)
	CHS=['cfg-bigdata-ada-diba-rhel-server-6']
	# 1 = on top, 0 = bottom of list
	client.system.config.addChannels(session,ID,CHS,1) 

	for ID in H:
	  client.system.config.addChannels(session,ID,CHS,1)

	for ID in H:
	  client.system.config.listChannels(session,ID)

	BASE_CH=client.system.getSubscribedBaseChannel(session, ID)['name'] 
	SW_CH=client.channel.software.listSystemChannels(session,ID)['name']

	C_CH=client.configchannel.listGlobals(session)  

	## getRegistrationDate
	client.system.getRegistrationDate(session,ID)

	## change all the esx channels to latest. 
	## lists 
	li = [ int(i) for i in ls ]
	# is the same as only better
	li=[]
	for i in ls: 
	  li.append(int(i))  


	CH=client.channel.listAllChannels(session)
	LIST=[]
	for C in CH: 
	  if 'diba-esx' in C['label']:
	    LIST.append(C['label'])

	DICT={}
	for i in LIST: 
	  print(i) 
	  L=[]
	  for H in client.channel.software.listSubscribedSystems(session, i):
	    L.append(H['id'])
	  DICT[i]=L 

	for key,value in DICT.iteritems():     
	  if len(value) > 0: 
	    print (key, len(value)) 
	    print value

	## get the contents of the local config file ldap_profiles
	FILES=client.system.config.listFiles(session, 1000019603, 1) 
	for F in FILES: 
	  if 'ldap_profiles' in F['path']:
	    print(F['path'])

	FILE=client.system.config.lookupFileInfo(session, 1000019603, ['/etc/ldap_profile'], 1)
	for F in FILE: 
	  print F['contents']

	DICT={}
	SYS = [x['id'] for x in LIST]
	for S in SYS1: 
	  FILES=client.system.config.listFiles(session, S, 1)
	  for F in FILES:
	      # print(F['path'])
	      if 'ldap_profiles' in F['path']:
		 FILE=client.system.config.lookupFileInfo(session, S, ['/etc/ldap_profile'], 1)
		 CONT=[x['contents'] for x in FILE] 
		 print(S, CONT) 

	for S in SYS: 
	  try:
	    FILE=client.system.config.lookupFileInfo(session, ID, ['/etc/ldap_profile'], 1)
	    CONT=[x['contents'] for x in FILE]
	  except:
	    CONT='nn'
	  DICT[S] = CONT


	## set the cif values
	ID=1000025842
	E={'systemowner_email': 'SP_ITIBigDataOperations@ing-diba.int'} 
	C={'Contact': 'Tech-Christian Gebhardt 22150, Fach-Rainer Lindner 22798'}
	client.system.getCustomValues(session,ID)

	client.system.getName(session,ID)
	client.system.getName(session,ID).get('name')
	client.system.getId(session,NAME)[0].get('id') 

	client.system.setCustomValues(session,ID,C)
	client.system.setCustomValues(session,ID,E)
	 
	## HOSTNAME, get hostname, 
	with open('/ConfigData/tmp/bigdata-te.list') as f:  
	    H = f.read().splitlines()  

	for i in H: 
	  NAME=(i+'.corp.int')
	  LIST.append(client.system.getId(session,NAME)[0].get('id')) 

	### 

	HL=[]
	for NAME in H: 
	  ID=client.system.getId(session,NAME)[0].get('id')                                                 
	  HL.append(ID) 

	## more than one at a time 
	H=[1000024022, 1000024385, 1000024222, 1000024402, 1000024223, 1000024225, 1000024224, 1000024227]
	for ID in H: client.system.getName(session,ID)  
	for ID in H: client.system.getCustomValues(session,ID)
	for ID in H: client.system.setCustomValues(session,ID,C)
	for ID in H: client.system.setCustomValues(session,ID,E)
	for ID in H: client.system.setCustomValues(session,ID,W)
	for ID in H: client.system.setCustomValues(session,ID,T)

	## add wartungsklassen
	for ID,VALUE in DIC.iteritems(): 
	   client.system.getName(session,ID)
	   WK={'Wartung': VALUE}
	   client.system.setCustomValues(session,ID,WK)  
	   client.system.getCustomValues(session,ID)


	## get a list of systems in Sat. 
	all_systems = client.system.listActiveSystems(session)
	pp.pprint(all_systems)
	 
	GROUPS = client.system.listGroups(session,ID)
	for GROUP in GROUPS:
	  if int(GROUP['subscribed']) == 1:
	    if GROUP.get('system_group_name').startswith('Anwendung'):
	      ANWENDUNG = GROUP.get('system_group_name').replace('Anwendung ','' )

	def urlencode(text):
	  text = text.replace('%','%25')
	  text = text.replace(' ','%20')
	  text = text.replace('!','%21')
	  text = text.replace('"','%26')
	  text = text.replace('#','%23')
	  text = text.replace('$','%24')
	  text = text.replace('&','%26')
	  return(text) 

	## system info 
	def SYS_INFO():
	  HOST = sys.argv[1]
	  HOST = HOST+('.corp.int')
	  L=client.system.getId(session, HOST)
	  ID=L[0].get('id')
	  if ID:
	    client.system.listNotes(session, ID)
	    client.system.getMemory(session, ID)
	    client.system.getNetwork(session, ID)
	    client.system.getNetworkDevices(session, ID)
	    client.system.getRelevantErrata(session, ID)
	    client.system.getRunningKernel(session, ID)

	    PKGS=client.system.listPackages(session, ID)  # list of all packages for host
	    PKG=[g['name'] for g in PKGS] 
	    RELEASE=[g['name'] for g in PKGS if g['name'].startswith('diba-release-')]
	  else: 
	    ID=client.system.searchByName(session, sys.argv[1]) 
	    print ID 

	## remove old Packages from sat. 
	# get all files with noversion in the channels 
	P=client.channel.software.listAllPackages(session, 'diba-appl-te-rhel-x86_64-server-6')

	## get the subscriped channels. 

	################################################
	## end of sat section
	###############################################
	## Strings
	'Hello ' + str(6) 
	a = 'Hello' 
	a[1] 
	a[0:]
	a[:0]
	a[0:4]
	a[:-1]

	len[a]

	## input output
	user_input = raw_input (" Type something : ")
	import sys
	print sys.argv(1)

	## simple cat 
	FILE = open("/tmp/file", "r")
	for LINE in FILE:
	  print LINE

	## print to LOG
	LOG = open("/tmp/log", "w+") 
	print >> LOG, client.system.getId(session, HOST)

	## Lists

	## Funktions

	## Modules

	# if statements
	x = int(raw_input("Please enter an integer: "))
	Please enter an integer: 42
	if x < 0:
	      x = 0
	      print 'Negative changed to zero'
	 elif x == 0:
	      print 'Zero'
	 elif x == 1:
	      print 'Single'
	 else:
	      print 'More'
	...
	More

	# for statements
	words = ['cat', 'window', 'defenestrate']
	for w in words:
	     print w, len(w)
	...
	cat 3
	window 6
	defenestrate 12

	# range() Function 
	range(5, 10)
	[5, 6, 7, 8, 9]

	## range() and len()
	a = ['Mary', 'had', 'a', 'little', 'lamb']
	for i in range(len(a)):
	     print i, a[i]
	...
	0 Mary
	1 had
	2 a
	3 little
	4 lamb

	# break statement
	for n in range(2, 10):
	     for x in range(2, n):
		 if n % x == 0:
		     print n, 'equals', x, '*', n/x
		     break
	     else:
		 # loop fell through without finding a factor
		 print n, 'is a prime number'
	...
	2 is a prime number
	3 is a prime number
	4 equals 2 * 2
	5 is a prime number
	6 equals 2 * 3
	7 is a prime number
	8 equals 2 * 4
	9 equals 3 * 3

	# continue statement 
	for num in range(2, 10):
	     if num % 2 == 0:
		 print "Found an even number", num
		 continue
	     print "Found a number", num
	...
	Found an even number 2
	Found a number 3
	Found an even number 4
	Found a number 5
	Found an even number 6
	Found a number 7
	Found an even number 8
	Found a number 9

	# pass statement
	while True:
	     pass  # Busy-wait for keyboard interrupt (Ctrl+C)
	...
	(Ctrl+C)

	# mapping combines to list into a dictionary
	systems=['SYSTEM']
	ids=[1000030208,1000029235,1000030003,1000010185]
	DIC=dict(zip(systems,ids))

	def cheeseshop(kind, *arguments, **keywords):
	    print "-- Do you have any", kind, "?"
	    print "-- I'm sorry, we're all out of", kind
	    for arg in arguments:
		print arg
	    print "-" * 40
	    keys = sorted(keywords.keys())
	    for kw in keys:
		print kw, ":", keywords[kw]

			
	## Differt data (object) types

	str
	A = 'test'
	B = '1'
	# work with
	len(A)
	A[1]

	int
	B = 1

	float
	C = 1.1 

	bool 
	D = True

	NoneType
	F = None

	## Hight Levels of data types 
	list
	A = [1, 2, 3]
	B = ['John', 'Paul', 'Goerge', 'Ringo']
	C = [1, 3.14159, 'Hello World', ['a', 'b', 'list'], VARIABLE]

	## split a list on empty space
	H="host1 host2 host3"                                                                                       
	import re
	re.split('\s+', H)                                                                                                  
	['host1', 'host2', 'host3']

	# find items in a list

	A = [1, 2, 3, 4]
	A[1] 
	A[1:4]
	A[::2]

	# working with lists
	A.append(19)
	A.insert(0,17)
	A.sort()
	A.pop()
	A.pop(1)
	len(a)

	## tuple are emutable 
	tuple 
	T = (1, 2)   
	T = ()
	T =  (1, 3.14159, 'Hello World', ['a', 'b', 'list'], VARIABLE)
	T = 'this is', ' a tuple' 
	T = ('this is', ' a tuple' )

	## Dictionnaries
	dicts
	D = {}
	D = {1:10, 2:20, 'two':2, 2.1:2, }

	# Methods for dicts
	D.keys()
	D.values()
	D.items()
	D.has_key(key)
	D.get(key)
	D.get(key,d)

	D       
	{1: 10, 2: 20, 2.1000000000000001: 2, 'two': 2}
	>>> D.get('two')
	2

	## Assignment 
	A = "this is a string"
	A = 1.1
	A = 1 

	# augmented assignment
	A += 1 			# add 1 
	A -= 2			# minus 2
	A *= 3			# multipy by 3
	A |= 			# Or logical 
	A &= 			# And logical

	id()  			# shows the id number of an object 
	# Assign to a tuple

	# Equals
	# unassign 
	del A

	## Expressions
	A = 2 + 2
	B = var1 * var2 
	3*"Spam " 
	{2:2**10, 3:pow(3,10)}

	## Comparisons
	2 in [2, 3, 4]		is True
	2 in [(2, 3), 4]	is False
	5 in [2, 3, 4]		is False
	(2,3) in [(2, 3), 4] is True
	2,3 in [(2, 3), 4]	is (2, False)

	<, <=, >, >=, ==, != 
	in, not in, is, is not

	## range
	range(4)		# 0 to n 
	range(2,9)		# start, stop
	range(2,9,2) 		# start, stop, step 

	### built in funktions 
	upper()				# change to upper case
	lower()				# change to lower case
	abs(x)				# Absolute value
	any(list)			# True if any in list are true
	all(list)			# True if all in list are true
	max(list)			# maximal in list
	min(list)			# minimal in list
	open(file,mode)		# open file with mode
	pow(x,y) 			# computes x**y
	raw_input(prompt)	# get input from stdin
	round(x,n) 			# round x to n decimal places
	sorted(list) 		# sort the objects in list
	zip(list1, list2) 	# build a new list with items from each list

	### Standard Modules
	math			# math
	os.path			# os path
	sys				# system hardware 
	glob			# file name searching
	re				# regular expressions
	pickle			# convert Python objects to strings for convenient storage
	time			# access to time of day and CPU clocks
	datetime		# time compulations
	email			# e-mail and attachment creation 
	pdb				# debugger
	subprocess		# create blocking and async subprocesses
	pydoc			# generate module documentation
	timeit			# compute CPU use for a code snippet

	import timeit
	init = 'temp1 = list(range(100)); temp2 = [i * 2 for i in range(50)]'
	print timeit.timeit('list(set(temp1) - set(temp2))', init, number = 100000)
	print timeit.timeit('s = set(temp2);[x for x in temp1 if x not in s]', init, number = 100000)
	print timeit.timeit('[item for item in temp1 if item not in temp2]', init, number = 100000)


	## date 
	import time
	DATE=(time.strftime("%d/%m/%Y"))
	TIME=(time.strftime("%H:%M:%S"))
	DATE=time.strftime("%x")

	import datetime
	DATE=datetime.datetime.now()
	DATE=datetime.datetime.now().isoformat()
	DAY=DATE.day
	YEAR=DATE.year

	from datetime import datetime
	DATE=datetime.now()
	print DATE.strftime('%Y/%m/%d %H:%M:%S')
	print str(DATE)

	## regulare expressions 
	. (dot) any char
	\w word char
	\d digit
	\s whitespace
	\S non whitespace 
	+   1 or more
	*   0 or more

	#########
	## if statements
	if A > 0: 
	  print "positive"
	  b = 'positive' 

	print 'Test done'

	if A > 0: 
	  print 'positive'
	elif A < 0: 
	  print 'negative' 
	elif A == 0 
	  print 'zero'
	else: 
	  print 'something strange'  
	  
	>>> a if True else b
	a
	>>> a if False else b
	b

	>>> False and a or b
	b
	>>> True and a or b
	a

	  
	## While statement
	T = 0
	while T < 10: 
	  T += 1
	  print T
	 
	 
	## break, continue and pass
	T = 0
	while T < 10: 
	  T += 1
	  if T == 2 or T == 3: continue 
	  print T
	  
	T = 0
	while T < 10: 
	  T += 1
	  if T == 5: break  
	  print T
	print 'loop done'

	T = 0
	while T < 10: 
	  T += 1
	  if T == 20: pass  
	  print T
	print 'loop done'

	## looping: else statement
	T = 0 
	S = 8 
	while T < S: 
	  T += 1
	  if T == 10: break
	  print T
	else: 
	  print "S is < 10" 
	  
	## loops for a range

	## loops for a dicts


	True
	False 
	  
	## compute a n factorial  
	N = 5
	prod = N
	while N > 1: 
	  N -= 1
	  prod *= N

	N = 5
	prod = 1
	for i in range(2,N+1): 
	  prod *= i 

	  ###################################################################################################################################
	  
	### html 
	import urllib2 

	from HTMLParser import HTMLParser  

	class MyHTMLParser(HTMLParser):
	  def __init__(self):
	    H.TMLParser.__init__(self)

	recording = 0 
	data = []

	def handle_starttag(self, tag, attrs):
	  if tag == 'required_tag':
	    for name, value in attrs:
	      if name == 'somename' and value == 'somevale':
		print name, value
		print "Encountered the beginning of a %s tag" % tag 
		recording = 1 


	def handle_endtag(self, tag):
	  if tag == 'required_tag':
	    recording -=1 
	    print "Encountered the end of a %s tag" % tag 

	def handle_data(self, data):
	  if recording:
	    data.append(data)

	p = MyHTMLParser()
	f = urllib2.urlopen('http://www.someurl.com')
	html = f.read()
	p.feed(html)
	print p.data
	p.close()




	from HTMLParser import HTMLParser

	class MyHTMLParser(HTMLParser):
	    def handle_starttag(self, tag, attrs):
		print "Encountered a start tag:", tag
	    def handle_endtag(self, tag):
		print "Encountered an end tag :", tag
	    def handle_data(self, data):
		print "Encountered some data  :", data

	parser = MyHTMLParser()


	from HTMLParser import HTMLParser
	from htmlentitydefs import name2codepoint

	class MyHTMLParser(HTMLParser):
	    def handle_starttag(self, tag, attrs):
		print "Start tag:", tag
		for attr in attrs:
		    print "     attr:", attr
	    def handle_endtag(self, tag):
		print "End tag  :", tag
	    def handle_data(self, data):
		print "Data     :", data
	    def handle_comment(self, data):
		print "Comment  :", data
	    def handle_entityref(self, name):
		c = unichr(name2codepoint[name])
		print "Named ent:", c
	    def handle_charref(self, name):
		if name.startswith('x'):
		    c = unichr(int(name[1:], 16))
		else:
		    c = unichr(int(name))
		print "Num ent  :", c
	    def handle_decl(self, data):
		print "Decl     :", data

	parser = MyHTMLParser()



	### xml 
	from xml.etree import ElementTree as ET
	import xml.etree.ElementTree as ET


	with open('test.html', 'r') as content_file:
	    content = content_file.read()
	  
	with open('cacti-release.org', 'r') as content_file:
	  s=content_file.read()

	table = ET.XML(s)
	rows = iter(table)
	headers = [col.text for col in next(rows)]
	for row in rows:
	    values = [col.text for col in row]
		print dict(zip(headers, values))


	###################### File I/O
	### file handling 
	## stdin & stdout
	## close file
	## read from a file
	## write to a file
	## formating text 

	## open file
	F = open(filename, mode) 
	# modes can be 
	r   read
	w   write
	a   append 

	# once open you can use methods 
	close, flush, name, read, readline, seek, tell, write, writeline, ...

	# read the file contents and always close the file immediately after the block end
	with open('Path/to/file', 'r') as content_file:
	    content = content_file.read()

	## exmaples 
	FP = open("log.txt","a") 
	FP.write(msg) 
	FP.write("\n")
	FP.close()

	FP = open('file.txt', 'r') 
	for LINE in FP: 
	  print LINE[:-1]
	  
	## newline 
	.replace('\n', '').replace('\r', '')
	.rstrip('\r\n')
	  
	## Formatting values into strings 
	string = "This is my {0} test of {1}to{2}".format(1,2,3)
	string = "This is my %d test of %dto%s" %(1,2,3)			## this format die in 3.0

	str(1.1)
	repr(1.1)
	 
	## get newest file in dir
	import os
	logdir='/usr/src/redhat/RPMS/x86_64' # path to your log directory
	logfiles = sorted([ f for f in os.listdir(logdir) if f.startswith('diba-release-os-bigdata')])
	print "Most recent file = %s" % (logfiles[-1],)
	  

	for DIR in DIRS:               
	  logdir='/usr/src/redhat/RPMS/'+DIR 
	  logfiles = sorted([ f for f in os.listdir(logdir) if DATE in f])
	  print "Most recent file = %s" % (logfiles[-1],)

	 
	##################### Errors 
	## Syntax 
	For I in list: 

	##
	try:
	  <statement(s)>
	except Condtion1, errmsg: 

	except Condition2:
	  <statement(s)>
	else: 
	finally:  


	## traceback error message to error.log
	import traceback
	import datetime as dt
	def junk():
	  return 0/0

	def calljunk():
	   junk()

	try: 
	  calljunk()
	except ZeroDivisionError: 
	  FP = open('error.log','a')
	  FP.write('Error caught @ ' + str(dt.datetime.now()) + '\n\n')
	  traceback.print_exc(file=FP)
	  FP.close()

	# Strings:
	'Hello ' + str(6)
	a = 'Hello'
	a[1]
	a[0:]
	a[:0]
	a[0:4]
	a[:-1]

	len[a]


	# for statements
	words = ['cat', 'window', 'defenestrate']
	for w in words:
	     print w, len(w)
	...
	cat 3
	window 6
	defenestrate 12


	#####################
	## Iterate through two lists with one FOR loop

	>>> a=[1,2,3]
	>>> b=['a','b','c']
	>>> for (x,y) in map(None,a,b):
	... print x,y
	...
	1 a
	2 b
	3 c


##############################################
## working with numbers

print "I will now count my chickens:"

print "Hens", 25 + 30 / 6
print "Roosters", 100 - 25 * 3 % 4

print "Now I will count the eggs:"

print 3 + 2 + 1 - 5 + 4 % 2 - 1 / 4 + 6 

print "Is it true that 3 + 2 < 5 - 7?"
print 3 + 2 < 5 - 7

print "What is 3 + 2?", 3 + 2
print "What is 5 -7?", 5 - 7

print "Oh, that's why it's False." 

print "How about some more" 

print "Is it greater?", 5 > -2 
print "Is it greater or equal?", 5 >= -2 
print "Is it less or equal?", 5 <= -2

#!/usr/bin/env python

########################################################
# imports 
########################################################
## create system doc in confluence
import sys, os, urllib2, xmlrpclib
from urllib2 import URLError, HTTPError
import pprint
pp = pprint.PrettyPrinter(indent=2)

sys.path.append('/opt/rh-soe/lib')
from confluence import confluence 
from confluence import confluenceOptionParser
from soe import RHOF
from soe import rhofOptionParser

cf_user = 'svcvcsconflup' 
cf_namespace = 'ITIServerSystems' 
cf_namespace = '~dstock' 

## get a page and change content
musterpage=server.confluence2.getPage(token, cf_namespace, 'Musterseite')
musterpage=musterpage.get('content').replace('cfkw_id', '1000010849')

## remove the page
download=server.confluence2.getPage(token, cf_namespace, page)
ID=download['id']
server.confluence2.removePage(token, ID)

##################################
cfkw_id
cfkw_systemname
cfkw_ip
cfkw_installdate
cfkw_anwendung
cfkw_appl
cfkw_stage
cfkw_klasse
cfkw_systemowner_email
cfkw_applreleaserpmdd-machine-attachment-to-wiki.py


id
systemname
ip
installdate
anwendung
appl
stage
klasse
systemowner
applreleaserpm


####### getting connected
import ConfigParser
from optparse import OptionParser
parser = ConfigParser.SafeConfigParser()
parser.readfp(open("/etc/confluence_api", "r"))
cf_user = parser.get("confluence", "cf_user")
cf_password = parser.get("confluence", "cf_password")
cf_namespace = parser.get("confluence", "cf_namespace")
cf_server = "confluence"

cf_Url = "https://%s/rpc/xmlrpc" % cf_server
server = xmlrpclib.ServerProxy(cf_Url)
token = server.confluence1.login(cf_user,cf_password)

cf_server = "confluence"
cf_user = "svcvcsconflup" 
cf_namespace = "ITIServerSystems"
cf_personalspace = "dstock"
cf_kwprefix = "cfkw_"
cf_comment_start = "{HTMLcomment:hidden}"
cf_comment_end = "{HTMLcomment}"

cf_Url = "https://%s/rpc/xmlrpc" % cf_server
server = xmlrpclib.ServerProxy(cf_Url)    
token = server.confluence1.login(cf_user,cf_password)
token2 = server.confluence2.login(cf_user,cf_password)

####### geting info
spaces=server.confluence2.getSpaces(token)   

  { 'key': 'ITIServerSystems',
    'name': 'ITI Server Systems',
    'type': 'global',
    'url': 'https://confluence/display/ITIServerSystems'},


  { 'key': '~dstock',
    'name': 'Daniel Stock',
    'type': 'personal',
    'url': 'https://confluence/display/~dstock'},


page='release-2014_05'
key='ITIServerSystems'
server.confluence2.getPage(token, key, page)    

pageid=server.confluence2.getPage(token, cf_namespace, page)['id']
#### confluence add a page 
cf_server.confluence2.storePage(authToken, page)
cf_server.confluence2.logout(authToken)

#### add a comment
comment='this is a comment by xmlrpc via python'      
newComment=dict()
newComment['pageId'] = pageid   
newComment['content'] = comment
server.confluence2.addComment(token, newComment) 



server.confluence1.login(cfLogin,cfPassword)
server.confluence1.getSpaces(token)
server.confluence1.getPage(token, spacekey, pagetitle)
server.confluence1.getDescendents(token, pageID)
server.confluence1.storePage(token, page);
erver.confluence2.getPage(token, key, page)
cf_server.confluence2.storePage(authToken, page)
cf_server.confluence2.storePage(authToken, page)
cf_server.confluence2.storePage(authToken, page)
_s_server.confluence1.storePage(token, page);
server.confluence1.storePage(token, page)
server.confluence1.addComment(token, newComment)
server.confluence1.addAttachment(token, page['id'], newAttachment, xmlrpclib.Binary(attachmentData))
server.confluence1.search(token, query, maxResults)

#### grep item in a file IDATA ###

def check():
  if HOST in open(IDATA).read():
    print "true"
  else:
    print "false"

check()

#### html convert html page to humman readable page by removing all the junk  
grep -P "s/<[^>]*>//gs"
sub./<[^>]*>//gs

#### change the case from upper to lower
HOST=HOST.lower()

#!/usr/bin/env python

########################################################
# imports 
########################################################
import sys, os, urllib2, xmlrpclib
from urllib2 import URLError, HTTPError
import pprint
pp = pprint.PrettyPrinter(indent=2)

sys.path.append('/opt/rh-soe/lib')
from confluence import confluence 
from confluence import confluenceOptionParser
from soe import RHOF
from soe import rhofOptionParser

cf_user = 'svcvcsconflup' 
cf_namespace = ITIServerSystems

####### getting connected
import ConfigParser
from optparse import OptionParser
parser = ConfigParser.SafeConfigParser()
parser.readfp(open("/etc/confluence_api", "r"))
cf_user = parser.get("confluence", "cf_user")
cf_password = parser.get("confluence", "cf_password")
cf_namespace = parser.get("confluence", "cf_namespace")
cf_server = "confluence"

cf_Url = "https://%s/rpc/xmlrpc" % cf_server
server = xmlrpclib.ServerProxy(cf_Url)
token = server.confluence1.login(cf_user,cf_password)

cf_server = "confluence"
cf_user = "svcvcsconflup" 
cf_namespace = "ITIServerSystems"
cf_personalspace = "dstock"
cf_kwprefix = "cfkw_"
cf_comment_start = "{HTMLcomment:hidden}"
cf_comment_end = "{HTMLcomment}"

cf_Url = "https://%s/rpc/xmlrpc" % cf_server
server = xmlrpclib.ServerProxy(cf_Url)    
token = server.confluence1.login(cf_user,cf_password)
token2 = server.confluence2.login(cf_user,cf_password)

####### geting info
spaces=server.confluence2.getSpaces(token)   

  { 'key': 'ITIServerSystems',
    'name': 'ITI Server Systems',
    'type': 'global',
    'url': 'https://confluence/display/ITIServerSystems'},




page='release-2014_05'
key='ITIServerSystems'
server.confluence2.getPage(token, key, page)    

pageid=server.confluence2.getPage(token, cf_namespace, page)['id']

## count items in a list add index with enumerate(list) . 
>>> a = ['a', 'b', 'c', 'd', 'e']
>>> for index, item in enumerate(a): print index, item
...
0 a
1 b
2 c
3 d
4 e
>>>

#### add a comment
comment='this is a comment by xmlrpc via python'      
newComment=dict()
newComment['pageId'] = pageid   
newComment['content'] = comment
server.confluence2.addComment(token, newComment) 



server.confluence1.login(cfLogin,cfPassword)
server.confluence1.getSpaces(token)
server.confluence1.getPage(token, spacekey, pagetitle)
server.confluence1.getDescendents(token, pageID)
server.confluence1.storePage(token, page);
server.confluence1.storePage(token, page);
server.confluence1.storePage(token, page)
server.confluence1.addComment(token, newComment)
server.confluence1.addAttachment(token, page['id'], newAttachment, xmlrpclib.Binary(attachmentData))
server.confluence1.search(token, query, maxResults)


###############
## tips to network 
import socket

s = socket.socket()         
host = socket.gethostname() 
port = 12345                
s.bind((host, port))        

s.listen(5)                 
while True:
   c, addr = s.accept()     
   print ('Got connection from', addr)
   c.send("Thank you for connecting".encode())
   c.close()


################
# examples
################
for i in $h; do echo \'$i\', ;done   # change format of list into python 



'''
def main(argv):
   inputfile = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
   except getopt.GetoptError:
      print 'test.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'test.py -i <inputfile> -o <outputfile>'
         sys.exit()
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg
   print 'Input file is ', inputfile
   print 'Output file is ', outputfile

if __name__ == "__main__":
   main(sys.argv[1:])

Removing WK Gruppe: wk_px_3_3_j2ee
Removing WK Gruppe: wk_px_2_1_j2ee
Removing WK Gruppe: wk_px_3_3
Removing WK Gruppe: wk_px_2_2_j2ee
Removing WK Gruppe: wk_px_3_1
Removing WK Gruppe: wk_px_3_1_j2ee
Removing WK Gruppe: wk_px_2_3_j2ee



####### openscap Scap 

client.system.scap.scheduleXccdfScan(session, 1000019603, '/home/dstock/openScap/ingdiba-xccdf.xml', '--profile APPL')

#!/usr/bin/python
client = xmlrpclib.Server('https://spacewalk.example.com/rpc/api')
key = client.auth.login('username', 'password')

client.system.scap.scheduleXccdfScan(key, 1000010001,
    '/usr/local/share/scap/usgcb-rhel5desktop-xccdf.xml',
    '--profile united_states_government_configuration_baseline')

client.system.scap.scheduleXccdfScan(session, ID, '/usr/share/xml/scap/ingdiba/ingdiba-xccdf.xml', '--profile APPL')
SCANS=client.system.scap.listXccdfScans(session,ID)      
LAST_SCAN=SCANS[0]['xid']:
RR=client.system.scap.getXccdfScanRuleResults(session,LAST_SCAN)      
pp.pprint(RR)

for CK in RR:            
  CK['result']                        
  CK['idref']
  CK['idents']

GRP='ds_3_0'
GRP="Anwendung OpenSCAP"

LIST=client.systemgroup.listActiveSystemsInGroup(session, GRP)
RESULTS=[]
for ID in LIST:
  JOBID=client.system.scap.scheduleXccdfScan(session, ID, '/usr/share/xml/scap/ingdiba/ingdiba-xccdf.xml', '--profile APPL')
  SCANS=client.system.scap.listXccdfScans(session,ID)
  LAST_SCAN=SCANS[0]['xid']
  RR=client.system.scap.getXccdfScanRuleResults(session,LAST_SCAN)
  for CK in RR:
    R=(ID,CK['result'],CK['idents'])
    RESULTS.append(R)  




### create the calander 
# create a html calendar
CAL_DICT={}
for MONTH in MONTH_LIST:
  print (MONTH)
  c = calendar.HTMLCalendar(calendar.MONDAY)
  for wk in calendar.monthcalendar(YEAR,MONTH):
    print (wk)
    for d in wk:
      for i in JOB_LIST:
        MM=i[0]
        DD=i[1]
        if DD == d and MM == MONTH:
          CAL_DICT.setdefault(DD,list()).append((i[2],i[3]))
  ## 
  ## html format
  C=c.formatmonth(YEAR,MONTH)
  C=C.replace('border="0"', 'border="1"')
  for WK in c.formatmonth(YEAR,MONTH).split('tr>'):
    print(WK+'tr>')
    for DD in WK.split('td>'):
      if "noday" not in DD and "td" in DD:
        DAY=re.search(r'\d+', DD)
        if DAY:
          print ('</td><td><p>'+DAY.group()+'</p>')                    
          if type(CAL_DICT.get(int(DAY.group(0)))) is list:
             for i in CAL_DICT.get(int(DAY.group(0))):
                # print (i) 
                str=" - "
                print ('<p>'+str.join(i)+'</p>')



#################################
## push one release rpm and the config file 

import logging
import re, os, sys, pprint
import time 
import commands
import xmlrpclib
import ConfigParser
import ntpath
import pprint
pp = pprint.PrettyPrinter(indent=2)
from optparse import OptionParser
parser = OptionParser()
parser = ConfigParser.SafeConfigParser()
parser.readfp(open("/etc/sysconfig/rhof", "r"))
SATELLITE_URL = 'http://SERVER.corp.int/rpc/api'
SATELLITE_LOGIN = parser.get("rhof", "rhns_user")
SATELLITE_PASSWORD = parser.get("rhof", "rhns_password")
client = xmlrpclib.Server(SATELLITE_URL, verbose=0)
session = client.auth.login(SATELLITE_LOGIN, SATELLITE_PASSWORD)
DIRS = os.listdir('/usr/src/redhat/RPMS/')
FILES=[]
U_FILE=['/usr/local/bin/update.config.sh']
EXCEPTIONS=['-none-']
DICT={}
VER_LIST=[]
RPM_LIST=[]
VER_LATEST=''
PAT1='diba-release-'
PAT2='-rhel-'
PAT3='-server-'
TAG='\nrelrpmversion='
OTAG='\n#relrpmversion='

FILE='/usr/src/redhat/RPMS/x86_64/diba-release-bigdata-rhel-x86_64-server-6-20150923.1338-1.x86_64.rpm'
OSFILE='/usr/src/redhat/RPMS/x86_64/diba-release-os-bigdata-rhel-x86_64-server-6-20150923.1336-1.x86_64.rpm'

PATH=ntpath.split(FILE)[0]   
PATH
file=ntpath.split(FILE)[1]
file
ARCH=re.split(PAT2, file)[1].split(PAT3)[0]
RHEL=re.split(PAT3, file)[1].split('-')[0]
VER=re.split(PAT3+RHEL+'-', file)[1].split('.'+ARCH)[0]
APP=re.split(PAT1, file)[1].split(PAT2)[0]
APP=APP.replace('os-','')
CHN='diba-'+APP+'-te-rhel-'+ARCH+'-server-'+RHEL
CONF_CHN = 'cfg-'+APP+'-te-rhel-server-'+RHEL
## push rpm to px sat
cmd = 'rhnpush --user='+SATELLITE_LOGIN+' --password='+SATELLITE_PASSWORD+' --server=http://SERVER/APP -c '+CHN+' '+FILE                 
commands.getstatusoutput(cmd)

cmd = 'rhnpush --user='+SATELLITE_LOGIN+' --password='+SATELLITE_PASSWORD+' --server=http://SERVER/APP -c '+CHN+' '+OSFILE                 
commands.getstatusoutput(cmd)

try:
  commands.getstatusoutput(cmd)
  print('INFO: rhnpush rpm package: '+FILE+' in Channel '+CHN)
except: 
  print('FAILED: rhnpush rpm package: '+FILE+' in Channel '+CHN) 


## config file
INFO = client.configchannel.lookupFileInfo(session, CONF_CHN, U_FILE)
INFO
CONTENT=INFO[0].get('contents').replace(TAG, TAG+VER+OTAG) 
NEWFILE={'contents': CONTENT,'contents_enc64': False, 'binary': False, 'owner': 'root','group': 'root','permissions': '700','macro-end-delimiter': '|}', 'macro-start-delimite
r': '{|', 'owner': 'root'}
NEWFILE={'contents': CONTENT,'contents_enc64': False, 'binary': False, 'owner': 'root','group': 'root','permissions': '700','macro-end-delimiter': '|}', 'macro-start-delimiter': '{|', 'owner': 'root'}
client.configchannel.createOrUpdatePath(session, CONF_CHN, '/usr/local/bin/update.config.sh', False, NEWFILE)




import subprocess
subprocess.call("exit 1", shell=True)
subprocess.call(["ls", "-l"])
subprocess.check_call(["ls", "-l"])

from subprocess import call
>>> filename = input("What file would you like to display?\n")
What file would you like to display?
non_existent; rm -rf / #
>>> call("cat " + filename, shell=True) # Uh-oh. This will end badly...

import shlex, subprocess
>>> command_line = raw_input()
/bin/vikings -input eggs.txt -output "spam spam.txt" -cmd "echo '$MONEY'"
>>> args = shlex.split(command_line)
>>> print args
['/bin/vikings', '-input', 'eggs.txt', '-output', 'spam spam.txt', '-cmd', "echo '$MONEY'"]
>>> p = subprocess.Popen(args) # Success!


import subprocess
p1 = subprocess.Popen("command1 -flags arguments")
p2 = subprocess.Popen("command2 -flags arguments")

import subprocess
import os
import time

files = <list of file names>
command = "/bin/touch"
processes = set()
max_processes = 5

for name in files:
    processes.add(subprocess.Popen([command, name]))
    if len(processes) >= max_processes:
        os.wait()
        processes.difference_update([p for p in processes if p.poll() is not None])


## get all a list of all config files: 

LIST=[]
for H in all_configchannels: 
  CH=H.get('label')
  all_files=client.configchannel.listFiles(session, CH)
  for file in all_files: 
    F=file.get('path')
    if F not in LIST:
      LIST.append(F) 


######################
## argument parser 
######################
import argparse
arg_parser = argparse.ArgumentParser()

arg_parser.add_argument('-s', '--system', help='enter the name of the system')
arg_parser.add_argument('-t', '--text', default='This is the default text', help='enter text or get the default')

args = arg_parser.parse_args()
system=args.system
text=args.text



################

import shlex
from subprocess import check_output
import csv


def run_hammer_csv_to_html(hammer_cmd):
  '''run a hammer command in csv and return its pased info in html
     Argument: hammer_cmd: The complete hammer command string
     Assumption: starts with "hammer --output csv"
  '''
  hammer_cmd_args = shlex.split(hammer_cmd)
  reader = csv.reader(check_output(hammer_cmd_args))
  rownum = 0
  for row in reader.split('\n'): 
    if rownum == 0:
      print row




def test(cmd): 
  C=(check_output(shlex.split(cmd)).split('\n'))
  reader = csv.reader(C) 
  rownum = 0 
  for row in reader: 
    if rownum == 0: 
      print row 





run_hammer_csv_to_html('hammer --output csv content-view version list --organization=INGDiBa')




 



  print(hammer_cmd_args)




def run_hammer_json(hammer_cmd):
    '''
    Run hammer and return its parsed json result
    Argument: hammer_cmd: The complete hammer command string
    Assumption: starts with "hammer --output json"
    '''
    hammer_cmd_args = shlex.split(hammer_cmd)
    return json.loads(check_output(hammer_cmd_args))
    return json.loads(check_output(hammer_cmd_args, ensure_ascii=False))

CONTENT = run_hammer_json('hammer --output json content-view version list --organization=INGDiBa')rgument: hammer_cmd: The complete hammer command string

PRE='Library'
CV='cv_rhel7 '

def get_version():
    CONTENT = run_hammer_json('hammer --output json content-view version list --organization=INGDiBa')
    global VER
    LIST=[]
    for i in CONTENT:
      if i['Name'].startswith(CV):
        if PRE in i['Lifecycle Environments']:
          V=i['Version']
    LIST.append(V)
    VER=max(LIST)
    return VER


LIST=[]
for i in CONTENT:
  if i['Name'].startswith('cv'):
    if i['Lifecycle Environments']: 
      # print(i)
      V=i['Version']
      L=i['Lifecycle Environments']
      LLIST=[]
      for e in i['Lifecycle Environments']:
        e=str(e)
        LLIST.append(e)
      N=i['Name']
      print(('Name: %s, ver: %s, Lifecycle: %s') % (N,V,LLIST)) 




      if N not in LIST:
        LIST.append(N) 

      L=unicode(L).encode('utf8')
      LLIST=[]
      for e in i['Lifecycle Environments']:
        LLIST.append(e)
    V=i['Version']
    LIB=i[1]
    print(i,V)



with open('./tmp.cfg') as f:
  content = f.readlines()
  for line in content:
    LINE=line.replace('\t',' ').replace('\n','')
    CFG=LINE.split(' ')[0]
    ID=LINE.split(' ')[1]
    print('hammer hostgroup set-parameter --name cfg_channels --value '+ CFG +' --hostgroup-id '+ID)



#######################################
## read the cifs from sat5 reports and convert to host-params in sat6


F='/ConfigData/data/satellite-patch-report.data'
cif_dict=dict()

with open (F) as f:
  content = f.readlines()

if H not in cif_dict:
  cif_dict[H]=dict()

def cmd(H,P,V):
  C=('/opt/diba-soe/bin/set-host-params.py -s '+H+' -p '+P+' -v "'+V+'"') 
  FP = open("/tmp/tmp-migration-script.sh","a")
  FP.write(C+'\n')
  FP.close()
  print(C) 

for line in content: 
  if '1-NAME' not in line:
    print(line) 
    H=line.split(':')[0].replace(' ','',1)
    stage=line.split(':')[5].replace(' ','',1)
    P,V=('h_stage',stage)
    cmd(H,P,V)
    appl=line.split(':')[6].replace(' ','',1)
    P,V=('h_application',appl)
    cmd(H,P,V)
    wartung=str(line.split(':')[7].replace(' ','',1)) 
    if wartung == '0': 
      WK='automatic'
    else: 
      WK='manual'
    P,V=('h_wartung',WK)
    cmd(H,P,V)
    tranch=str(line.split(':')[8].replace(' ','',1)) 
    if tranch == '0': 
      TR='fr_06'
    elif tranch == '1': 
      TR='sa_22'
    elif tranch == '2': 
      TR='so_02'
    elif tranch == '3': 
      TR='so_04'
    else: 
      TR=tranch
    P,V=('h_tranch',TR)
    cmd(H,P,V)
    anwendung=line.split(':')[9].replace(' ','',1)
    P,V=('h_anwendugn',anwendung)
    cmd(H,P,V)
    email=line.split(':')[11].replace(' ','',1)
    P,V=('h_email',email)
    cmd(H,P,V)
    contact=line.split(':')[12].replace(' ','',1)
    P,V=('h_contact',contact)
    cmd(H,P,V)
    ldap=line.split(':')[18].replace('\n','').replace(' ','',1)
    P,V=('h_ldap',ldap)
    cmd(H,P,V)
    kernal=line.split(':')[2].replace(' ','',1)
    if 'el6' in kernal:
      os='rhel6'
    if 'el7' in kernal:
      os='rhel7'
    hg='hg_'+stage+'_'+os+'_'+appl
    P,V=('h_hostgroup',hg)
    cmd(H,P,V)
    akey='akey_'+stage+'_'+os+'_'+appl
    P,V=('h_akey',akey)
    cmd(H,P,V)
    print(stage,appl,TR,WK,anwendung,email,contact,ldap,kernal,os,hg,akey)



    return(stage,appl,TR,WK,anwendung,email,contact,ldap,kernal,os,hg,akey)






#######################
## read host info from sat6


#!/usr/bin/env python
# -*- coding: utf-8 -*-

import ConfigParser
import re, os, sys, commands, json, argparse, readline
import requests

parser = ConfigParser.SafeConfigParser()
parser.readfp(open("/opt/diba-soe/etc/diba-soe.conf","r"))
SAT_LOGIN =  parser.get("sat6", "USERNAME")
SAT_PASSWORD =  parser.get("sat6", "PASSWORD")
SSL_VERIFY = True # Ignore SSL for now

###########################################
info=['name','id','operatingsystem_name','hostgroup_name','ip','mac','architecture_name']
Items=['h_anwendung','h_contact','h_email','h_ldapgroups','h_patchday','h_stage','h_tranch','h_wartung']
HEAD=["Hostname","SatId","OS","Hostgroup","IP","Macaddress","Kernal","Uptime"]
CNT=0
Header=""
LOG="/ConfigData/tmp/sat6-tmp-host-paramaters.data"

########################################
arg_parser = argparse.ArgumentParser()
arg_parser.add_argument('-s', '--stage', help='enter the name of the system')
args=arg_parser.parse_args()
stage=args.stage




###########################################
def get_json(url):
  r = requests.get(url, auth=(SAT_LOGIN, SAT_PASSWORD), verify=SSL_VERIFY)
  return r.json()

def get_results(url):
  jsn = get_json(url)
  if not jsn.get('error'):
    if jsn.get('results'):
      return jsn['results']
    elif 'results' not in jsn:
      return jsn
    else:
      print "No results found"
      return None

def WRITE_LOG(msg):
  with open(LOG, "a") as log:
    log.write(msg +"\n" )
  log.close()

###########################################
url_hosts=(SAT+'/api/v2/hosts?per_page=10000')
content=get_results(url_hosts)

for item in Items:
  HEAD+=[item]

for i in HEAD:
  CNT += 1
  Header += (str(CNT)+" "+str(i)+"; ")

with open(LOG, "w") as log: 
  log.write(Header+"\n") 
log.close()

for line in content:
  output=[] 
  if not line['name'].startswith('virt'): 
    for item in info: 
      rst=line[item]
      if rst: 
        output.append(rst)
      else: 
        output.append('nn') 
    params=get_results(SAT+'/api/hosts/'+line['name']+'/parameters') 
    output_p=[]
    if params: 
      for item in Items: 
        for param in params: 
          if item in param['name']: 
            output_p.append(param['value']) 
        else:
          output_p.append('nn') 
    else: 
      output_p=['nn', 'nn', 'nn', 'nn', 'nn', 'nn', 'nn', 'nn']
    output.append(output_p) 
    LINE='; '.join(output) 
    WRITE_LOG(LINE)


#####################################
## sendmail about errata packages 

import time
DATUM=(time.strftime("%Y%m%d_%H%M%S"))
DIR="/APPL/var/rh-sys-patching"

hosts=`ansible -i ./foreman.py patchday_pd_wk_automatic_te_fr_0700_20171110 --list-hosts |tail -n +2`



with open(DIR+"/"+host+".json","r") as pkgfile:
  data=json.load(pkgfile)

data['info'][0]['packages']
data['info'][0]["errata_id"]
data['info'][0]["title"]
data['info'][0]["summary"]


with open(DIR+"/"+host+"_"+DATUM) as outfile: 
for x in data['info']:
  print("") 
  print(x["errata_id"])
  print(x["title"])
  for p in (x['packages']):
    print(p) 


 

