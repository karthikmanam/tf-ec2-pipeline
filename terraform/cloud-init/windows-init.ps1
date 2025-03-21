<powershell>
# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install software
choco install -y awscli
choco install -y 7zip
choco install -y notepadplusplus
choco install -y vscode

# Create a welcome message
$welcomeMessage = @"
************************************************************
*    This server is managed by Terraform - DO NOT MODIFY   *
*    Environment: ${environment}                           *
************************************************************
"@

Set-Content -Path C:\welcome.txt -Value $welcomeMessage

# Rename the computer
Rename-Computer -NewName "${hostname}" -Force

# Enable and configure WinRM (if needed)
Enable-PSRemoting -Force

# Set Explorer to show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

# Log completion
"Setup completed - $(Get-Date)" | Out-File C:\cloud-init-completion.log -Append
</powershell>
