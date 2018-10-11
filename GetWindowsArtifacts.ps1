#Script not 100% Complete to lab specifications 
#But Close 

Write-Host "=================================================================================================================================================================================="
#Get TimeZone and Time 
Write-Host "Get Date, Timezone and PC Uptime"
Write-Host "--------------------------------"

Get-Date
[TimeZoneInfo]::Local
Get-WmiObject Win32_OperatingSystem | Select-Object LastBootUpTime



Write-Host "=================================================================================================================================================================================="

#Get Operating System and OS Version 
Write-Host "Operating System and Version"
Write-Host "----------------------------"
Write-Host
(Get-WmiObject Win32_OperatingSystem).Caption 
(Get-WmiObject Win32_OperatingSystem).Version
Write-Host 


Write-Host "=================================================================================================================================================================================="

#Get Hardware specs 

Write-Host "System Hardware Specs"
Write-Host "---------------------"
Write-Host

Get-WmiObject win32_processor 

Write-Output "This Computer has"
(Get-WmiObject -Class win32_computersystem).TotalPhysicalMemory/1Gb
Write-Output "GB of RAM installed" 

get-WmiObject win32_logicaldisk

Write-Host "=================================================================================================================================================================================="

#This will get hostname and Domain 

Write-Host "Hostname and Domain"
Write-Host "----------------------"

Hostname 
Get-CimInstance Win32_ComputerSystem | select-object Name,PrimaryOwnerContact,UserName,Description,DNSHostName,Domain,workgroup,Manufacturer,Model,SystemFamily,SystemSKUNumber,SystemType,TotalPhysicalMemory

#This will Get the User Information
Write-Host "User Information"
Write-Host "----------------"
Get-LocalUser | select-object Name,ObjectClass,PrincipleSource,LastLogon,PasswordRequired,PasswordLastSet,FullName,Description,SID,Enabled

#This Gets the Start at Boot Items 
Write-Host "Start at Boot"
Write-Host "-------------"
Get-CimInstance Win32_StartupCommand | select-object Name,User,Caption,UserSID,Location

#This will get the scheduled taks 
Write-Host "Start at  Boot"
Write-Host "--------------"
Get-ScheduledTask


Write-Host "=================================================================================================================================================================================="
#This will show the network information 
Write-Host "Network Information"
Write-Host "-------------------"

Write-Host
Write-Host "Mac Address Table"
arp -a 

Write-Host
Write-Host "Mac Address for Interfaces"
getmac 

Write-Host "_______________________________________________________"
Write-Host "Routing Table"
route print

Write-Host "_______________________________________________________"
Write-Host "IPv4 and IPv6 Addresses" 
Get-NetIPAddress | ft IPAddress, InterfaceAlias

Write-Host "_______________________________________________________"
Write-Host "DHCP Server"
#Get-WmiObject Win32_NetworkAdapterConfiguration | select DHCPServer

Write-Host "______________________________________________________"
Write-Host "DNS Servers"
Get-DnsClientServerAddress | select-object -ExpandProperty Serveraddresses


Write-Host "________________________________________________________"
Write-Host "Gateway Information"
Get-NetIPConfiguration | % IPv4defaultgateway | fl nexthop

Write-Host "_________________________________________________________"
Write-Host "Listening Services"
Get-NetTCPConnection -State Listen | ft State, localport, ElemenetName, LocalAddress, RemoteAddress #listening ports

Write-Host
Write-Host "Connections"
Get-NetTCPConnection | where {$_.State -ne "Listen"} | ft creationtime,LocalPort,LocalAddress,remoteaddress,owningprocess, state

Write-Host
Write-Host "DNS Cache"
Get-DnsClientCache | select Name,Entry,Data,Section

Write-Host "================================================================================================================================================================================"
#This will get Printer, and Network Share Information 
Write-Host
Write-Host "Printers, Network Shares and Wireless Profile"
Write-Host "---------------------------------------------"
Write-Host "SMB Share"
Get-SmbShare
Write-Host "SMB Printers"
Get-Printer
Write-Host "Show Wireless Profiles"
(netsh wlan show profiles)
Write-Host "================================================================================================================================================================================"
#This will get list of Installed Software 
Write-Host
Write-Host "Installed Software"
Write-Host "-------------------"
Write-Host
Get-WmiObject -Class Win32_Product
Write-Host "================================================================================================================================================================================"
Write-Host
Write-Host "Get Process List"
Write-Host "-----------------"
Write-Host 
Get-WmiObject Win32_Process | Select-Object ProcessName,ProcessID,ParentProcessID,Path
Write-Host "================================================================================================================================================================================"