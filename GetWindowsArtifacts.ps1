
#Get TimeZone, Date, and PC Uptime 
echo "==============================================================================="
echo "Date, Timezone and PC Uptime"
Get-Date
[TimeZoneInfo]::Local
Get-WmiObject Win32_OperatingSystem | Select-Object LastBootUpTime
echo "==============================================================================="


echo ""
echo ""# Used for output Speration 
echo ""
echo ""

#Get Operating System and OS Version 
echo "==============================================================================="
echo "Operating System and Version"
(Get-WmiObject Win32_OperatingSystem).Caption 
(Get-WmiObject Win32_OperatingSystem).Version
echo "================================================================================"


echo ""
echo ""# Used for output Speration 
echo ""
echo ""

#Get CPU Info
echo "================================================================================="
echo "CPU Info"
Get-WmiObject win32_processor 
echo "================================================================================="

echo ""
echo ""# Used for output Speration 
echo ""
echo ""

#Get the RAM information
echo "================================================================================="
echo "Amount of Ram"
(Get-WmiObject -Class win32_computersystem).TotalPhysicalMemory/1Gb
echo "================================================================================="

echo ""
echo ""# Used for output Speration 
echo ""
echo ""

echo "================================================================================="
echo "HDD Information"
get-WmiObject win32_logicaldisk
echo "=================================================================================="



echo ""
echo ""# Used for output Speration 
echo ""
echo ""

#This will get hostname and Domain 
echo "=================================================================================="
echo "Hostname and Domain"
Hostname 
Get-CimInstance Win32_ComputerSystem | select-object Name,PrimaryOwnerContact,UserName,Description,DNSHostName,Domain,workgroup,Manufacturer,Model,SystemFamily,SystemSKUNumber,SystemType,TotalPhysicalMemory
echo "=================================================================================="




echo ""
echo ""# Used for output Speration 
echo ""
echo ""



#This will Get the User Information
echo "===================================================================================="
echo "User Information"
Get-LocalUser | select-object Name,ObjectClass,PrincipleSource,LastLogon,PasswordRequired,PasswordLastSet,FullName,Description,SID,Enabled
echo "====================================================================================="




echo ""
echo ""# Used for output Speration 
echo ""
echo ""



#This Gets the Start at Boot Items 
echo "====================================================================================="
echo "Start at Boot"
Get-CimInstance Win32_StartupCommand | select-object Name,User,Caption,UserSID,Location
echo "====================================================================================="




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will get the scheduled taks 
echo "====================================================================================="
echo "Start at  Boot"
Get-ScheduledTask
echo "====================================================================================="






echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will show the mac address table  
echo "======================================================================================"
echo "Mac Address Table"
arp -a 
echo "======================================================================================"





echo ""
echo ""# Used for output Speration 
echo ""
echo ""

# this will get mac addresses for the interfaces 
echo "======================================================================================"
echo "Mac Address for Interfaces"
getmac 
echo "======================================================================================"



echo ""
echo ""# Used for output Speration 
echo ""
echo ""

# this will get the routing table 
echo "======================================================================================"
echo "Routing Table"
route print
echo "======================================================================================"




echo ""
echo ""# Used for output Speration 
echo ""
echo ""



# This will get IPv4 and IPv6 Information 
echo "======================================================================================"
echo "IPv4 and IPv6 Addresses" 
Get-NetIPAddress | ft IPAddress, InterfaceAlias
echo "======================================================================================"




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


# This wil get DHCP information displaying output incorrect 
echo "======================================================================================"
echo "DHCP Server"
Get-WmiObject Win32_NetworkAdapterConfiguration | select DHCPServer
echo "======================================================================================"



echo ""
echo ""# Used for output Speration 
echo ""
echo ""

# this will get DNS information Displaying output incorret
echo "======================================================================================"
echo "DNS Servers"
Get-DnsClientServerAddress | select-object -ExpandProperty Serveraddresses
echo "======================================================================================"



echo ""
echo ""# Used for output Speration 
echo ""
echo ""

# this will get Gateway information 
echo "======================================================================================"
echo "Gateway Information"
Get-NetIPConfiguration | % IPv4defaultgateway | fl nexthop
echo "======================================================================================"





echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will get the listening services 
echo "======================================================================================"
echo "Listening Services"
Get-NetTCPConnection -State Listen | ft State, localport, ElemenetName, LocalAddress, RemoteAddress #listening ports
echo "======================================================================================"




echo ""
echo ""# Used for output Speration 
echo ""
echo ""




echo "======================================================================================"
echo "Connections"
Get-NetTCPConnection | where {$_.State -ne "Listen"} | ft creationtime,LocalPort,LocalAddress,remoteaddress,owningprocess, state
echo "======================================================================================"




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


echo "======================================================================================"
echo "DNS Cache"
Get-DnsClientCache | select Name,Entry,Data,Section
echo "======================================================================================"





echo ""
echo ""# Used for output Speration 
echo ""
echo ""

#This will get SMB Share
echo "======================================================================================"
echo "SMB Share"
Get-SmbShare
echo "======================================================================================"




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will get the printers
echo "======================================================================================"
echo "SMB Printers"
Get-Printer
echo "======================================================================================"




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will get wireless profiles 
echo "======================================================================================="
echo "Show Wireless Profiles"
(netsh wlan show profiles)
echo "======================================================================================="




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will get list of Installed Software 
echo "======================================================================================="
echo "Installed Software"
Get-WmiObject -Class Win32_Product
echo "======================================================================================="




echo ""
echo ""# Used for output Speration 
echo ""
echo ""


#This will get the process list 
echo "======================================================================================="
echo "Get Process List"
Get-WmiObject Win32_Process | Select-Object ProcessName,ProcessID,ParentProcessID,Path
echo "======================================================================================="



echo ""
echo ""# Used for output Speration 
echo ""
echo ""

#This will get list of drivers
echo "======================================================================================"
echo "List of Drivers"
Get-WindowsDriver -Online -All
echo "======================================================================================"