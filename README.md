<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/56106d58-8d82-4070-87b9-2043ceb75287" />



## AWS | EKS BluePrint ClickHouse
ClickHouse is a fast, open-source, column-oriented database management system designed for online analytical processing (OLAP) and real-time data analysis using SQL



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
✔ Column-Oriented Storage: Stores values for each column sequentially, reading only the data needed for a query
✔ Extreme Speed: Processes billions of rows in milliseconds using vectorized query execution and hardware optimization.
✔ High Compression: Uses efficient encoding to compress data on disk, saving storage space.
✔ SQL Support: Uses a standard, easy-to-use SQL interface for reporting and complex data aggregation.
```



🚀 Deployment Options
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

