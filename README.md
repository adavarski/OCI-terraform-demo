1.Install terraform 
```
$ curl https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_darwin_amd64.zip --output terraform_0.12.18_darwin_amd64.zip

$ unzip terraform_0.12.18_darwin_amd64.zip

$ cp ./terraform /usr/local/bin
```
Create env-vars file

$ source env-vars
$ terraform init
$ terraform plan
$ terraform apply
