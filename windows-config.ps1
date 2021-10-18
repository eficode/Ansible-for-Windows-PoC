# Donwload and run the script that configures a Windows host for remote management with Ansible
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file

#Set-up WinRM listeners and opening the Firewall for the ports required
winrm quickconfig
winrm quickconfig -transport:https

#View current listeners that ate running on the WinRM service
winrm enumerate winrm/config/Listener

#Get the output of the current service configuration options
winrm get winrm/config/Service
winrm get winrm/config/Winrs




