# DevOps Assignment – Infrastructure Provisioning, Deployment Automation, Monitoring and Logging 

## 1. Project Overview                                                                                                                                        

This project demonstrates a complete DevOps setup for a small Flask web application.

The application is deployed on AWS using Terraform. Docker is used to package the application, and GitHub Actions is used to automate testing, security checks, Docker image creation, and deployment.

The project also includes CloudWatch monitoring and centralized logging.

### Main Technologies

* AWS
* Terraform
* Docker
* GitHub Actions
* Docker Hub
* Python Flask
* PostgreSQL
* Amazon CloudWatch
* Amazon S3
* Trivy
* Pytest

---------------------------------------------------------------------------------------------------------

## 2. Architecture Diagram

The basic flow of the application is:

Developer
   |
   v
GitHub Repository
   |
   v
GitHub Actions
   |
    Unit Tests
   |
    Dependency Scan
   |
    Docker Build
   |
    Integration Test
   |
    Trivy Security Scan
   |
   v
Docker Hub
   |
   v
AWS Load Balancer
   |
   v
EC2 Instance
   |
   v
RDS PostgreSQL


Monitoring and logging are handled using Amazon CloudWatch.

ALB access logs are stored in Amazon S3.

----------------------------------------------------------------------------------------------------------------------

## 3. Infrastructure Provisioning

AWS infrastructure is created using Terraform.

The Terraform configuration creates:

* VPC
* Public and private subnets
* Security groups
* EC2 instance
* RDS PostgreSQL
* Application Load Balancer
* Required networking components
* Terraform variables and outputs

### Terraform Commands:

cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy

After deployment, the important resource information can be viewed using:

terraform output

--------------------------------------------------------------------------------------------------------------

## 4. Application

The application is a small Flask API.

A simple health check is available to verify that the application is running.

Example:

http://demo-alb-995554105.ap-south-1.elb.amazonaws.com

Expected response:

{
  "message": "DevOps Assignment Application",
  "status": "running"
}

--------------------------------------------------------------------------------------------------

## 5. Docker

The Flask application is packaged into a Docker image.

Build the image:

docker build -t nikitamishra/flask_image:latest .

Run the application locally:

docker run -d --name flask_app -p 5000:5000 nikitamishra/flask_image:latest

The Docker image is pushed to Docker Hub by the CI/CD pipeline.

---------------------------------------------------------------------------------------------------------

## 6. CI/CD Pipeline

GitHub Actions is used for deployment automation.

### Pipeline Flow

Pull Request
     |
     v
Unit Tests
     |
     v
Dependency Security Scan
     |
     v
Merge to main
     |
     v
Docker Build
     |
     v
Integration Test
     |
     v
Trivy Container Scan
     |
     v
Push Image to Docker Hub
     |
     v
Deploy to Staging
     |
     v
Manual Approval
     |
     v
Production Deployment

### Tests

The pipeline runs:

* Unit tests using Pytest
* Integration tests
* Python dependency security scan using `pip-audit`
* Container vulnerability scan using Trivy

The Docker image is pushed to Docker Hub only after the required checks pass.

### Production Deployment

Production deployment requires manual approval through the GitHub Actions environment.

This prevents an automatic production deployment immediately after every merge.

### Notifications

Email notifications are configured for pipeline results so that deployment failures or successful runs can be identified quickly.

------------------------------------------------------------------------------------------------------------

## 7. Monitoring

Amazon CloudWatch is used for infrastructure and application monitoring.

### Infrastructure Dashboard

Dashboard name: DevOps-Infrastructure

It contains metrics such as:

* EC2 CPU utilization
* EC2 memory usage
* EC2 disk usage
* RDS CPU utilization
* RDS database connections
* RDS free storage

### Application Dashboard

Dashboard name: DevOps-Application

It contains:

* ALB request count
* ALB HTTP 5xx errors
* ALB target response time

These metrics help identify application traffic, errors, and performance issues.

-------------------------------------------------------------------------------------------------------

## 8. Logging

CloudWatch is used for centralized application and system logs.

### Application Logs

CloudWatch log group: /devops-assignment/application

Application logs are collected from: /var/log/devops-app/app.log

### System Logs

CloudWatch log group: /devops-assignment/system

System logs are collected from: /var/log/devops-system.log

### ALB Access Logs

Application Load Balancer access logs are stored in an S3 bucket.

This provides access to request-level information for troubleshooting and analysis.

-----------------------------------------------------------------------------------------------

## 9. Security

The following security practices were implemented:

* AWS resources are deployed inside a VPC.
* Security groups restrict access between components.
* RDS is separated from the public-facing application layer.
* GitHub credentials and deployment secrets are stored using GitHub Secrets.
* Docker Hub authentication uses a token instead of storing credentials in the repository.
* CloudWatch access is provided through an IAM role.
* `pip-audit` is used to check Python dependencies.
* Trivy is used to scan the Docker image.
* Production deployment requires manual approval.
* Sensitive files such as `.pem`, `.key`, `.env`, and Terraform state files are excluded using `.gitignore`.

---------------------------------------------------------------------------------------------------------

## 10. Cost Optimization

The project uses small AWS resources suitable for development and testing.

Cost-saving steps include:

* Using small EC2 and RDS instance types.
* Stopping EC2 when it is not required.
* Stopping RDS when it is not required.
* Avoiding unnecessary AWS services.
* Using Docker and automation instead of maintaining additional servers.
* Removing resources when the assignment is completely finished.

For development work, compute resources can be stopped when they are not being used.

-------------------------------------------------------------------------------------------------------

## 11. Backup Strategy

RDS automated backups are used to protect the PostgreSQL database from accidental data loss.

The backup configuration and retention period are maintained through the AWS RDS configuration.

---------------------------------------------------------------------------------------------------------

## 12. Approach

The project was completed in three main stages.

### Stage 1 – Infrastructure

Terraform was used to create the AWS infrastructure including networking, EC2, RDS, security groups, and the load balancer.

### Stage 2 – Deployment Automation

GitHub Actions was configured to test the application, build the Docker image, perform security checks, push the image to Docker Hub, and deploy the application.

### Stage 3 – Monitoring and Logging

CloudWatch dashboards, metrics, application logs, system logs, and ALB access logs were configured for monitoring and troubleshooting.

-----------------------------------------------------------------------------------------------------------------

## 13. Challenges and Resolutions

### 1. Terraform State Lock

Terraform initially reported an error while acquiring the state lock.

The state issue was investigated and resolved before continuing with Terraform operations.

### 2. Git Merge Conflict

A Git conflict occurred while working on the CI/CD changes.

The conflicting changes were reviewed, the required version was kept, and the rebase was completed successfully.

### 3. CloudWatch Agent Permission Issue

Initially, the CloudWatch Agent could not publish metrics because the EC2 instance did not have the required IAM role.

An IAM role with `CloudWatchAgentServerPolicy` was attached to the EC2 instance.

After this, CloudWatch metrics started working.

### 4. System Log File Issue

The expected `/var/log/messages` file was not available on the Amazon Linux system.

A dedicated system log file was configured and sent to CloudWatch instead.

### 5. ALB Access Log Permission Error

ALB access logs initially failed because the S3 bucket did not allow the required log delivery service to write objects.

An appropriate S3 bucket policy was added, after which ALB access logging worked successfully.

### 6. Integration Testing

The application needed to be running inside a container before the integration test could access it.

The pipeline was configured to start the Docker container, run the integration test, and stop the container afterward.

----------------------------------------------------------------------------------------------------------------------------

## 14. Cleanup

When the assignment is completely finished, AWS resources can be removed using Terraform:

cd terraform
terraform destroy

Before destroying the infrastructure, make sure any required database backup or snapshot has been retained.

-----------------------------------------------------------------------------------------------------------------------

## 15. Repository

Source code, Terraform configuration, Docker configuration, and GitHub Actions workflows are maintained in the project GitHub repository.

The repository contains:

app/
terraform/
.github/workflows/
README.md
.gitignore

This documentation explains the setup, deployment process, monitoring, security practices, cost considerations, and challenges faced during implementation.

### END ###
