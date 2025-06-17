cd terraform

cd cluster
tofu apply -auto-approve

cd ../workloads
tofu apply -auto-approve

cd ../rootapp
tofu apply -auto-approve