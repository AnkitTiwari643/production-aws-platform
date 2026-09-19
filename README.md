# Production AWS Platform — Proof of Ownership

![CI](https://github.com/AnkitTiwari643/production-aws-platform/actions/workflows/ci.yml/badge.svg)
![Terraform Plan](https://github.com/AnkitTiwari643/production-aws-platform/actions/workflows/terraform-plan.yml/badge.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

> Owner: Ankit Kumar Tiwari — DevOps Engineer (AWS · Terraform · GitHub Actions · ECS)
> This repo proves I can own a production service 0→prod: network, compute, data, CI/CD, security gates, observability, cost, and runbooks.

**Mirrors resume scope:** coupon-service delivery (DNS/ALB/ECS/Aurora via Terraform) + compliance-grade GitHub Actions pipeline (branching, PR approvals, ECR, infra approval gate).

## Architecture

```
GitHub (PR) → terraform plan → require 2 approvals → merge to main → terraform apply (prod env gate)
GitHub (push) → build app → Trivy scan → push ECR → deploy ECS (rolling + ALB health check)
Users → Route53 → ALB (public) → ECS Fargate (private) → Aurora Serverless v2 (private)
                                      ↓ logs/metrics → CloudWatch + alarms → SNS/PagerDuty
```

VPC: 10.0.0.0/16, 2 AZs, public (ALB/NAT) + private (ECS/RDS). Least-privilege SGs. No long-lived AWS keys — GitHub OIDC only.

## Proof artifacts (what a reviewer checks in 5 min)

- `terraform/` — VPC/ALB/ECS/Aurora/ECR/OIDC as code, S3 remote state, `envs/dev.tfvars` + `prod.tfvars`
- `.github/workflows/` — `ci.yml` (build+scan+push), `terraform-plan.yml` (plan on PR + PR comment), `terraform-apply.yml` (apply on main with environment approval)
- `DECISIONS.md` — why ECS Fargate + Aurora Serverless v2 over EKS/RDS-provisioned
- `runbook/DR-failover.md` + `runbook/release-rollback.md` — what I own on-call
- `COST.md` — ~$45–75/mo dev (destroy when idle), prod sizing table
- `load-test/k6.js` — smoke to 500 RPS, pattern for 3k RPS claim

## Run in 10 minutes (dev)

Prereqs: AWS account, Terraform ~>1.9, AWS CLI v2, Node 20, Docker.

```bash
# 1. Backend (once): create S3 + DynamoDB OR use local backend for demo
# Edit terraform/backend.tf if you want local state for interview demo

# 2. Configure
cp terraform/envs/dev.tfvars.example terraform/envs/dev.tfvars  # if present, else edit envs/dev.tfvars
export AWS_REGION=ap-south-1

# 3. OIDC for GitHub Actions (once per account)
cd terraform
terraform init
terraform apply -target=aws_iam_openid_connect_provider.github -var-file=envs/dev.tfvars
# Copy role ARN -> GitHub repo secrets: AWS_ROLE_ARN, AWS_REGION

# 4. Full infra
terraform apply -var-file=envs/dev.tfvars

# 5. App deploy (auto via CI, or manual)
make build-push ECR_URL=$(terraform output -raw ecr_url)
make deploy CLUSTER=$(terraform output -raw ecs_cluster) SERVICE=$(terraform output -raw ecs_service)

# 6. Verify
curl $(terraform output -raw alb_url)/health
k6 run ../load-test/k6.js -e URL=$(terraform output -raw alb_url)

# 7. Cleanup (important for cost)
terraform destroy -var-file=envs/dev.tfvars
```

See `Makefile` for all targets.

## Compliance gates (the owner part)

- OIDC only, no `AWS_ACCESS_KEY` in repo/secrets
- ECR immutable tags + Trivy HIGH/CRITICAL blocks deploy
- Terraform `plan` posts to PR, `apply` requires `prod` environment approval + 2 reviewers (see `.github/CODEOWNERS`)
- Branch protection: `main` requires PR + status checks + linear history
- ALB→ECS health checks + deployment circuit breaker + automatic rollback

## Cost

See `COST.md`. Dev defaults to Fargate 0.25vCPU/0.5GB x2, Aurora Serverless v2 0.5–1 ACU, NAT single-AZ option flag. Destroy when not demoing.

## Replace placeholders

Search `AnkitTiwari643`, `YOUR-ACCOUNT-ID`, `example.com` and replace. Then update resume link to this repo.

## License

MIT — free to review and reproduce.
