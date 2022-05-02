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

Run `ansible-playbook main_playbook.yaml`. If the setup was successful the playbook will authenticate into the host, download and install Git in the windows machine.

## PoC Considerations

Unlike Linux/Unix hosts that use SSH by default, Windows hosts use WinRM with Ansible. WinRM is a management protocol used by Windows to remotely communicate with another server over HTTP/HTTPS. Since 2012 WinRM is enabled by default on a Windows machine, however it requires extra configuration to use with Ansible. After having the host configuration ready some options are given for connecting to a Windows host. Basic authentication is the simplest one, the security can be improved by using HTTPS as channel, and enabling this option is part of the initial script used to get the host ready for Ansible. No problems were found in using this method out-of-the-box in standard Windows machines.

Another authentication option is CredSSP, which is a protocol that allows credential delegation. The username and password are encrypted after successfully authenticating and sent to the server. This protocol supports message encryption over HTTP. CredSSP is not enabled by default but can be enabled by running a PowerShell command in the host. Similarly to the previous attempt, no problems were found in using this method out-of-the-box in standard Windows machines.

During the tests in the Entreprise IT managed computers we ran into two main challenges when trying to connect with the WinRM:
1. Due to in-place group security policies we could not enable the Basic authentication method.
2. It was possible to enable the CredSSP option, however the IP address of the host was still unreachable because the authentication could not be done successfully.

