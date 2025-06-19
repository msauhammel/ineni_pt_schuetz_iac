cd terraform

cd cluster
tofu init
tofu apply -auto-approve

cd ../db
tofu init
tofu apply -auto-approve

cd ../workloads
tofu init
tofu apply -auto-approve

cd ../rootapp
tofu init
tofu apply -auto-approve