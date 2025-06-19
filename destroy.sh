cd terraform

cd rootapp
tofu destroy -auto-approve

cd ../workloads
tofu destroy -auto-approve

cd ../db
tofu destroy -auto-approve

cd ../cluster
tofu destroy -auto-approve