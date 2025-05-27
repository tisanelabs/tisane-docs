Param(
     [Parameter(Mandatory = $true, HelpMessage="Instance count: ")][int] $instances,
     [Parameter(Mandatory = $false, HelpMessage="Windows user: ")][String] $winuser = 'Administrator'
   )

$DOWNLOAD_FOLDER = "C:\Users\$winuser\Downloads\Tisane"
$TISANE_ROOT = "C:\Tisane"

if(-not(Test-Path($DOWNLOAD_FOLDER))) {
    # file with path $path doesn't exist
  mkdir $DOWNLOAD_FOLDER
}

if(Test-Path($TISANE_ROOT)) {
  #mkdir $TISANE_ROOT
  #Remove-Item -Path $TISANE_ROOT -Recurse
}

#Add-Type -AssemblyName System.IO.Compression.FileSystem

Write-Host "Extracting Tisane data to $TISANE_ROOT..." -ForegroundColor Green

Expand-Archive -LiteralPath "$DOWNLOAD_FOLDER\tisane_db.zip" -DestinationPath $TISANE_ROOT

$portNumber = 3781
For ($i=1; $i -le $instances; $i++) {
  $formattedI = $i | % tostring 00
  $portNumber = 3779 + $i
  Write-Host "Creating instance under $TISANE_ROOT\instance$formattedI" -ForegroundColor Green
  Expand-Archive -LiteralPath "$DOWNLOAD_FOLDER\tisane_ws.zip" -DestinationPath "$TISANE_ROOT\instance$formattedI" -Force
  ((Get-Content -path "$TISANE_ROOT\instance$formattedI\Tisane.Runtime.Service.dll.config" -Raw) -replace '3780',"$portNumber") | Set-Content -Path "$TISANE_ROOT\instance$formattedI\Tisane.Runtime.Service.dll.config"
  Start-Process -FilePath "$TISANE_ROOT\instance$formattedI\Tisane.Runtime.Service.exe" -ArgumentList "-i" -Wait
}
# now open firewall ports
netsh advfirewall firewall add rule name='Tisane ports' dir=in protocol=tcp localport="3780-$portNumber" action=allow profile=any

# start the services
Start-Service "Tisane Runtime *"
