# Master 4.0 - Cloud Infrastructure and service - Kinesis example

In order to deploy this architecture on your AWS account, you need to have `terraform` library installed on your machine.
If you don't have it, you can download it [here](https://www.terraform.io/downloads.html).

After installing `terraform`, configure AWS credentials as your environment variables. \
Create an `.env` file at root of the project and fill it with your AWS credentials:
```
export AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY>
export AWS_DEFAULT_REGION=<YOUR_AWS_DEFAULT_REGION>
export AWS_KINESIS_STREAM_NAME=<YOUR_AWS_KINESIS_STREAM_NAME>
```

After creating the `.env` file, source it with the following command:
```bash
source .env
```

Next, go into the `infrastructure` directory and change the values in the `input.tfvars` file to your desired values.
Names of the AWS Kinesis and AWS Data Firehose streams could remain the same since they are bound only to the AWS account,
but AWS S3 bucket is unique globally, so it needs to be changed.

After changing the values, you can run the following commands to deploy the architecture:
```bash
terraform init
terraform plan -var-file=input.tfvars # To see the changes that will be made
terraform apply -var-file=input.tfvars # To apply the changes
```

Enter your AWS console and confirm that resources has been created.

If all the resources have been created successfully, go into the `clickstream-producer` directory and run the following command
to trigger the script for writing clickstream data into AWS Kinesis Data Stream:
```bash
docker-compose up --build
```

After script finish running, confirm via AWS Cloudwatch metrics and AWS S3 storage that the data has been written successfully.


When finished, run the following command to destroy resources:
```bash
terraform destroy -var-file=input.tfvars
```