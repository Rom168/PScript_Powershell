
$user = Read-Host "Quel utilisateur voulez-vous supprimer ?"

Remove-ADUser -Identity $user;
