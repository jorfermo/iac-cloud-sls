# Example project using terraform, serverless and cloud services with different languages

## Deployment

Deployment is done using terraform for the infrastructure:

- DynamoDB databases
- S3 buckets

```bash
cd infrastructure
tfswitch
terraform init
terraform plan
terraform apply
```

And serverless framework for cloud services:

- Lambdas
- Lambda layers
- API Gateway
- SQS Queues
- Event bridge rules
- Cloudwatch alerts

```bash
serverless deploy
```
