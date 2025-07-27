<#
.SYNOPSIS
    Installs Chocolatey (if needed), kubectl, Minikube, and Helm on Windows using Chocolatey.

.DESCRIPTION
    This script automates setup of required tools for Superset on Kubernetes with Minikube on Windows.
    Must be run in PowerShell **as Administrator**.

#>

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Install Chocolatey if not installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Chocolatey not found. Installing Chocolatey..."
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Output "Chocolatey is already installed."
}

# Update environment path to recognize choco in this session (optional)
$env:Path += ";$([Environment]::GetEnvironmentVariable('ChocolateyInstall'))\bin"

Write-Output "Installing Kubernetes CLI (kubectl)..."
choco install kubernetes-cli -y

Write-Output "Installing Minikube..."
choco install minikube -y

Write-Output "Installing Helm..."
choco install kubernetes-helm -y

Write-Output "Installation complete. You may need to restart your PowerShell or computer for changes to take effect."
