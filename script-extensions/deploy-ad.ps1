param($domain, $password)

$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)


Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 0

Rename-LocalUser -Name "demouser" -NewName "administrator"

Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 

Install-ADDSForest -DomainName $domain `
                -DomainMode WinThreshold `
                -ForestMode WinThreshold `
                -Force `
                -SafeModeAdministratorPassword $smPassword 

