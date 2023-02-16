gcloud config set project gcp-csb-g5
gcloud container clusters get-credentials gcp-csb-g5-gke --region us-central1 --project gcp-csb-g5
gcloud container clusters resize gcp-csb-g5-gke --node-pool gcp-csb-g5-gke --num-nodes=2 --zone=us-central1 -q
kubectl create deployment sampleapp2 --image=us.gcr.io/gcp-csb-g5/gcf/us-central1/96e327c7-c740-478c-b79b-8ad824b803b3:latest
kubectl get deployment 
kubectl expose deployment sampleapp2 --type=LoadBalancer --port=8080


