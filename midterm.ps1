$outpath = 'c:\scripts\midtermreports'
$outfile = $outpath + '\' + $(Hostname) + '-INV-' + (get-date -format 'MM-dd-yyyy') + '.txt'
if (!(test-path $outpath)) { mkdir $outpath }

  #write out name of machine
'/*** Operating System Information ***/' | out-file $outfile
'Hostname: ' + $(hostname) | out-file $outfile -append

  
  
  #write out os version
$opsys = get-ciminstance win32_operatingsystem
'OS Version: ' + $opsys.version | outfile $outfile -append
"`n" | out-file $outfile -append

#write out hardware information
'/*** Hardware Information ***/' | out-file $outfile -append
$processor = get-wmiobject win32_processor
'Processor: ' + $processor.name | out-file $outfile -append
'Processor manufacturer: ' + $processor.manufacturer | out-file $outfile -append
'Processor core count: ' + $processor.numberofcores | out-file $outfile -append
'Physical memory: ' + (Get-WMIObject -class Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | foreach {[Math]::Round(($_.sum / 1GB),2)}) + 'GB' | out-file $outfile -append
"`n" | out-file $outfile -append

  #write out roles and features
if ($opsys.producttype -eq 1) {
  '/*** Roles and Features are not available on a workstation ***/' | out-file $outfile -append
} else {
  '/*** Installed Roles and Features ***/' | out-file $outfile -append
  get-windowsfeature | where installed | ft -autosize | out-file $outfile -append
}


  
  #write out whether remote desktop is enabled
  Get-ItemPropertyvalue -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -name 'fDenyTSConnections'
  
  
  #write out last 5 warnings and errors from system log
  #write out last 5 warnings and errors from application log
  Get-WinEvent -FilterHashtable @{Logname="$log";Level="$level"} -maxevents 5 | ft -autosize | out-file $outfile -append
    
  
  
