#Importer des données

$CSVFile = "C:\Users\Administrateur\Documents\Fichieruser.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8

#S�lection de l'UO 
$UO = Read-Host "Dans quel OU mettre l'utilisateur ?"


if($UO -contains "Administration"){

#Boucle Foreach pour passer tout le fichier csv

Foreach($User in $CSVData){
    $UserPrenom = $User.Prenom
    $UserNom = $User.Nom
    $UserLogin = $User.login
    $UserMDP = "LANsecret2"

    #Verifier si user existe ou non dans AD

    if (Get-ADUser -Filter "SamAccountName -eq '$($UserLogin)'")
    {
    Write-Warning "L'identifiant $UserLogin existe déjà dans l'AD"
    }
    else
    {
        New-ADUser -Name "$UserNom $UserPrenom" `
                    -DisplayName "$UserNom $UserPrenom" `
                    -GivenName $UserPrenom `
                    -Surname $UserNom `
                    -SamAccountName $UserLogin `
                    -Path "OU=Administration,OU=ABSTERGO,DC=abstergo,DC=local" `
                    -AccountPassword(ConvertTo-SecureString $UserMDP -AsPlainText -Force) `
                    -ChangePasswordAtLogon $false `
                    -Enabled $true `
                    -Server "abstergo.local"

        Write-Output "Création de l'utilisateur : $UserLogin ($UserNom $UserPrenom)"
    }
}

}
if($UO -contains "IT"){
Foreach($User in $CSVData){
    $UserPrenom = $User.Prenom
    $UserNom = $User.Nom
    $UserLogin = $User.login
    $UserMDP = "LANsecret2"

    #Verifier si user existe ou non dans AD

    if (Get-ADUser -Filter "SamAccountName -eq '$($UserLogin)'")
    {
    Write-Warning "L'identifiant $UserLogin existe déjà dans l'AD"
    }
    else
    {
        New-ADUser -Name "$UserNom $UserPrenom" `
                    -DisplayName "$UserNom $UserPrenom" `
                    -GivenName $UserPrenom `
                    -Surname $UserNom `
                    -SamAccountName $UserLogin `
                    -Path "OU=IT,OU=ABSTERGO,DC=abstergo,DC=local" `
                    -AccountPassword(ConvertTo-SecureString $UserMDP -AsPlainText -Force) `
                    -ChangePasswordAtLogon $false `
                    -Enabled $true `
                    -Server "abstergo.local"

        Write-Output "Création de l'utilisateur : $UserLogin ($UserNom $UserPrenom)"
    }
}
}



