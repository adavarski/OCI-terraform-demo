1.Install terraform 
```
$ curl https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_darwin_amd64.zip --output terraform_0.12.18_darwin_amd64.zip; unzip terraform_0.12.18_darwin_amd64.zip;cp ./terraform /usr/local/bin
```
2.Create env-vars file

3.Create OCI infrastructure
```
$ source env-vars
$ terraform init
$ terraform plan
$ terraform apply
```
4.Clean OCI infrastructure
```
$ terraform destroy
```
