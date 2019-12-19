### OCI-terraform-demo

#### 1.Install oci-cli and terraform 
```
$ bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
$/Users/davar/bin/oci setup keys

...
If you haven't already uploaded your public key through the console,
follow the instructions on the page linked below in the section 'How toupload the public key':

    <https://docs.cloud.oracle.com/Content/API/Concepts/apisigningkey.htm#How2>

$ cat /Users/davar/.oci/config
[DEFAULT]
user=
fingerprint=
key_file=~/.oci/oci_api_key.pem
tenancy=
region=
$ /Users/davar/bin/oci setup repair-file-permissions --file /Users/davar/.oci/config
$ /Users/davar/bin/oci iam region list --output table
$ /Users/davar/bin/oci iam availability-domain list --output table --profile DEFAULT
$ /Users/davar/bin/oci compute image list -c ocid1.tenancy.oc1XXXXXXXXXX --output table --query "data [*].{ImageName:\"display-name\", OCID:id}"|grep CentOS
$ curl https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_darwin_amd64.zip --output terraform_0.12.18_darwin_amd64.zip
$ unzip terraform_0.12.18_darwin_amd64.zip
$ cp ./terraform /usr/local/bin
```
#### 2.Create env-vars file
```
$ cat env-vars
export TF_VAR_tenancy_ocid=
export TF_VAR_user_ocid=
export TF_VAR_compartment_ocid=

export TF_VAR_fingerprint=$(cat ~/.oci/oci_api_key_fingerprint)
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem

export TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub)
export TF_VAR_ssh_private_key=$(cat ~/.ssh/id_rsa)

export TF_VAR_region=
```

#### 3.Create OCI infrastructure
```
$ source env-vars
$ terraform init
$ terraform plan
$ terraform apply
```
#### 4.Clean OCI infrastructure
```
$ terraform destroy
```
