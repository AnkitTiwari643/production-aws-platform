# DR / Failover runbook — I own this on-call

## Symptoms
ALB 5xx alarm or healthy-host-count < 50% for 2 min.

## Triage (5 min)
1. `aws ecs describe-services --cluster coupon-platform-dev --services coupon-platform-dev-svc`
2. Check CloudWatch: ALB TargetResponseTime, ECS CPU, RDS connections
3. Check ECR: was a bad image just deployed? `aws ecs describe-task-definition`

## Rollback release (instant)
```bash
# ECS auto-rollback is on via circuit breaker. If needed, force previous task def:
aws ecs update-service --cluster <cluster> --service <svc> --task-definition <prev-family:rev> --force-new-deployment
```

## Infra rollback
```bash
cd terraform
git log --oneline -5
git revert <bad-commit>
terraform apply -var-file=envs/prod.tfvars
```

## Multi-region note (resume BFCM scope)
This demo is single-region. Prod pattern I owned: active-active + Route53 health checks. To extend: duplicate stack in second region, Route53 latency/failover routing, Aurora Global DB. RTO target <60s, verified by game-day killing primary tasks.
