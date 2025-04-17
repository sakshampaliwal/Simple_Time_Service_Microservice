
# Simple Time Service

This project is a simple service built using Python, Docker, and deployed on AWS using Terraform. The project provides an API that returns the current time, and it's deployed using ECS (Elastic Container Service) with an Application Load Balancer (ALB) in AWS.

## Prerequisites

Before starting, make sure you have the following installed and set up:

- **Docker**: To build and run the application locally.
- **Terraform**: For managing the infrastructure on AWS.
- **AWS CLI**: To interact with AWS and configure credentials.
- **AWS Account**: You need an active AWS account for deploying the resources.
---

## **Task 1 - Minimalist Application Development / Docker**

## Step 1: Clone the Repository

Clone the repository to your local machine using Git:

```bash
git clone https://github.com/yourusername/simple-time-service.git
cd simple-time-service
```

## Step 2: Set Up Docker for Local Development (Using My Public Image)

### 2.1 Run the Public Docker Image

Instead of building the Docker image locally, you can use the public image available on Amazon ECR. This simplifies the setup for testing the application locally.

Run the following command to pull and run the public image:

```bash
docker run -p 5000:5000 public.ecr.aws/x9i9z9i1/simple-time-service:latest

```

This will pull the image from the public ECR registry and start the container. The application will be accessible locally at:

```
http://localhost:5000

```

You should see a JSON response like:

```json
{"ip":"172.17.0.1","timestamp":"2025-04-17T09:24:39.162135"}
```

### 2.2 Test the Application Locally

Once the container is running, navigate to the following URL in your browser or use `curl` to test it:

```
http://localhost:5000

```

Or using `curl`:

```bash
curl http://localhost:5000

```

This will return the current time in a JSON format.

---

## **Task 2 - Terraform and Cloud: create the infrastructure to host your container.**

## Step 1: Set Up AWS Credentials

Before deploying the infrastructure, make sure you have AWS credentials set up on your machine. If you don't have AWS CLI installed, you can install it following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

Once installed, configure your AWS credentials:

```bash
aws configure
```

You will be prompted to enter your AWS Access Key, Secret Key, region, and output format. Make sure to select the region where you want to deploy the infrastructure. If having problem in generating the access key [follow this](https://docs.aws.amazon.com/keyspaces/latest/devguide/create.keypair.html).

If you don't have Terraform installed, you can download it from the [official website](https://www.terraform.io/downloads.html). Once downloaded, follow the installation instructions for your operating system.

## Step 2: Deploy the Infrastructure with Terraform

### 2.1 Initialize Terraform

Navigate to the `terraform/` directory:

```bash
cd terraform
```

Run the following command to initialize Terraform. This will download the necessary provider plugins and set up the working directory:

```bash
terraform init
```

### 2.2 Configure Variables

Edit the `terraform.tfvars` file to specify values for the variables. For example:

```hcl
aws_region = "ap-south-1"
vpc_name   = "simple-time-service-vpc"
```

You can customize the values based on your needs.

### 2.3 Apply the Terraform Configuration

Once you’ve initialized Terraform and configured the variables, apply the Terraform plan to create the necessary resources:

```bash
terraform apply
```

Terraform will show you a plan of what resources it will create (such as VPC, ECS, ALB). Type `yes` to proceed with the creation of the resources.

### 2.4 Wait for the Deployment to Finish

Terraform will now create all the resources in AWS. This may take a few minutes. Once it's finished, Terraform will output a URL for your application, something like:

```bash
Application URL: http://<alb_dns_name>
```

## Step 3: Access the Deployed Application

Once the deployment is complete, Terraform will provide the URL for the Application Load Balancer (ALB). You can use this URL to access your deployed application.

Navigate to the provided URL in your browser:

```
http://<alb_dns_name>
```

You should see the current time returned as a JSON response.

```json
{"ip":"172.17.0.1","timestamp":"2025-04-17T09:24:39.162135"}

```

## Step 4: Clean Up Resources

To avoid incurring ongoing charges in AWS, you can destroy the resources once you're done testing by running:

```bash
terraform destroy

```

This will remove all the infrastructure that was created by Terraform.

## Troubleshooting

- **Docker Issues**: If you're having trouble building the Docker image, ensure that Docker is running and there are no port conflicts on your local machine.
- **Terraform Errors**: If Terraform fails during the `apply` step, double-check your AWS credentials and ensure your IAM user has the necessary permissions to create the resources.
- **Application Errors**: If the application is not responding correctly on AWS, check the ECS logs and ALB configuration for any issues.

---

