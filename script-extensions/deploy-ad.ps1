param($domain, $password)

$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)

Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 

 Install-ADDSForest -DomainName $domain `
                   -DomainMode WinThreshold `
                   -ForestMode WinThreshold `
                   -Force `
                   -SafeModeAdministratorPassword $smPassword 

