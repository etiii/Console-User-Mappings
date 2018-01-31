Try{

#grab user logged into console session and return to string
$UserName = (Get-WMIObject -class Win32_ComputerSystem | foreach {$_.username}).tostring()
#split name into domain and username
$UserDomain,$Username = $UserName.split("\")
#get user sid from ad
$UserSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Domain = '$UserDomain' AND Name = '$UserName'").Sid
#list all keys under network registry key for user, listing PSChildName, RemotePath entries
Get-ChildItem -path Microsoft.PowerShell.Core\Registry::HKEY_USERS\$UserSID\Network -Recurse | get-itemproperty | select PSChildName, RemotePath | fl
}

Catch [System.Management.Automation.RuntimeException]{
#for no console user logged in
"No console user"
}

Catch {
#print out other errors
$error | fl * -f
}
