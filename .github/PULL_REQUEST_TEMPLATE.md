## What
<!-- 1-2 lines -->

## Why
<!-- business / reliability reason -->

## Risk
<!-- what could break, blast radius -->

## Rollback
<!-- exact revert: `git revert`, ECS rollback, `terraform apply` prev tag -->

## Testing
<!-- curl, k6, screenshots -->

## Checklist
- [ ] Trivy clean, ECR immutable tag
- [ ] `terraform plan` reviewed, no unexpected destroys
- [ ] Alarms/dashboard checked post-deploy
