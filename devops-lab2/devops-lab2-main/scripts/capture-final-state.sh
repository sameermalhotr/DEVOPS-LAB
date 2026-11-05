#!/usr/bin/env bash
set -euo pipefail

mkdir -p docs/logs

{
  echo '=== DATE ==='
  date -Is
  echo
  echo '=== UBUNTU ==='
  lsb_release -a 2>&1 || true
  echo
  echo '=== DOCKER ==='
  docker --version
  docker compose version
  echo
  echo '=== DOCKER IMAGES ==='
  docker images | grep -E 'REPOSITORY|devops-lab2' || true
  echo
  echo '=== KUBECTL / MINIKUBE ==='
  kubectl version --client
  minikube version
  echo
  echo '=== KUBERNETES NODE ==='
  kubectl get nodes -o wide
  echo
  echo '=== DEPLOYMENT ==='
  kubectl get deployment devops-lab2 -o wide
  echo
  echo '=== PODS ==='
  kubectl get pods -o wide
  echo
  echo '=== SERVICES ==='
  kubectl get services
  echo
  echo '=== DEPLOYMENT IMAGE ==='
  kubectl get deployment devops-lab2 -o jsonpath='{.spec.template.spec.containers[0].image}'; echo
  echo
  echo '=== ROLLOUT HISTORY ==='
  kubectl rollout history deployment/devops-lab2
  echo
  echo '=== GIT ==='
  git status
  git log --oneline --decorate --graph -10
} | tee docs/logs/final-state.txt

echo
printf 'Saved final state to docs/logs/final-state.txt\n'
