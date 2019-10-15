# tfe-remote-backend
TFE remote state backend

Lab follow repo. 

# Requirements
This repo assumes general knowledge about Terraform for AWS, if not, please get yourself accustomed first by going through [getting started guide](https://learn.hashicorp.com/terraform?track=getting-started#getting-started).


# Idea
As our team grows, and collaboration is needed, having a local state file can cause slowdown.

In order to overcome this, we can have a remote state.


# Instructions

- First, we'll use Terraform Cloud as our backend. Terraform Cloud offers free remote state management. Terraform Cloud is the recommended best practice for remote state storage.
If you don't have an account, please [sign up here for this guide](https://app.terraform.io/signup). For more information on Terraform Cloud, view this [getting started guide](https://learn.hashicorp.com/terraform/cloud/tf_cloud_gettingstarted).
- You'll also need a user token to authenticate with Terraform Cloud. You can generate one on the [user settings page](https://app.terraform.io/app/settings/tokens). Save gnerated user token somewhere safe
- Terraform CLI Configuration file. This file is This file is located at `%APPDATA%\terraform.rc` on Windows systems, and `~/.terraformrc` on other systems, with following content :
    ```
        credentials "app.terraform.io" {
            token = "REPLACE_ME"
        }
    ```
    > Note replace the token above with your value from previous step
- Now, create empty Git repo
- Clone it to your computer, using tools of your choice
- Create new branch  (from here and later I am going to reference command-line Git tools) :
    ```
    git checkout -b f-test-backend
    ``` 
- Create Terraform code, [main.tf](main.tf) with contents : 
    ```terraform
    resource "null_resource" "helloWorld" {
        provisioner "local-exec" {
            command = "echo hello world"
        }
    }
    ```
- Init Terraform (this will use you code plus Terraform config with token), execute :
    ```
    terraform init
    ```
    Output : 
    ```
    Initializing the backend...

    Initializing provider plugins...
    - Checking for available provider plugins...
    - Downloading plugin for provider "null" (hashicorp/null) 2.1.2...

    The following providers do not have any version constraints in configuration,
    so the latest version was installed.

    To prevent automatic upgrades to new major versions that may contain breaking
    changes, it is recommended to add version = "..." constraints to the
    corresponding provider blocks in configuration, with the constraint strings
    suggested below.

    * provider.null: version = "~> 2.1"

    Terraform has been successfully initialized!    
    ```
- Apply our code : 
    ```
    terraform apply
    ```
    Output
    ```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
    Terraform will perform the following actions:

    # null_resource.helloWorld will be created
    + resource "null_resource" "helloWorld" {
        + id = (known after apply)
        }

    Plan: 1 to add, 0 to change, 0 to destroy.

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

    null_resource.helloWorld: Creating...
    null_resource.helloWorld: Provisioning with 'local-exec'...
    null_resource.helloWorld (local-exec): Executing: ["/bin/sh" "-c" "echo hello world"]
    null_resource.helloWorld (local-exec): hello world
    null_resource.helloWorld: Creation complete after 0s [id=220434641242397148]
    ```
- Create 
- Change [main.tf](main.tf) to include the new backend as follows : 
    ```terraform
    terraform {
    backend "atlas" {
        name    = "galser-free/lab-test"
    }
    }

    resource "null_resource" "helloWorld" {
    provisioner "local-exec" {
        command = "echo hello world"
    }
    }
    ```
- Now we can use `git add` and `git commit` to add the updated file to our repo.
- We push to GitHUb and merge with a pull request.

# Follow along 


