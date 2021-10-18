# Ansible for Windows

## Setting up a Windows host

1. Ansible requires PowerShell 3.0 or newer and at least .NET 4.0 to communicate and manage a Windows host.
If the version of powershell you are running is 3.0, execute the `memory-hotfix.ps1` script.
This will fix a bug that limits the amount of memory available to WinRM.
Use `Get-Host | Select-Object Version` in the powershell to check the current version.

2. Run the `windows-config.ps1` powershell script to setup WinRM and make the windows machine ready to communicate with ansible.

## If running into errors from the windows-config script

1. Run `Get-NetConnectionProfile` in powershell to check if all the network connections are set to private.
If not, run `Set-NetConnectionProfile -InterfaceIndex 4 -NetworkCategory 'Private'`. Note: the interface index number will be different in each situation, this needs to be set based on the index that is returned in the previous command.

2. If the error continues, disable the WSL network adapter and other Hyper-v adapters existing in the host and run the script again. Note: Remember to enable the adapters when finished.

## Update the inventory file
Open the inventory file and under the `own_windows` group paste the IP address of your windows machine.

## Update the own_windows/vars file
Open the group_vars/own_windows directory and replace `ansible_user` and `ansible_password` with your windows username and password in the `vars` file.

## The `main_playbook.yaml`

If the setup was successful the playbook will authenticate into the host, download and install Git in the windows machine.

