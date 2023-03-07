*TO-RUN*
terraform init
terraform plan -var="accesskey=XXXXXX" -var="secretkey=XXXXXX" -var="mykey=ssh-rsa XXXXX"
terraform apply -var="accesskey=XXXXXX" -var="secretkey=XXXXXX" -var="mykey=ssh-rsa XXXXX"


(oR)


If using sensitive data then,

terraform init
terraform plan -var-file="secret.tfvars"
terraform apply -var-file="secret.tfvars"
