# terraform-gcp-project-settings

This repository is an example of how to create a basic setup of your Google Cloud project with Terraform.


## Instructions

The code requires that the project already exists. It currently doesn't cover creating a new project.
Before running the scripts, manually do the following:

- Create bucket to store terraform's state with the name: your-project-id followed by '-terraform'
- Create a terraform service account with the following permissions:
  - Artifact Registry Administrator
  - Cloud Run Admin
  - Project IAM Admin
  - Service Account User
  - Service Usage Admin
  - Storage Admin


On your terminal run:

```
export GCP_PROJECT_ID=your-project_id
cd modules/backend
terraform init
terraform plan -out "terraform.plan"
terraform apply "terraform.plan"
cd ../../dev
terraform init -backend-config="bucket=${GCP_PROJECT_ID}-terraform"
terraform plan -out "terraform.plan"
terraform apply "terraform.plan"
```

When asked, inform your billing account ID and project id.