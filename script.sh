echo Available projects:
gcloud projects list
read -p "PROJECT_ID: " PROJECT_ID

echo Setting project...
gcloud config set project $PROJECT_ID

echo Available topics:
gcloud pubsub topics list | sed -n 's/.*\/topics\///p'
read -p "Topic: " TOPIC

echo Creating service account...
gcloud iam service-accounts create devicepilot-subscriber --display-name "DevicePilot Subscriber"
IAM_ACCOUNT=devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com

echo Creating subscription...
gcloud pubsub subscriptions create devicepilot-subscription --topic=$TOPIC --topic-project=$PROJECT_ID

echo Adding service account to subscription...
gcloud beta pubsub subscriptions add-iam-policy-binding devicepilot-subscription --member=serviceAccount:$IAM_ACCOUNT --role=roles/pubsub.subscriber

echo Creating key...
gcloud iam service-accounts keys create --iam-account=$IAM_ACCOUNT key.json

echo All steps completed successfully. To copy the key follow instructions in the right panel