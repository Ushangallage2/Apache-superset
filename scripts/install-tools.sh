#!/bin/bash
# install-tools.sh
# Installs kubectl, Helm, and Minikube on Linux for the Superset on Minikube setup.
# Run with: sudo bash scripts/install-tools.sh

set -e

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube

echo "All tools installed successfully."
echo "Verify with: kubectl version --client && helm version && minikube version"
