# Decisions I owned (why, not just what)

1. **ECS Fargate over EKS:** coupon service is request/response, bursty, small team. Fargate removes node management, ALB integration is native, autoscaling is simpler. EKS would add control-plane cost + ops without benefit at this scale. Revisit at >20 services or need for Jobs/Cron + service mesh.

2. **Aurora Serverless v2 over RDS provisioned:** spiky BFCM traffic, 0.5–4 ACU autoscaling, pay-per-use. Provisioned would over-provision 80% of year. Tradeoff: cold start ~seconds — mitigated with min 0.5 ACU.

3. **GitHub Actions + OIDC over Jenkins + long-lived keys:** no server to maintain, OIDC eliminates key rotation risk, environments give separate infra approval gate for compliance.

4. **Single NAT in dev, dual NAT in prod:** saves ~$32/mo in dev. Prod uses per-AZ NAT for AZ-failure resilience.

5. **Rolling + circuit breaker over blue-green here:** ALB TG + min 100% healthy gives zero-downtime with instant auto-rollback. Blue-green (Route53 weighted) reserved for breaking schema changes — see runbook.

6. **ECR immutable + Trivy block:** prevents tag mutation attacks, blocks HIGH/CRITICAL before prod.
