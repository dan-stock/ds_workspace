####################
# get the name in W:\Bereich IT\ITI\60_Server_Storage_Services\50_Team_Virtualization_Cloud\10_Systemdaten\OS-Inventarliste Born Again_neu.xlsm
# PowerCLI W:\Bereich IT\ITI\60_Server_Storage_Services\50_Team_Virtualization_Cloud\20_ESX\110_Scripte> .\create-vm-main.ps1

cd "W:\Bereich IT\ITI\60_Server_Storage_Services\50_Team_Virtualization_Cloud\20_ESX\110_Scripte" 
.\create-vm-main.ps1

##

set-alias l  ls

get-help get-location -examples|more
Get-ExecutionPolicy
Get-Service
ConvertTo-HTML
Get-Service | ConvertTo-HTML -Property Name, Status > C:\services.htm
Get-EventLog -Log "Application"
Get-Process
Stop-Process
Stop-Process -Name notepad
Stop-Process -ID 2668

cls # clear the screen

"C:\Programme\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1"

Get-ChildItem = ls 
Get-Date
Get-Date -displayhint time

#################
get-service |where-object {$_.status -eq "running"}

Status   Name               DisplayName
------   ----               -----------
Running  ALG                Gatewaydienst auf Anwendungsebene
Running  AudioSrv           Windows Audio
Running  BITS               Intelligenter Hintergrundübertragun...
Running  COMSysApp          COM+-Systemanwendung
Running  CryptSvc           Kryptografiedienste
Running  DcomLaunch         DCOM-Server-Prozessstart
Running  Dhcp               DHCP-Client
...
##############

get-service |where-object {$_.status -eq "running"}|sort-object displayname

Status   Name               DisplayName
------   ----               -----------
Running  Netlogon           Anmeldedienst
Running  lanmanworkstation  Arbeitsstationsdienst
Running  wuauserv           Automatische Updates
Running  EventSystem        COM+-Ereignissystem
...
###############

vSphere PowerCLI
----------------------------------------------------------------------

 cd Scripts
 .\get-vmware.ps1
 
----------------------------------------------------------------------
 get-vmware.ps1
 .\get-satellite-config.pl
 view
 get-vm *sx*|get-view
 get-command
 get-vicommand
 help Set-VM
 help Set-VM -full
 help Set-VM -example
 help Set-VM

 $view = get-vm gf0vswwb81 | get-view
 $view
 $view.storage
 $view.storage.perdatastoreusage
 $view.summary
 $view.summary.storage
 $view.config
 $view.config.files
 $view.config.files.vmpath
 $view.config.files.vmpathname
 $view.config.files.vmpathname.split(" ")[0]
 .\get-vmware.ps1

C:\Programme\VMware\Infrastructure\vSphere PowerCLI

-----------------------------------------------------------------------
Log in to a vCenter Server or ESX host:              Connect-VIServer
To find out what commands are available, type:       Get-VICommand
To show searchable help for all PowerCLI commands:   Get-PowerCLIHelp
Once you've connected, display all virtual machines: Get-VM
If you need more help, visit the PowerCLI community: Get-PowerCLICommunity

danny's script
---------------------------------------------------------------
connect-viserver SERVER
$pools=get-resourcepool
rm "vmware.data"
get-vm *sx* | get-view | % {
	$name=$_.name
	$ip=$_.guest.ipaddress
	$os=$_.guest.GuestFullName
	$poolid=$_.resourcepool.value
	$pool=($pools | ? {$_.id -match $poolid})
	$power=$_.summary.runtime.powerstate
	$ds=$_.config.files.vmpathname.split(" ")[0]
	"$($name);$($pool.name);$($pool.parent);$($ip);$($os);$($power);$($ds)" | add-content "vmware.data"
}


get-vm *sx* | get-view | %{ $name=$_.name | add-content "vmware.data" }




get-vm *sx* | % {
	$name=$_.name
	$ip=$_.ExtensionData.guest.ipaddress
	$os=$_.ExtensionData.guest.GuestFullName
	$folder=$_.Folder
	$power=$_.ExtensionData.summary.runtime.powerstate
	$ds=$_.ExtensionData.config.files.vmpathname.split(" ")[0]
	"$($name);$($folder);$($ip);$($os);$($power);$($ds)" | add-content $export_file
}

get-vm *sx* | % {
	$name=$_.name
	$ip=$_.ExtensionData.guest.ipaddress
	$os=$_.ExtensionData.guest.GuestFullName
	$folder=$_.Folder
	$power=$_.ExtensionData.summary.runtime.powerstate
	$ds=$_.ExtensionData.config.files.vmpathname.split(" ")[0]
	"$($name);$($folder);$($ip);$($os);$($power);$($ds)" | add-content $export_file

#####################
## notes from the kurs
######################


# set variables 
$x = New-Object Object; $h.Keys | foreach { $x | New-ItemProperty -Name $_ -V

$host.PrivateData.ErrorBackgroundColorColor = "Red"
$host.PrivateData.ErrorBackgroundColor = "White"

$job = Start-Job -ScriptBlock { Get-EventLog -LogName System }
$h.Keys | foreach { New-Object Object }

# formate
"{0:0000}" -f 12
"{0:F2}" -f ((dir | Measure-Object -Property Length -Sum).Sum / 1MB)
"{0:F3} MB" -f (1/3)


# math
"10" - 20
"10" / 2
"10" + 20

# regex
"user@host.de" -match "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"

"192,168.255.1" -match "^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$"
"192.168.255.1" -match "^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$"
"192.168.256.1" -match "^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$"

"Das ist ein Test" -like "Das*"
"Das ist ein Test" -replace "ein", "kein"
"Der Dienst $($s.Name) hat den $s.Status"
"Der Dienst $s.Name hat den $s.Status"
"Guten Morgen " + $vorname + " " + $nachname
"Guten Morgen $vorname $nachname"
"Guten Tag {1} {0}" -f "Walker", "Lucy"
"Heute ist der $(Get-Date)"
"LDAP://cn=Lucy Walker,ou=IT,dc=beispielag,dc=local"
"Max,Mustermann,Teststraße 5,12345,Frankfurt" | Get-Member
"Max,Mustermann,Teststraße 5,12345,Frankfurt".Split(",")
"Max,Mustermann,Teststraße 5,12345,Frankfurt".Split(",")[3]
"Pa$$w0rd"
"Power" * 5
"Power" + "Shell"
"user @host.com" -match "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
"user@host.com" -match "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
"user@host.de" -match "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
"zehn" + 20


# get commands
Get-ADUser -Filter * -Properties City | Where-Object { $_.City -eq "Frankfurt" }
get-command *property*


$?
${C:\server.txt}
$a
$a--
$a *= 5
$a += 1
$a = $a + 1
$a = 1
$a++

$computer
$computer = @{}
$computer.IP ="192.168.1.1"
$computer.Name = "London"
$computer.Standort
$computer.Standort = "RZ1"

$datum
$datum | Get-Member
$datum = $datum.AddDays(-30)
$datum = Get-Date

$Days

$error
$ErrorActionPreference

$Firstname | Get-member
$Firstname = "Lucy"
$Firstname.SubString(0,1)
$Firstname.SubString(0,1) + $Nachname
$Firstname.SubString(0,2) + $Lastname
$Firstname.SubString(0,2) + $Nachname
$Firstname.ToUpper()
$Firstname[0] + $Lastname

$gruppen = "IT", "HR", "LEGAL"
$gruppen -contains "FIN"
$gruppen -contains "HR"

## hash table 
$h
$h | ConvertTo-Html
$h | get-member
$h = @{ Name="London"; IP="192.168.144.1"; Standort="RZ1" }
$h.Keys
$h.Keys | foreach { "" + $_  +": " + $h[$_] }
$h.Keys | foreach { "" + $h +": " + $h[$_] }
$h.Keys | foreach { $_;$h[$_] }
$h.Keys | foreach { @($_, $h[$]) }
$h.Keys | foreach { @($_, ($h[$])) }
$h.Keys | foreach { @($_, ($h[$_]) }
$h.Keys | foreach { @($_, ($h[$_])) }
$h.Keys | foreach { @($_, ($h[$_])) } | ConvertTo-html
$h.Keys | foreach { New-Object | Select @{ Label="$_";Expression={$h[$_]} }
$h.Keys | foreach { New-Object | Select @{ Label="$_";Expression={$h[$_]}} }
$h.Keys | foreach { New-Object | Select @{ Label="$_";Expression={$h[$_} }
$h.Keys | foreach { New-Object Object | Select @{ Label="$_";Expression={$h[$_]}} }
$h.Keys | foreach { New-Object Object | Select @{ Label="$_";Expression={$h[$_]}} } | get-member
$h.Values
$h[$h.Keys]

$job

$Lastname = "Walker"

$mail
$mail | Where-Object { $_ -like "smtp*" }
$mail = "SMTP:lucy@host.com", "smtp:info@host.com", "smtp:support@host.com", "sip:lucy@host.com"
$mail = $mail + "smtp:vertrieb@host.com"
$mail -like "sip*"
$mail -like "smtp*" 
$mail -notlike "*:info@host.com"

$MyPowerShell
$MyTest
$MyTest = "Guten Morgen"

$nachname = "Walker"

$s = get-service dnscache

$server
$server | "Verbinde mit Server"
$server | % { "Verbinde mit Server" }
$server | foreach { "Verbinde mit $($_)" }
$server | foreach { "Verbinde mit $_" }
$server | foreach { "Verbinde mit $server" }
$server | foreach { "Verbinde mit Server $_" }
$server | foreach { "Verbinde mit Server" }
$server | Sort-Object
$server += "Frankfurt"
$server = "London"
$server = "London", "Paris", "Koeln"
$server = "London","Paris","Koeln"
$server = $server + "Berlin"
$server = @("London", "192.168.1.1", "RZ1"), @("Paris", "192.168.1.2", "RZ1"), @("Koeln", "192.168.1.3", "RZ2")
$server = @("London", "192.168.144.1", "RZ1")
$server = @("London", "Paris", "Koeln")
$server = @{ Name="London"; IP="192.168.144.1"; Standort="RZ1" }
$server = @{}
$server.IP
$server.IP = "192.168.144.1"
$server.Name = "London"
$server.Standort = "RZ1"
$server[2]
$server[2][2]
$Unterstrich
$Unterstrich | select-object *
$Unterstrich = dir tag1.txt
$Unterstrich.ToString()
$vorname = "Lucy"

$x

$x = New-Object Object; $h.Keys | foreach {  New-ItemProperty -Name $_ -Value ($h[$_]) }; $x
$x = New-Object Object; $h.Keys | foreach { $x | Select *, @{ Label="$_";Expression={$h[$_]}} } 
$x = New-Object Object; $h.Keys | foreach { $x | Select-Object *, @{ Label="$_";Expression={$h[$_]}} } 
$x = ping 192.168.144.200

& .\test.ps1

($mail -like "sip*") -replace "sip:", ""

(dir .\WindowsUpdate.log | Select-String error)[0]
(dir .\WindowsUpdate.log | Select-String error)[0].Line
(dir .\WindowsUpdate.log | Select-String error)[0].Line | get-member
(dir .\WindowsUpdate.log | Select-String error)[0].Line.Split(" ")
(dir .\WindowsUpdate.log | Select-String error)[0].Line.Split("`t")
(dir .\WindowsUpdate.log | Select-String error)[0].Line.Split("`t") | Select-Object -Last 1
(dir .\WindowsUpdate.log | Select-String error)[0].Line.Split("`t")[5]
(dir | Measure-Object -Property Length -Sum).Sum
(dir | Measure-Object -Property Length -Sum).Sum / 1MB
(dir tag1.txt).Length

(Get-Date).AddDays (-30)
(Get-Date).AddDays( -30 )
(Get-Date).AddDays(-30)
(Get-Service dnscache).Status
(Get-Service dnscache).Stop
(Get-Service dnscache).Stop()
(Get-Service)[0]

. .\test.ps1
.\test
.\test.ps1
.\test.ps1 
.\test.ps1  -File personen.csv
.\Test2.ps1

[DateTime]"05/03/14"

-1 * $null 

1 / 0
1..10 | foreach { Start-Job -ScriptBlock { Get-EventLog -LogName System } }
10 + "20"
10 + "zwanzig"
10KB
1EB
1GB
1KB
1MB
1PB
1TB
5 -gt 3
Add-PswaAuthorizationRule -UserName Beispielag\Administrator `
Add-WindowsFeature -?
Add-WindowsFeature XPS-Viewer
alue ($h[$_]) }; $x
c:
c:\test
c:\test.ps1
cd "dc=beispielag,dc=local"
cd ad:
cd beispielag
cd dc=beispielag,dc=local
cd function:
cd hklm:
cd variable:
cd windows



Convertto-html -?
copy-item -?
del *.csv -Confirm
del *.csv -Verbose
del *.csv -WhatIf

dir
dir *.log
dir *.log | select-string *error*
dir *.log | select-string error
dir *.log | select-string errorcls
dir *.txt | Backup
dir *.txt | Sum
dir .\WindowsUpdate.log | Select-String error
dir .\WindowsUpdate.log | Select-String error | foreach { $_.Line.Split("`t") | Select-Object -Last 1  }
dir .\WindowsUpdate.log | Select-String error | foreach { $_.Line.Split("`t") | Select-Object -Last 1  } | Where-Object { $_ -like "WARNING*" }
dir .\WindowsUpdate.log | Select-String error | foreach { $_.Line.Split("`t")[5]  }
dir .\WindowsUpdate.log | Select-String error | Get-Member
dir .\WindowsUpdate.log | Select-String error | Select-Object *
dir .\WindowsUpdate.log | Select-String warning | foreach { $_.Line.Split("`t") | Select-Object -Last 1  }
dir /s
dir | Get-Member
dir | Measure-Object
dir | Measure-Object -Property Length
dir | Measure-Object -Property Length -Sum
dir | Measure-Object -Property Length -Sum | Get-Member
dir | Measure-Object -Property Length -Sum -Average

dir | Select-Object Name,Length

dir | Where-Object { $_.gitb -gt 100000 }
dir | Where-Object { $_.gitb -gt 100KB }
dir | Where-Object { $_.Lenght -gt 100000 }
dir | Where-Object { $_.Length -gt 100000 }
dir | Where-Object { $_.Length -gt 100KB }

dir copy-item
dir -File
dir -File | Select-Object Name, Length
dir -File | Select-Object Name, Length | Format-Table -AutoSize
dir MyBackup
dir tag1.txt
dir tag1.txt | Get-Member
dir tag1.txt | Select-Object *

Enable-PSRemoting

filter Backup { Copy-Item -Path $_ -Destination "C:\MyBackup" }
filter MyFi { "Mein Filter läuft" }

function Get-RecentErrors { Get-EventLog -LogName System -EntryType Error -After ((Get-Date).AddDays(-30)) }
function Get-RecentErrors($Days = 30) { 
function Get-RecentErrors($Days) { 
function MwSt($Betrag, $Satz) { $erg = $Betrag / 100 * $Satz; $erg }
function MyFu { "Meine Funktion läuft" }
function Sum { $s = 0; $Input | foreach { $s += $_.Length }; $s }

Get-ADUser
Get-ADUser -?
Get-ADUser -Filter *
Get-ADUser -filter * | Select-Object SamAccountName,UserPrincipalName
Get-ADUser -Filter * | Where-Object { $_.UserPrincipalName -eq $Null }
Get-ADUser -Filter { City -eq "Berlin" }
Get-ADUser -Filter { City -eq "Berlin" } | Set-ADUser -City "München" -Verbose
Get-ADUser -Filter { City -eq "Frankfurt" }
Get-ADUser -Filter { City -eq "Frankfurt" } | Set-ADUser -City "Berlin"
Get-ADUser -Filter { City -eq "Frankfurt" } | Set-ADUser -City "Berlin" -WhatIf
Get-ADUser -Filter { City -eq "München" }
Get-ADUser -Filter { City -eq "München" } | Remove-ADUser
Get-ADUser -Filter { City -eq "München" } | Remove-ADUser -Confirm
Get-ADUser -Filter { City -eq "München" } | Remove-ADUser -Confirm:$False
Get-ADUser -Filter { UserPrincipalName -eq $Null }
Get-ADUser -Filter { UserPrincipalName -notlike "*" }
Get-ADUser -Identity gibtnicht
Get-ADUser -Identity lucy
Get-ADUser -Identity luryan
Get-ADUser -Identity luryan | Select-Object *
Get-ADUser -Identity luryan -Properties *
Get-ADUser -Identity luryan -Properties City
Get-ADUser -Identity luryan -Properties City | Select-Object Name,SamAccountName,City

Get-ChildItem /s

Get-CimInstance -ClassName "Win32_ComputerSystem"
Get-CimInstance -ClassName "Win32_ComputerSystem" | Select-Object *
Get-CimInstance -ClassName "Win32_LogicalDisk"
Get-CimInstance -ClassName "Win32_Printer"
Get-CimInstance -ClassName "Win32_Service"

Get-Command
get-command *-job
Get-Command *-service
get-command add*
Get-Command -Module ActiveDirectory
Get-Command -Module ActiveDirectory | Sort-Object Noun
Get-Command -Module ActiveDirectory | Sort-Object Noun | Get-Help -Full > ausgabe.txt
Get-Command -Module ServerManager
Get-Commandcls

Get-Content features.txt
Get-Content features.txt | Add-WindowsFeature
Get-Content features.txt | foreach { Add-WindowsFeature -Name $_ }
Get-Content features.txt | Remove-WindowsFeature
Get-Content gibtsnicht.txt
Get-Content server.txt
Get-Content server.txt | foreach { "Verbinde mit $_" }
Get-Content server.txt | Sort-Object

Get-Date
Get-Date | Get-Member

Get-EventLog
Get-EventLog -?
Get-EventLog -List
Get-EventLog -List | foreach { Get-EventLog -LogName $_ -EntryType Error }
Get-EventLog -List | foreach { Get-EventLog -LogName $_.Log -EntryType Error }
Get-EventLog -LogName *  -EntryType Error
Get-Eventlog -LogName System
Get-Eventlog -LogName System | Where-Object { $_.EntryType -eq "Error" }
Get-Eventlog -LogName System | Where-Object { $_.EntryType -eq "Error" -or $_.EntryType -eq "Warning" }
Get-EventLog -LogName System -EntryType Error
Get-EventLog -LogName System -EntryType Error -After ((Get-Date).AddDays(-30))
Get-EventLog -LogName System -EntryType Error -After ([DateTime]"01/01/14")
Get-EventLog -LogName System -EntryType Error -After [DateTime]"01/01/14"

Get-ExecutionPolicy

Get-Help about*
Get-Help about_Requires
Get-Help about_Wildcards
Get-Help Get-Service
Get-Help Get-Service -Examples
Get-Help Get-Service -Full

Get-Host

Get-Job

Get-Mailbox

Get-Module
Get-Module -ListAvailable
Get-Process
Get-Process | Format-Table ProcessName,CPU
Get-Process | Format-Table ProcessName,CPU | Export-CSV format.csv
Get-Process | Format-Table ProcessName,CPU | Get-Member
Get-Process | Format-Table ProcessName,CPU -AutoSize
Get-Process | ft ProcessName,CPU
Get-Process | Get-Member
Get-Process | Out-GridView -PassThru | Stop-Process
Get-Process | Select-Object ProcessName, CPU | Sort-Object CPU | Export-CSV ausgabe.csv
Get-Process | Select-Object ProcessName,CPU
Get-Process | Select-Object ProcessName,CPU | Convertto-html
Get-Process | Select-Object ProcessName,CPU | Convertto-html > ausgabe.htm
Get-Process | Select-Object ProcessName,CPU | Export-clixml ausgabe.xml
Get-Process | Select-Object ProcessName,CPU | Export-CSV select.csv
Get-Process | Select-Object ProcessName,CPU | Get-Member

Get-PSDrive

Get-PSSession -?
Get-PSSnapin
Get-PSSnapin -Registered

Get-RecentErrors
Get-RecentErrors #Standardwert = 30
Get-RecentErrors #Standardwert = 30cls
Get-RecentErrors -Days 1
Get-RecentErrors -Days 30
Get-RecentErrors -Days 365
Get-RecentErrors -Days 7

Get-Service
Get-Service *dns*
Get-Service -?
Get-Service | ? { $_.CanStop }
Get-Service | ? { $_.CanStop -eq $True }
Get-Service | ? CanStop
Get-Service | foreach { "Der Dienst $($_.Name) hat den Status $($_.Status)" }
Get-Service | foreach { "Der Dienst $($_.Name) hat den Status $_.Status" }
Get-Service | foreach { "Der Dienst $_.Name hat den Status $_.Status" }
Get-Service | Get-Member
Get-Service | MyFi
Get-Service | MyFu
Get-Service | Out-File ausgabe.txt
Get-Service | Out-GridView
Get-Service | Select-Object *
Get-Service | Select-Object Name,CanStop
Get-Service | Select-Object Name,CanStop,Machineame
Get-Service | Select-Object Name,CanStop,MachineName
Get-Service | Select-Object Name,Status
Get-Service | Select-Object Name,Status | Export-Csv ausgabe.csv
Get-Service | Select-Object Name,Status > ausgabe.txt
Get-Service | Where { $_.CanStop -eq $True }
Get-Service | Where-Object { $_.CanStop -eq $True }
Get-Service | Where-Object { $_.Status -eq "Stopped" }
Get-Service | Where-Object CanStop
Get-Service | Where-Object CanStop -eq $True
Get-Service > ausgabe.txt
Get-Service dnscache
Get-Service dnscache | Get-Member
Get-Service dnscache | Select-Object Status
Get-Service -N winrm
Get-Service -Name dnscache
Get-Service -Name winrm
Get-Service -Name winrm, wuauserv, dnscache
Get-Service -Name winrm,wuauserv,dnscache
Get-Service -Name wuauserv

Get-Service winrm

Get-WindowsFeature
Get-WindowsFeature -?
Get-WindowsFeature | Get-Member
Get-WindowsFeature | Select-Object *
Get-WindowsFeature | Where-Object { $_.Installed -eq $True }
Get-WmiObject -List

Import-CSV ausgabe.csv
Import-CSV personen.csv
Import-CSV personen.csv | Get-Member
Import-CSV personen.csv | Where-Object { $_.Abteilung -eq "IT" }
Import-CSV personen.csv -Delimiter ";"
Import-CSV personen.csv -Delimiter "`t"
Import-CSV personen.csv -Delimiter "`t" | Sort-Object Nachname
Import-CSV personen.csv -Delimiter "`t" | Sort-Object Nachname -Descending
Import-CSV personen.csv -Delimiter "´t"
Import-Csv server.txt
Import-Module ActiveDirectory
Import-Module ServerManager
Install-PswaWebApplication -UseTestCertificate

md MyBackup

MwSt 1000 19
MwSt -Betrag 1000 -Satz 19
MwSt -S 19 -B 1000
MwSt(1000,19)

MyFi
MyFu

New-ADUser -?

notepad ausgabe.csv
notepad ausgabe.txt
notepad features.txt
notepad format.csv
notepad personen.csv
notepad select.csv
notepad server.txt
notepad test.ps1
notepad Test2.ps1

ping 192.168.144.200

PS AD:\dc=beispielag,dc=local> 1..10
PS AD:\dc=beispielag,dc=local> 1..10 | foreach { md "ou=Org$_" }
PS AD:\dc=beispielag,dc=local> 90..80
PS AD:\dc=beispielag,dc=local> cd\
PS AD:\dc=beispielag,dc=local> cls
PS AD:\dc=beispielag,dc=local> dir
PS AD:\dc=beispielag,dc=local> Get-Content C:\ou.txt | foreach { md "ou=$_" }
PS AD:\dc=beispielag,dc=local> md "ou=Entwicklung"
PS AD:\dc=beispielag,dc=local> notepad c:\ou.txt
PS Function:\> cd variable:
PS Function:\> dir
PS Function:\> Get-Content backup
PS HKLM:\> 
PS HKLM:\> $?
PS HKLM:\> $error[0]
PS HKLM:\> $Error[0] | Select-Object *
PS HKLM:\> $ErrorActionPreference = "Continue"
PS HKLM:\> $ErrorActionPreference = "Inquire"
PS HKLM:\> $ErrorActionPreference = "SilentlyContinue"
PS HKLM:\> $ErrorActionPreference = "Stop"
PS HKLM:\> c:
PS HKLM:\> cls
PS HKLM:\> dir
PS Variable:\> 
PS Variable:\> $WarningPreference = "Continue"
PS Variable:\> $WarningPreference = "SilentlyContinue"
PS Variable:\> c:
PS Variable:\> cls
PS Variable:\> dir
PS Variable:\> dir *war*
PS Variable:\> Get-PSDrive
PS Variable:\> Write-Host "Hallo" -ForegroundColor "Yellow" -BackgroundColor "Black"
PS Variable:\> Write-Warning "Hallo PowerShell"

Receive-Job $job
            
Set-ADUser -City "München"
Set-ADUser -City "München" -Identity lucy

Set-ExecutionPolicy -?
Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy Restricted
Set-ExecutionPolicy Restricted -Verbose

Show-Command Get-EventLog

Start-Transcript c:\Tag3-2.txt
Start-Transcript c:\Tag4-2.txt

Stop-Service dnscache
Stop-Transcript
                                       
Write-Host "Hallo PowerShell"
Write-Host "Hallo PowerShell" -ForegroundColor "Yellow" -BackgroundColor "Red"
Write-Host "Hallo PowerShell" -ForegroundColor "Yellow" -BackgroundColor "Red" | out-null

Write-Warning "Hallo PowerShell"
Write-Warning "Hallo PowerShell" | out-null

