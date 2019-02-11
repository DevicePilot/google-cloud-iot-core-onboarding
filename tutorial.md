# Scripted DevicePilot onboarding for Google Cloud IoT Core users

### Run script
```bash
chmod +x script.sh && ./script.sh
```

Alternatively, run each step manually. For each step, copy the code snippet using the icon on the top right and paste it in the console. Replace every [PROPERTY] with the appropriate value.

### Configure project, registry and topic
```bash
PROJECT_ID=[PROJECT_ID]
```
```bash
TOPIC_ID=[TOPIC]
```

### Set project
```bash
gcloud config set project $PROJECT_ID
```

### Create service account
```bash
gcloud iam service-accounts create devicepilot-subscriber --display-name "DevicePilot Subscriber"
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

### Create subscription
```bash
gcloud pubsub subscriptions create devicepilot-subscription --topic=$TOPIC_ID --topic-project=$PROJECT_ID
```

### Add service account to subscription
```bash
gcloud beta pubsub subscriptions add-iam-policy-binding devicepilot-subscription --member=serviceAccount:devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com --role=roles/pubsub.subscriber
```
