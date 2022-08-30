
<#
.SYNOPSIS
place_holder
.DESCRIPTION
place_holder
.PARAMETER client_id
place_holder
.PARAMETER client_secret
place_holder
.EXAMPLE
place_holder
.NOTES
place_holder
.LINK
place_holder
.LINK
place_holder
#>


function get_access_token(){
    $auth_success = $false
    $uri = "https://id.sophos.com/api/v2/oauth2/token";
    $client_id = $client_id
    $client_secret = $client_secret

    $header = @{
        content_type = 'application/x-www-form-urlencoded'
    }

    $body = @{
        client_id = $client_id
        client_secret = $client_secret
        grant_type = 'client_credentials'
        scope = 'token'
    }

    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $header -Body $body
        $access_token = $response.access_token
        $auth_success = $true
        return $access_token
    } catch {
        $auth_success = $false
        Write-Host -ForegroundColor Red "ERROR - Unable to get an access token."
    }
}
function get_tenant_id(){
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory=$true)][String]$bearer_token
    )
    $uri = "https://api.central.sophos.com/whoami/v1"

    $header = @{
        Authorization = "Bearer $bearer_token"
    }

    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $header
    $data = @{
        tenant_id = $response.id
        data_region = $response.apiHosts.dataRegion
    }

    return $data
}

function get_installer_url(){
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory=$true)][String]$bearer_token,
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory=$true)][String]$data_region,
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory=$true)][String]$tenant_id,
        [ValidateSet('windows','linux','macOS')]
        [Parameter(Mandatory=$false,HelpMessage="Operating System Platform. Can be one of: windows, linux, or macOS")][String]$platform,
        [ValidateSet('coreAgent','interceptX','xdr','endpointProtection','deviceEncryption','mtr','mtd','ztna')]
        [Parameter(Mandatory=$false)][String]$requested_products
    )
    $base_uri = $data_region+"/endpoint/v1/downloads"
    $uri = $base_uri
    $platform = @()

    if ($platform) {
        $uri = $base_uri+"?"
        function addToArray($platform){
            foreach ($a in $platform){
                "platforms=$a&"
            }
        }
    }

    $header = @{
        'X-Tenant-ID' = $tenant_id
        Authorization = "Bearer $bearer_token"
        Accept = 'application/json'
    }
    $response = Invoke-RestMethod -Uri $endpoint_uri -Method Get -Headers $header
    $data = $response | ConvertTo-JSON
    return $data
}

$bearer_token = Invoke-Expression get_access_token
$tenant_id = get_tenant_id -bearer_token $bearer_token | Select-Object -ExpandProperty tenant_id
$data_region = get_tenant_id -bearer_token $bearer_token | Select-Object -ExpandProperty data_region
$installer = get_installer_url -bearer_token $bearer_token -data_region $data_region -tenant_id $tenant_id

Write-Output $installer
