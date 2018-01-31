Try{

#grab user logged into console session and return to string
$UserName = (Get-WMIObject -class Win32_ComputerSystem | foreach {$_.username}).tostring()
#split name into domain and username
$UserDomain,$Username = $UserName.split("\")
#get user sid from ad
$UserSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Domain = '$UserDomain' AND Name = '$UserName'").Sid

#get key names under user\printers\connections
#items are returned as: HKEY_USERS\User_SID\printers\connections\,,server,printer name
#first replace statement will remove all leading up to and including ,,
#second replace will replace , in server,printer name with \
#last replace will } from the end that is returned after first replace
#results are: server\printer name

Get-ChildItem -path Microsoft.PowerShell.Core\Registry::HKEY_USERS\$UserSID\printers\connections | select name | % {$_ -replace '.*,,'} | % {$_ -replace ',','\'} | % {$_ -replace '}', ''}
}

Catch [System.Management.Automation.RuntimeException]{
#for no console user logged in
"No console user"
}

Catch {
#print out other errors
$error | fl * -f
}
