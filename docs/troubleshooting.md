# Troubleshooting Superset on Minikube

This document outlines common problems and how to fix them when running Apache Superset on Minikube.

---

## 1. Superset UI Not Loading or Pod Fails to Start

- Check pod status:
kubectl get pods


- View logs of the init DB job:
kubectl logs superset-init-db-<pod_id>


- If pods are CrashLoopBackOff, check logs for errors.

- Check Helm release status:
helm list


- Delete stuck Helm jobs:
kubectl delete jobs -l "release=superset"



---

## 2. Database Authentication Errors

- Check password stored in Kubernetes secret:
kubectl get secret superset-postgresql -o yaml


- Decode password:
echo 'base64string_here' | base64 --decode


- Ensure password in `my-values.yaml` matches the secret.
- If password changed but data stays old, delete PVC and reinstall Superset:

kubectl delete pvc -l app=superset-postgresql
helm upgrade --install superset apache/superset -f my-values.yaml



---

## 3. Resetting Superset Database Completely

- Delete PVC (loses all data):
kubectl delete pvc -l app=superset-postgresql


- Reinstall Superset Helm chart.

---

## 4. Helm Rollback Issues

- List Helm releases:
helm list


- Rollback to previous revision:
helm rollback superset <revision_number>



---

## 5. Port Forwarding Problems

- Confirm Superset service is running:
kubectl get svc superset


- Port forward:
kubectl port-forward service/superset 8088:8088


- Check if port 8088 is free or use another.

---

## 6. Generating Strong SECRET_KEY

- Windows PowerShell:
[Convert]::ToBase64String((1..42 | ForEach-Object {Get-Random -Minimum 0 -Maximum 255} | ForEach-Object {[byte]$_}))


- Linux/macOS:
openssl rand -base64 42



---

## 7. Connecting to PostgreSQL Directly

kubectl exec -it superset-postgresql-0 -- psql -U postgres -W



Use this for database debugging and direct queries.

---

## 8. Upgrade your Apache Superset version when deployed via Helm on Kubernetes 





## Additional Tips

- Always keep secrets synchronized between Helm values and Kubernetes secrets.
- Restart Minikube if Kubernetes behaves unexpectedly:
minikube stop
minikube start --driver=docker


- Clean up stuck resources before retrying deployments.

---

This troubleshooting guide is continuously updated based on community feedback.