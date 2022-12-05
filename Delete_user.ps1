$user = Read-host "Entrez l'utilisateur à supprimer : "

Remove-ADUser  -Identity  $user
