$date = (Get-Date).ToString("_ddMMyyyy_HHmm")


#Find PC
#Get-ADComputer -Filter * -SearchBase "OU=Computers,DC=ABSTERGO,DC=local" -Properties *  |
# Select -Property Name | 
 #Export-CSV "C:\AllComputersInOU.csv" -NoTypeInformation -Encoding UTF8 -Force
 
#start session


$Servers = Get-Content "C:\AllComputersInOU.csv"



#Scanning Servers and executing 
$Servers | ForEach-Object{

$session = New-PSSession -ComputerName $Servers

#ouvrir la session
Enter-PSSession -Session $session



$DestPath =  "C:\Save\$_\"+"$_"+"$date"
$SourcePath = "C:\Users\"


#Creating new folder for storing backup

New-Item -Path $DestPath -ItemType Directory

Copy-Item -FromSession $session -Path $SourcePath  -Destination $DestPath -Recurse -Force



exit

#Suppr Dossiers
$nombre = (Get-ChildItem "C:\Save\$_\" -Directory| Measure-Object).Count
Write-Host $nombre
if(nombre > 7){
    Get-ChildItem "C:\Save\$_\" | Sort CreationTime | Select -First 1 | Remove-Item
}

exit
}
exit


