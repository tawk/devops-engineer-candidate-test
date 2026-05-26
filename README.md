# DevOps Practical — `api-service`

Welcome. This repository contains a small, **synthetic** service (`api-service`) and the
infrastructure to build, deploy, and provision it. It is modelled on a real-world setup:

- **`app/`** — the service itself + its `Dockerfile`.
- **`helm-charts/api-service/`** — a Helm chart for the workload.
- **`gitops/sandbox/`** — Kustomize that renders the chart for the sandbox, plus the MongoDB it
  talks to (already running in your cluster).
- **`terraform/`** — a module + sandbox config that would provision the MongoDB hosts in GCP.
- **`chef/cookbooks/mongodb/`** — a configuration-management cookbook for the MongoDB hosts.

## The task

**This codebase has problems** — some stop it from building or deploying, some are things you'd
never ship to production, and some are subtle. Your job:

1. **Review, debug, and fix** as many issues as you can.
2. Get the service **building and deploying** into the sandbox cluster first, then **harden** it.
3. **Write down everything you spot in [`FINDINGS.md`](./FINDINGS.md)** — even issues you don't
   have time to fix. We score what you *find and understand*, not just what you fix.

> There is deliberately **more here than anyone can finish** in the time. Don't rush to "done" —
> prioritise, explain your reasoning, and flag risks. Breadth of detection and depth of
> understanding matter more than a green board.

## Your sandbox (already set up on the VM)

- `docker`, `kubectl`, `helm`, `kustomize`, `terraform` are installed.
- A multi-node `kind` cluster is running.
- MongoDB (a single-member replica set `rs0`) is running in the `data` namespace.
- An `apps` namespace exists for the workload.
- You build and load the `api-service` image yourself (see below) once the `Dockerfile` builds.

## Useful commands

```bash
# Make sure you're pointed at the local kind cluster (never a remote one):
kubectl config use-context kind-devops-test

# Build the image (after you fix the Dockerfile), then load it into kind:
docker build -t api-service:sandbox ./app
kind load docker-image api-service:sandbox

# Render + deploy the workload (the chart lives above the overlay, so allow that):
kubectl kustomize --enable-helm --load-restrictor LoadRestrictionsNone \
  gitops/sandbox/api-service | kubectl apply -f -
kubectl -n apps get pods
kubectl -n apps logs deploy/api-service

# Terraform (no cloud access — validate only):
cd terraform/sandbox/mongodb-api-service
terraform init -backend=false
terraform validate
```

Good luck.
