# ForgeRock MongoDB Connector

This repository contains the [ForgeRock remote connector server, MongoDB connector](https://backstage.forgerock.com/downloads/browse/idm/featured/connectors) and Terraform scripts for deploying into AWS. 

## Running Locally

### Pre-Requisites

The following need to be installed/configured for local use:

- [Docker](https://docs.docker.com/get-docker/)
- [AWS CLI](https://companieshouse.atlassian.net/wiki/spaces/DEVOPS/pages/2220261547/AWS+SSO+User+Guide)
- [Terraform Runner](https://companieshouse.atlassian.net/wiki/spaces/DEVOPS/pages/1694236886/Terraform-runner)

### Connector

The connector can be ran locally using Docker, assuming there is a remote server connector configured in ForgeRock Identity Cloud. 

**Build Arguments**
| Name              | Description                                 | Default Value | Required           |
| ----------------- | ------------------------------------------- | ------------- | ------------------ |
| FIDC_URL          | ForgeRock Identity Cloud URL.               | N/A           | :white_check_mark: |
| SERVER_KEY        | Unique key to set during the build process. | N/A           | :white_check_mark: |
| RCS_CLIENT_SECRET | RSCClient application secret                | N/A           | :white_check_mark: |
| CONNECTOR_NAME    | Name of the remote server connector in FIDC | mongodb       |                    |

**Commands**
```
# Navigate to connector directory
cd connector

# Build container image
docker build --build-arg FIDC_URL=https://openam-example.forgeblocks.com --build-arg SERVER_KEY=XXXXX  --build-arg RCS_CLIENT_SECRET=XXXX --build-arg CONNECTOR_NAME=mongodb -t mongodb-connector .

# Run container
docker run --rm -d --name mongodb-connector mongodb-connector
```

### Terraform

Terraform scripts can be ran locally using the terraform-runner tool with sufficient AWS permissions.

**Commands**
```
# Navigate to terraform directory
cd terraform

# Export AWS profile (must match one in the groups/mongodb-connector/profiles directory)
export AWS_PROFILE=development-eu-west-2

# Login using AWS SSO
aws sso login

# Generate a plan 
terraform-runner -g mongodb-connector -p development-eu-west-2 -e development -c plan
```