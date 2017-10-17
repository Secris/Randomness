$NewGroup = ""
$OrigGroup = ""

Add-ADGroupMember $NewGroup -member (Get-ADGroupMember $OrigGroup | Select -ExpandProperty SAMAccountName)
