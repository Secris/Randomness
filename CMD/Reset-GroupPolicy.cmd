reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Group Policy Objects"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies"

gpupdate /force

