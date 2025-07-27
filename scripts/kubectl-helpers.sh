#!/bin/bash
# kubectl-helpers.sh
# Helper functions for managing Superset on Kubernetes with Minikube (Linux)

function get_superset_pods() {
  echo "Listing Superset pods:"
  kubectl get pods -l app.kubernetes.io/name=superset
}

function get_db_init_logs() {
  local pod_name=$1
  if [ -z "$pod_name" ]; then
    pod_name=$(kubectl get pods -l job-name=superset-init-db -o jsonpath='{.items[0].metadata.name}')
    if [ -z "$pod_name" ]; then
      echo "No superset-init-db job pod found."
      return 1
    fi
  fi

  echo "Logs from pod $pod_name:"
  kubectl logs $pod_name
}

function delete_stuck_helm_jobs() {
  echo "Deleting stuck Helm jobs for release 'superset'..."
  kubectl delete jobs -l "release=superset"
}

function list_helm_releases() {
  echo "Listing Helm releases:"
  helm list
}

function rollback_superset() {
  local revision=$1
  if [ -z "$revision" ]; then
    echo "Usage: rollback_superset <revision>"
    return 1
  fi
  echo "Rolling back Superset Helm release to revision $revision"
  helm rollback superset $revision
}

function port_forward_superset() {
  echo "Port-forwarding Superset service to localhost:8088"
  kubectl port-forward service/superset 8088:8088
}

function exec_postgres() {
  local pod=$(kubectl get pods -l app=superset-postgresql -o jsonpath='{.items[0].metadata.name}')
  if [ -z "$pod" ]; then
    echo "No PostgreSQL pod found."
    return 1
  fi
  echo "Starting interactive psql session on pod $pod"
  kubectl exec -it $pod -- psql -U postgres -W
}

function show_postgres_secret() {
  echo "Displaying Kubernetes secret for superset-postgresql:"
  kubectl get secret superset-postgresql -o yaml
}

echo -e "\nAvailable functions:"
echo "  get_superset_pods"
echo "  get_db_init_logs [pod_name]"
echo "  delete_stuck_helm_jobs"
echo "  list_helm_releases"
echo "  rollback_superset <revision>"
echo "  port_forward_superset"
echo "  exec_postgres"
echo "  show_postgres_secret"
