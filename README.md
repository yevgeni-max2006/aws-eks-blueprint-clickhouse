<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/56106d58-8d82-4070-87b9-2043ceb75287" />



## AWS | EKS BluePrint ClickHouse
MiniStack is a free, open-source local AWS cloud emulator designed to help developers build and test applications offline without hitting real AWS infrastructure. It serves as a drop-in community replacement for LocalStack, which transitioned core parts of its service behind paid plans



🎯 Architecture Overview
```
✅ VPC containing , Public+Private Subnets , NAT Gateway
✅ EKS Cluster Provisioner Workflow 
✅ Minio S3 Object Storage 
✅ Velero Disaster Recovery
✅ Velero UI Interface
✅ Local Exec ( Logical Workloads )
```


🧱 Features
```
✔ Fully automated provisioning with Terraform
✔ High availability using multiple subnets in different Availability Zones
✔ Secure connectivity between Application and RDS
✔ Configurable environment variables for database credentials
✔ Easy to extend for other JSON data source
```



🚀 Deployment Options
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

