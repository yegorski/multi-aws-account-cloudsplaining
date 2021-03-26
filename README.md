# Multi AWS Account Cloudsplaining

Tool for analyzing all attached IAM policies and reporting violations of least privilege.

[Cloudsplaining][] only runs in one AWS account. This script invokes the tool for multiple AWS accounts.

This script can be ran in AWS ECS service and integrated into your CI/CD process to generate a report on a schedule.

## Prerequisites

1. Install cloudsplaining `pip install -r requirements.txt`
1. Update the following files, replacing `aws_account_id_x` with AWS account ID:
   1. `nginx.conf`
   1. `index.html`
   1. `Dockerfile`
   1. folders in the `output` dir
1. The account IDs are used by the `assumerole.sh` script to assume into the AWS account prior to running cloudsplaining
1. Have an IAM role in each of the AWS accounts that this script will assume into. The assume script uses the AWS CLI [assume-role][] command
   1. The role will need a `Trust relationship` that allows your IAM user / CI/CD role to assume it
      1. For security, **please** require the `external-id` aka the secret string that needs to be passed in when assuming the role

## Usage

Generate, run, and view the report locally.

### Generate the report

Run these steps for each AWS account:

```bash
source ./assumerole.sh ${AWS_ACCOUNT_1_IAM_ROLE_ARN} ${AWS_ACCOUNT_1_EXTERNAL_ID} 3600
cloudsplaining download # obtains all attached IAM policies
cloudsplaining scan --exclusions-file exclusions.yml --input-file default.json --output output/${AWS_ACCOUNT_1_ID}
```

### Run the report

```bash
docker build -t cloudsplaining .
docker run --rm -p 80:80 cloudsplaining
```

### View the report

View the report in the browser <http://localhost>.

[assume-role]: https://docs.aws.amazon.com/cli/latest/reference/sts/assume-role.html
[cloudsplaining]: https://github.com/salesforce/cloudsplaining
