### Extra Credit: Remote Backend Setup (S3 + DynamoDB)

In this section, we have demonstrated how to configure Terraform to use **AWS S3** for storing state files and **DynamoDB** for state locking. This ensures that your Terraform state is securely stored and that multiple users or automation tools can safely interact with it.

### **Important Note**:

Before using the `backend.tf` file in your Terraform project, **ensure that the S3 bucket and DynamoDB table are already created**. If these resources are not present, Terraform will not be able to store the state file because it won't find the required S3 bucket or the DynamoDB table for state locking.

You must manually create these resources before proceeding with the configuration in `backend.tf`. See the steps below to create them.

You have to add this backend.tf file in the terraform root directory and follow below mentioned steps. I just added here because it was extra credit work.

### Steps Taken:

1. **S3 Bucket for Terraform State**:
We created an S3 bucket to store the Terraform state file remotely. This allows for better collaboration and easier recovery of the state in case of issues.

Create the S3 Bucket for Terraform State

You also need to create the **S3 bucket** where Terraform will store the state file. You can do this using the AWS Console or the AWS CLI:

```bash
aws s3api create-bucket --bucket simple-time-service-terraform-state --region ap-south-1
```

Make sure the S3 bucket name is unique (i.e., no other AWS account can use the same name).

1. **DynamoDB Table for State Locking**:
A DynamoDB table was created to manage state locking. This prevents concurrent updates to the Terraform state, ensuring safe deployment and updates.

Create the DynamoDB Table for State Locking

Before initializing the remote backend, you need to create the **DynamoDB table** to enable state locking.

Go to the AWS Console or use AWS CLI to create the table. Here's how to do it using the AWS CLI:

```bash
aws dynamodb create-table \
  --table-name simple-time-service-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
  --region ap-south-1

```

This command creates a DynamoDB table with the necessary schema for state locking.

1. **Backend Configuration**:
A backend configuration (`backend.tf`) was added to point Terraform to the S3 bucket for state storage and DynamoDB table for locking.
2. Initialize the Terraform Backend

Now that the S3 bucket and DynamoDB table are set up, you can initialize the Terraform backend by running the following command:

```bash
terraform init

```

Terraform will automatically configure itself to use the remote backend for storing the state file and will use DynamoDB for locking.

5. Deploy the Infrastructure with Remote State

Once the backend is configured, you can run Terraform commands like `terraform plan` and `terraform apply` as usual. Terraform will use the remote S3 backend to store the state and DynamoDB to lock the state.

For example:

```bash
terraform plan
terraform apply
```

The state will now be stored in the S3 bucket, and the state locking will be managed by DynamoDB, ensuring safe, concurrent access to the state file.

1.  Clean Up Resources

After testing, you can clean up the resources by running:

```bash
terraform destroy
```

This will delete all the infrastructure, including the S3 bucket and DynamoDB table. You will need to delete the S3 bucket manually if you want to clean it up, as Terraform doesn’t delete the state bucket by default.