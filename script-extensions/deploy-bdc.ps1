param($domain, $user, $password)

$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)
$smCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $smPassword

Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 

Install-ADDSDomainController -NoGlobalCatalog:$false `
							 -CreateDnsDelegation:$false `
							 -CriticalReplicationOnly:$false `
							 -DomainName $domain `
							 -InstallDns:$true `
							 -SafeModeAdministratorPassword $smPassword `
							 -Credential $smCredential `
							 -Force:$true

