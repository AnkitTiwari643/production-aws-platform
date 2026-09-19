# Cost (ap-south-1 approx, destroy when idle)

Dev (defaults): Fargate 2x 0.25vCPU/0.5GB ~$15/mo + ALB ~$18/mo + NAT single ~$32/mo + Aurora Serverless 0.5 ACU ~$20/mo + ECR/logs <$2 = **~$85/mo, ~$45/mo with NAT removed when idle**.

Ways I keep it cheap:
- `single_nat=true` in dev, `terraform destroy` after demo
- Aurora min 0.5 ACU, scale to 0 not supported but pauses low
- ECR lifecycle keeps 20 images

Prod sizing: 3x 0.5vCPU/1GB + dual NAT + Aurora 0.5–4 ACU ≈ $220–350/mo before data transfer. Right-size via CPU/mem utilization analysis.
