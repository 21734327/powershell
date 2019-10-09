##Powershell Midterm Script##
##Written By: Emily Garber##
##Due: October 16 2019##


#8. Check if report location exists, otherwise create it + set variables for file name
$pcname= hostname
$date= get-date -format "MM-dd-yyyy"
$path= test-path c:\midterm

if ($path -ne 'True'){
new-item -path C:\ -name Midterm -itemtype directory
}


#1. Name of the System
write-output "Name of System: " $pcname | out-file -filepath c:\midterm\$pcname-$date.txt -append


#2. Information about the OS Version
$osvers= get-ciminstance -classname win32_operatingsystem | select-object version
write-output "OS Version:" $osvers | out-file -filepath c:\midterm\$pcname-$date.txt -append


#5. Windows Roles/Features installed
$type= (get-ciminstance win32_operatingsystem).producttype
if ($type -ne 1) 
{
write-output "Installed Roles and Features" | out-file -filepath c:\midterm\$pcname-$date.txt -append
get-windowsfeature | where installed | select-object -property Name | out-file -filepath c:\midterm\$pcname-$date.txt -append
}
    else
{
write-output "Roles and Features are not available on a workstation" | out-file -filepath c:\midterm\$pcname-$date.txt -append
}

#3. Processor Info for System
write-output "Processor Info" | out-file -filepath c:\midterm\$pcname-$date.txt -append
$proc= get-wmiobject win32_processor | select-object name
$manu= get-wmiobject win32_processor | select-object Manufacturer
$cores= get-wmiobject win32_processor | select-object numberofcores
write-output "Processor Name:" $proc | out-file -filepath c:\midterm\$pcname-$date.txt -append
write-output "Manufacturer:" $manu | out-file -filepath c:\midterm\$pcname-$date.txt -append
write-output "Number of Cores:" $cores | out-file -filepath c:\midterm\$pcname-$date.txt -append


#4. Amount of Physical RAM
$memory= (get-wmiobject win32_computersystem).totalphysicalmemory/1GB
write-output "Amount of RAM (GB):" $memory | out-file -filepath c:\midterm\$pcname-$date.txt -append



#6. Remote Desktop Protocol - Configured or not?



#7. Last 5 warning and error messages from system/application event logs
write-output "System Errors" | out-file -filepath c:\midterm\$pcname-$date.txt -append
get-eventlog -logname system -entrytype error -newest 5 | format-table -wrap | out-file -filepath c:\midterm\$pcname-$date.txt -append
write-output "System Warnings"  | out-file -filepath c:\midterm\$pcname-$date.txt -append
get-eventlog -logname system -entrytype warning -newest 5 | format-table -wrap | out-file -filepath c:\midterm\$pcname-$date.txt -append

write-output "Application Errors" | out-file -filepath c:\midterm\$pcname-$date.txt -append
get-eventlog -logname application -entrytype error -newest 5 | format-table -wrap | out-file -filepath c:\midterm\$pcname-$date.txt -append
write-output "Application Warnings" | out-file -filepath c:\midterm\$pcname-$date.txt -append
get-eventlog -logname application -entrytype warning -newest 5 | format-table -wrap | out-file -filepath c:\midterm\$pcname-$date.txt -append


