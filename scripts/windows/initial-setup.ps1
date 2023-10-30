$ErrorActionPreference = "Stop"

$networkProfile = Get-NetConnectionProfile
while ($networkProfile.Name -eq "Identifying..."){
	Start-Sleep -Seconds 10
	$networkProfile = Get-NetConnectionProfile
}

Set-NetConnectionProfile -Name $networkProfile.Name -NetworkCategory Private

netsh Advfirewall set allprofiles state off
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0
