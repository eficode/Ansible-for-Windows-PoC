$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file

Set-NetConnectionProfile -InterfaceIndex 4 -NetworkCategory 'Private'

winrm quickconfig

Set-Item -Force WSMan:\localhost\Client\Allowunencrypted $True
Set-Item -Force WSMan:\localhost\Service\Allowunencrypted $True
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
