# Superset on Minikube (Windows & Linux)

This repository contains scripts and configuration files to deploy **Apache Superset** on Kubernetes using **Minikube** with Docker as the runtime driver. It supports both Windows (PowerShell) and Linux environments.

---

## Repository Structure

superset-on-minikube/
├── README.md # Main guide and instructions
├── my-values.yaml # Your custom Helm values (not included here)
├── scripts/
│ ├── install-tools.ps1 # (Windows) Install Chocolatey, kubectl, Helm, Minikube
│ ├── install-tools.sh # (Linux) Install kubectl, Helm, Minikube
│ ├── gen-secret-key.ps1 # (Windows) Generate Superset SECRET_KEY
│ ├── gen-secret-key.sh # (Linux) Generate Superset SECRET_KEY
│ ├── kubectl-helpers.ps1 # (Windows) Helper commands for Helm and kubectl
│ └── kubectl-helpers.sh # (Linux) Helper commands for Helm and kubectl
├── docs/
│ ├── troubleshooting.md # Troubleshooting guide for Superset on Minikube
│ └── setup-linux.md # (Optional) Linux-specific setup notes
├── .gitignore # Recommended ignores



---

## Prerequisites

- Docker Desktop with Kubernetes enabled (Windows) or Docker installed on Linux
- Minikube
- kubectl
- Helm
- PowerShell (Windows) or bash shell (Linux)
- Git

---

## Setup & Installation

### Step 1: Install required tools

- **Windows:** Run PowerShell as Administrator and execute:
    ```
    ./scripts/install-tools.ps1
    ```

- **Linux:** Run in terminal (may require root or sudo):
    ```
    sudo bash ./scripts/install-tools.sh
    ```

Verify installation by running:
kubectl version --client
helm version
minikube version


---

### Step 2: Start Minikube with Docker driver

- **Windows:**
minikube start --driver=docker


- **Linux:**
minikube start --driver=docker


---

### Step 3: Add Apache Superset Helm repo and update

helm repo add apache https://apache.github.io/superset
helm repo update


---

### Step 4: Prepare your custom Helm values file

Edit or create `my-values.yaml` in the root directory, defining:

- PostgreSQL database credentials
- Superset `SECRET_KEY`
- Any other custom configurations

**Note:** Secrets here must match Kubernetes secrets to avoid authentication errors.

---

### Step 5: Generate a strong SECRET_KEY (optional but recommended)

- **Windows:**
./scripts/gen-secret-key.ps1


- **Linux:**
./scripts/gen-secret-key.sh


### Step 5: Generate a strong SECRET_KEY (optional but recommended)

- **Windows:**
./scripts/gen-secret-key.ps1



- **Linux:**
./scripts/gen-secret-key.sh



Copy the generated key into your `my-values.yaml`.

---

### Step 6: Install Superset Helm chart

helm install superset -f my-values.yaml apache/superset



---

### Step 7: Check Superset pods status

kubectl get pods



---

### Step 8: Access Superset UI

Start port forwarding:

kubectl port-forward service/superset 8088:8088



Then open your browser and navigate to:

http://127.0.0.1:8088



Default login:
- Username: `admin`
- Password: `admin`

(Change login credentials for production use)

---

## Managing Superset

Use the helper scripts for daily operations:

- **Windows:**
Import-Module ./scripts/kubectl-helpers.ps1

Then use commands like:
Get-SupersetPods
PortForward-Superset


- **Linux:**
source ./scripts/kubectl-helpers.sh

Then use commands like:
get_superset_pods
port_forward_superset