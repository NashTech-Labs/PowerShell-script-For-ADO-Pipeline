# this shell script get the pipeline ID  and other configuration from the ADO pipeline 



# just need to pass the few required values from the ADO like organization name, project name, pipeline name and most important PAT token

# Set variables
$organization = "< >"
$project = "< >"
$pipelineName = "< >"
$personalAccessToken = "< >"

# Construct the REST API URL to get the pipeline ID
$url = "https://dev.azure.com/$organization/$project/_apis/pipelines?api-version=6.1-preview.1& $filter=name eq '$pipelineName'"

# Write-Output "data of url - $url"

# Create the authorization header using the personal access token
$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))

Write-Output "Authorization header - $base64AuthInfo"

$headers = @{Authorization = "Basic $base64AuthInfo"}

# Write-Output "Header - $headers"

# Call the REST API to get the pipeline ID
$response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get

# Write-Output "This is the responce $response"

# Get the pipeline ID from the response
$pipelineId = $response.value.id
$pipelineName = $response.value.name
$pipelineUrl = $response.value.url
$pipelineRevision = $response.value.revision

# Write-Output "here $pipelineId"

# Output the pipeline ID
Write-Output "Pipeline ID: $pipelineId"

Write-Output "This is the pipeline Name: $pipelineName "

Write-Output "This is the pipeline url to check the more configuration: $pipelineUrl"

Write-Output "This is the revision of pipeline:  $pipelineRevision"
