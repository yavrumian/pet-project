# local development

## Prerequisites

### Configure terminal
Follow the steps provided below before using terraform cli:

 1. Visit [AWS Portal][1]
 2. Click on the AWS Account name (e.g. `naviteq-non-prod`)
 3. Click on the `Command line or programmatic access`
 4. Copy variables under the `Option 1: Set AWS environment variables` section
     ```
    export AWS_ACCESS_KEY_ID=***
    export AWS_SECRET_ACCESS_KEY=***
    export AWS_SESSION_TOKEN=***
     ```
 5. Paste them in your local terminal

### In case the root module contains private module(s)

You need to create `.terrformrc` file in your home directory with the following content:
```
credentials "app.terraform.io" {
  token = "YOUR_TOKEN"
}
```
You can get your token from [Terraform Cloud Settings][2]

---

## Terraform usage

To apply the changes in development environment run:

Retrieve AWS variables for the account `naviteq-development` (see `Configure terminal` section)
```
cd core
terraform init -backend-config=envs/development/backend.hcl -reconfigure
terraform plan -var-file=envs/development/terraform.tfvars
terraform apply -var-file=envs/development/terraform.tfvars
```

To apply the changes in staging environment run:

Retrieve AWS variables for the account `naviteq-staging` (see `Configure terminal` section)
```
cd core
terraform init -backend-config=envs/staging/backend.hcl -reconfigure
terraform plan -var-file=envs/staging/terraform.tfvars
terraform apply -var-file=envs/staging/terraform.tfvars
```

To apply the changes in production environment run:

Retrieve AWS variables for the account `naviteq-prod` (see `Configure terminal` section)
```
cd core
terraform init -backend-config=envs/production/backend.hcl -reconfigure
terraform plan -var-file=envs/production/terraform.tfvars
terraform apply -var-file=envs/production/terraform.tfvars
```

[1]: https://d-906747932a.awsapps.com/start#/
[2]: https://app.terraform.io/app/settings/tokens
