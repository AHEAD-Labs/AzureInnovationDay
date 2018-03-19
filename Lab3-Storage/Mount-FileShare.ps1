Param(
$storageAccountName,
$shareName,
$storageAccountKey,
$desiredDriveLetter
)

$acctKey = ConvertTo-SecureString -String $storageAccountKey -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\$storageAccountName", $acctKey
New-PSDrive -Name $desiredDriveLetter -PSProvider FileSystem -Root "\\$storageAccountName.file.core.windows.net\$shareName" -Credential $credential