build-push:
	docker build -t coupon-platform ./app
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(ECR_URL)
	docker tag coupon-platform $(ECR_URL):latest
	docker push $(ECR_URL):latest

deploy:
	aws ecs update-service --cluster $(CLUSTER) --service $(SERVICE) --force-new-deployment --region $(AWS_REGION)

plan-dev:
	cd terraform && terraform init && terraform plan -var-file=envs/dev.tfvars

apply-dev:
	cd terraform && terraform apply -var-file=envs/dev.tfvars

destroy-dev:
	cd terraform && terraform destroy -var-file=envs/dev.tfvars
