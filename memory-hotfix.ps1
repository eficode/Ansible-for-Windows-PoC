#When running on PowerShell v3.0, there is a bug with the WinRM service that limits the amount of memory available to WinRM.
#Without this hotfix installed, Ansible will fail to execute certain commands on the Windows host.

#Install the hotfix
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Install-WMF3Hotfix.ps1"
$file = "$env:temp\Install-WMF3Hotfix.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file -Verbose