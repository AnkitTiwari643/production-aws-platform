# Push to GitHub — 3 minutes (gh not installed on this machine, so create manually)

Your project is committed locally and validated (`terraform validate = Success`):
`production-aws-platform/` on branch `master`, 1 commit, 29 files.

## Option A — fastest (no CLI install)

1. Go to https://github.com/new
   - Repository name: `production-aws-platform`
   - Public, do NOT add README/.gitignore/license
   - Create repository. Copy the https URL, e.g. `https://github.com/AnkitTiwari643/production-aws-platform.git`

2. In PowerShell, from this folder:
```powershell
Set-Location -LiteralPath "C:\Users\harid\Documents\Default Project\production-aws-platform"
git remote add origin https://github.com/AnkitTiwari643/production-aws-platform.git
git branch -M main
git push -u origin main
```

3. Tell me your username + repo URL. I will:
   - replace all `AnkitTiwari643` in README/terraform/.github with your real username
   - amend + push
   - update `ANKIT_KUMAR_TIWARI_Resume_Owner.md` Projects link to the live repo
   - re-commit

## Option B — install gh (so I can create for you next turn)

1. Install from https://cli.github.com/ (Windows installer)
2. Then in PowerShell:
```powershell
gh auth login
gh repo create production-aws-platform --public --source="C:\Users\harid\Documents\Default Project\production-aws-platform" --push
```
3. Paste the resulting URL here and I will finalize the resume links.

## After push — required repo settings to prove compliance gates

- Settings > Environments > New environment `prod` > Required reviewers: add yourself (enforces infra approval gate)
- Settings > Branches > Add rule for `main`: Require pull request (2 approvals) + Require status checks (`plan`, `validate`)
- Settings > Secrets > Actions: add `AWS_ROLE_ARN`, `AWS_REGION`, `ECR_URL` (from `terraform output` after apply)

## Replace placeholders before interview

Search in repo for `AnkitTiwari643` (6 files) and replace with your GitHub username.
