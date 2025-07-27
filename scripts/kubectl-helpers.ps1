<#
.SYNOPSIS
    Helper functions for managing Superset deployment on Kubernetes using kubectl & Helm.

.DESCRIPTION
    Collection of useful commands wrapped as PowerShell functions for easier usage.

#>

function Get-SupersetPods {
    Write-Output "Listing Superset pods:"
    kubectl get pods -l app.kubernetes.io/name=superset
}

function Get-DBInitLogs {
    param (
        [string]$podName = ""
    )
    if (-not $podName) {
        $podName = kubectl get pods -l job-name=superset-init-db -o jsonpath='{.items[0].metadata.name}'
        if (-not $podName) {
            Write-Output "No superset-init-db job pod found."
            return
        }
    }
    Write-Output "Fetching logs for pod: $podName"
    kubectl logs $podName
}

function Delete-StuckHelmJobs {
    Write-Output "Deleting stuck Helm jobs for release 'superset'..."
    kubectl delete jobs -l "release=superset"
}

function List-HelmReleases {
    Write-Output "Listing Helm releases:"
    helm list
}

function Rollback-Superset {
    param (
        [Parameter(Mandatory=$true)]
        [int]$revision
    )
    Write-Output "Rolling back Superset Helm release to revision $revision"
    helm rollback superset $revision
}

function PortForward-Superset {
    Write-Output "Starting port-forward to Superset service on localhost:8088"
    kubectl port-forward service/superset 8088:8088
}

function Exec-Postgres {
    $pod = kubectl get pods -l app=superset-postgresql -o jsonpath='{.items[0].metadata.name}'
    if (-not $pod) {
        Write-Output "No PostgreSQL pod found."
        return
    }
    Write-Output "Starting interactive psql session on pod $pod"
    kubectl exec -it $pod -- psql -U postgres -W
}

function Show-PostgresSecret {
    Write-Output "Displaying Kubernetes secret for superset-postgresql"
    kubectl get secret superset-postgresql -o yaml
}

Write-Output "`nAvailable functions:"
Write-Output "  Get-SupersetPods"
Write-Output "  Get-DBInitLogs [-podName <pod_name>]"
Write-Output "  Delete-StuckHelmJobs"
Write-Output "  List-HelmReleases"
Write-Output "  Rollback-Superset -revision <number>"
Write-Output "  PortForward-Superset"
Write-Output "  Exec-Postgres"
Write-Output "  Show-PostgresSecret"
