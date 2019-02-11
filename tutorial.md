# DevicePilot onboarding for Google Cloud IoT Core users

### Run script
```bash
./script.sh
```

Alternatively, run each step manually. For each step, copy the code snippet using the icon on the top right and run it in the console.

### Configure project
```bash
gcloud projects list && read -p "PROJECT_ID: " PROJECT_ID
```

### Configure topic
```bash
gcloud pubsub topics list | sed -n 's/.*\/topics\///p' && read -p "Topic: " TOPIC
```

### Set project
```bash
gcloud config set project $PROJECT_ID
```

### Create service account
```bash
gcloud iam service-accounts create devicepilot-subscriber --display-name "DevicePilot Subscriber"
```

### Create subscription
```bash
gcloud pubsub subscriptions create devicepilot-subscription --topic=$TOPIC_ID --topic-project=$PROJECT_ID
```

### Add service account to subscription
```bash
gcloud beta pubsub subscriptions add-iam-policy-binding devicepilot-subscription --member=serviceAccount:devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com --role=roles/pubsub.subscriber
```

### Create key
```bash
gcloud iam service-accounts keys create --iam-account=devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com key.json
```

### Copy key to DevicePilot
Copy the output of the command bellow into DevicePilot
```bash
cat key.json
```
