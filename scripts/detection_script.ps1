function detect_sophos(){
    $service = Get-Service -Name "Sophos Endpoint Defense Service"
    $file = "C:\Program Files\Sophos\Endpoint Defense\SEDService.exe"

    if (($service) -and ($file)){
        Write-Output "Sophos is installed, exiting"
        #exit 0
    } else {
        #exit 1
    }
}

detect_sophos
