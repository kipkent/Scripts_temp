#Params
$url = "https://dev.azure.com/CET-Tech//_apis/hooks/subscriptions"
$PathFile = "C:\Users\AlexK\PycharmProjects\untitled1\DevOps\Scripts_temp\jenkins\idlist.txt"
$Username = "jenkinshooks"
$Password = "112f7212612b12c65de2df82b1b77548d8"
$amount = 0

#headers
$headers1 = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers1.Add("Content-Type", "application/json")
$headers1.Add("Authorization", "Basic QmFzaWM6Y25rZjV5eWpncWQ3bXp3N2ZhNjZiN3k3eDVsaXp6dDRpbGhjaWR3YmZzbW16cW5pZDZucQ==")
$headers1.Add("Cookie", "VstsSession=%7B%22PersistentSessionId%22%3A%22717216fa-2446-4f86-a8bd-8635ebea0c61%22%2C%22PendingAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22CurrentAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22SignInState%22%3A%7B%7D%7D")

#Get List of the ID Hooks to file
$response = Invoke-RestMethod "$url/?api-version=5.0" -Method 'GET' -Headers $headers1 -Body $body1
Remove-Item $PathFile
if ( $response.value.actionDescription -match ".*cetjenkins.cet.ac.il.*" ) {
    $response.value | ForEach-Object {
        Write-Host $_.id
        Add-Content -Path $PathFile -Value $_.id
    }
}

# Update Username and password
foreach($id in [System.IO.File]::ReadLines("$PathFile"))
{
    # Get json body of the hook
    $response1 = Invoke-RestMethod "$url/$id`?api-version=5.0" -Method 'GET' -ContentType "application/json" -Headers $headers1 -Body $body1

    # Modify values by member name:
    $response1.consumerInputs.username = $Username
    $response1.consumerInputs.password = $Password

    # Modify body type
    $body = $response1 | ConvertTo-Json -Depth 100 -Compress
    $body = [System.Text.Encoding]::UTF8.GetBytes($body)
    Write-Host $body

    # Update(PUT) json hook
    $response2 = Invoke-RestMethod "$url/$id`?api-version=5.0" -Method 'PUT' -Headers $headers1 -Body $body
    $response2 | ConvertTo-Json -Compress
    Write-Host "Updated in $id"
    Write-Host " "
    $amount ++
}
Write-Host "Amount Updated" $amount "hooks"