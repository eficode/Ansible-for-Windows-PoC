# Ansible for Windows

## Windows host setup

Run the `windows-config.ps1` powershell script to setup WinRM and make the windows machine ready to communicate with ansible.

## The `main_playbook.yaml`

Will download and install Git in the windows machine.

## When running into errors from the script

Run `Get-NetConnectionProfile` in powershell to check if all the network connections are set to private.
If not, run `Set-NetConnectionProfile` -InterfaceIndex 4 -NetworkCategory 'Private'. Note the interface index number will be different in each situation, this needs to be set based on the index that is returned in the previous command.

