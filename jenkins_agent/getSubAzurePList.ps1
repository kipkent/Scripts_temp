$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Basic QmFzaWM6Y25rZjV5eWpncWQ3bXp3N2ZhNjZiN3k3eDVsaXp6dDRpbGhjaWR3YmZzbW16cW5pZDZucQ==")
$headers.Add("Cookie", "VstsSession=%7B%22PersistentSessionId%22%3A%22717216fa-2446-4f86-a8bd-8635ebea0c61%22%2C%22PendingAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22CurrentAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22SignInState%22%3A%7B%7D%7D")
$PathFile = "C:\Users\AlexK\PycharmProjects\untitled1\DevOps\Scripts_temp\jenkins\"
$response = Invoke-RestMethod 'https://dev.azure.com/CET-Tech//_apis/hooks/subscriptions/?api-version=5.0' -Method 'GET' -Headers $headers -Body $body



Remove-Item $PathFile\idlist.txt

if ( $response.value.actionDescription -match ".*cetjenkins.cet.ac.il.*" ) {
    $response.value | ForEach-Object {
        Write-Host $_.id
        Add-Content -Path $PathFile\idlist.txt -Value $_.id
    }
}