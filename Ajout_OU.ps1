$name_OU = Read-host "Entrez le nom de l'OU";

New-ADOrganizationalUnit -Name $name_OU -Path "OU=ABSTERGO,DC=abstergo,DC=local"

