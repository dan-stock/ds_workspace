#!/usr/bin/env python
# -*- coding: utf-8 -*-

## Description ####################################################
desc="""
author: dstock
version 0.1.1
"""

## Imports ####################################################
import commands
import json
import socket
import time

## Set the argument parser

## Variables ####################################################
CLUSTER="test.ichp.ing.net"
HOSTNAME = socket.gethostname()
NOW = int(time.time())

## Funktions ####################################################
def modifyJsonFile():
  jsonFile = open("/tmp/datamodel.json", "r") # Open the JSON file for reading
  data = json.load(jsonFile) # Read the JSON into the buffer
  jsonFile.close() # Close the JSON file
  data["timestamp"] = NOW
  data['patch_management'][CLUSTER]=[HOSTNAME]
  data['patch_management'][CLUSTER][HOSTNAME]=[{'atomic':''},{'openshift':''}]
  cmd="/bin/rpm-ostree status --json"
  (status, output)=commands.getstatusoutput(cmd)
  if status != 0:
    raise ValueError('rpm-ostree failed to run')
  data = json.loads(output)
  for deploy in data["deployments"]:
    if deploy["booted"]:
      ACTIVE=['active_ref:'+str(deploy["version"])+',active_hash:'+str(deploy["checksum"])+',active_date:'+str(deploy["timestamp"])]
      type(ACTIVE)
      print(ACTIVE)
    else:
      ALTERNATIVE=['alternative_ref:'+str(deploy["version"])+',alternativ_hash:'+str(deploy["checksum"])+',alternative_date:'+str(deploy["timestamp"])]
      type(ALTERNATIVE)
      print(ALTERNATIVE)

#  data['patch_management'][CLUSTER][HOSTNAME]['atomic']={ACTIVE,ALTERNATIVE}
  jsonFile.close()

## Main ####################################################
def main():
  modifyJsonFile()

if __name__ == "__main__":
  main()

