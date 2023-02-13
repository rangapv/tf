*TO-RUN*
terraform init
terraform plan -var="accesskey=XXXXXX" -var="secretkey=XXXXXX" -var="mykey=ssh-rsa XXXXX"
terraform apply -var="accesskey=XXXXXX" -var="secretkey=XXXXXX" -var="mykey=ssh-rsa XXXXX"
