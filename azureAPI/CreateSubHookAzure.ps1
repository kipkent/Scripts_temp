#Params
$url = "https://dev.azure.com/example//_apis"
$Path = "$/MyBag/main"
$personalToken = "example"
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalToken)"))
#headers
$headers1 = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers1.Add("Content-Type", "application/json")
$headers1.Add("Authorization", "Basic $token")
$headers1.Add("Cookie", "VstsSession=%7B%22PersistentSessionId%22%3A%22717216fa-2446-4f86-a8bd-8635ebea0c61%22%2C%22PendingAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22CurrentAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22SignInState%22%3A%7B%7D%7D")

#Get ID of the project Team
#$response = Invoke-RestMethod "$url/teams?api-version=6.0-preview.3" -Method 'GET' -Headers $headers1 -Body $body1
$response = Invoke-RestMethod -Uri "$url/projects/MyBag" -Method 'GET' -Headers $headers1 -Body $body1
write-host $response

foreach ($name in $response) {
#foreach ($name in $response.value) {
    if ( $name.projectName -match "MyBag" ) {
        write-host "$($name.projectName) - $($name.projectId)"
        $ID = $($name.projectId)
    }
}
write-host $ID
$body = "{
`n    `"publisherId`": `"tfs`",
`n    `"eventType`": `"tfvc.checkin`",
`n    `"subscriber`": null,
`n    `"resourceVersion`": null,
`n	`"eventDescription`": `"Path $/MyBag/main.`",
`n    `"consumerId`": `"jenkins`",
`n    `"consumerActionId`": `"triggerGenericBuild`",
`n    `"publisherInputs`": {
`n        `"path`": `"$Path`",
`n        `"projectId`": `"$ID`"
`n    },
`n    `"consumerInputs`": {
`n        `"buildName`": `"test_alex3`",
`n        `"serverBaseUrl`": `"http://cetjenkins.cet.ac.il:8080/`",
`n        `"username`": `"jenkinshooks`",
`n        `"useTfsPlugin`": `"tfs-plugin`",
`n        `"password`": `"112f7212612b12c65de2df82b1b77548d8`"
`n    }
`n}"

# POST json hook
$response2 = Invoke-RestMethod "$url/hooks/subscriptions?api-version=6.0" -Method 'POST' -Headers $headers1 -Body $body
$response2 | ConvertTo-Json -Compress
Write-Host "Created Hook with $Path"