read -p "Project Id: " PROJECT_ID
read -p "Topic: " TOPIC_ID

echo Setting project...
gcloud config set project $PROJECT_ID

echo Creating service account...
gcloud iam service-accounts create devicepilot-subscriber --display-name "DevicePilot Subscriber"
IAM_ACCOUNT=devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com

echo Creating subscription...
gcloud pubsub subscriptions create devicepilot-subscription --topic=$TOPIC_ID --topic-project=$PROJECT_ID

echo Adding service account to subscription...
gcloud beta pubsub subscriptions add-iam-policy-binding devicepilot-subscription --member=serviceAccount:$IAM_ACCOUNT --role=roles/pubsub.subscriber

echo Creating key...
gcloud iam service-accounts keys create --iam-account=$IAM_ACCOUNT key.json
echo Copy the following and paste it into DevicePilot:
cat key.json
rm key.json