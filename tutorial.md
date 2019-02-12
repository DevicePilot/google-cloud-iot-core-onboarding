# DevicePilot onboarding for Google Cloud IoT Core users

## Run script
```bash
./script.sh
```

When prompted click <walkthrough-editor-open-file filePath="google-cloud-iot-core-onboarding/key.json">here</walkthrough-editor-open-file> to open key file and copy its content into DevicePilot.

Alternatively, follow each step manually in the next page.

## Run manually

### Configure project
```bash
gcloud projects list && read -p "PROJECT_ID: " PROJECT_ID
```

### Configure topic
(select, copy and paste this code manually, without using the top right icon)
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
gcloud pubsub subscriptions create devicepilot-subscription --topic=$TOPIC --topic-project=$PROJECT_ID
```

### Add service account to subscription
```bash
gcloud beta pubsub subscriptions add-iam-policy-binding devicepilot-subscription --member=serviceAccount:devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com --role=roles/pubsub.subscriber
```

### Create key
```bash
gcloud iam service-accounts keys create --iam-account=devicepilot-subscriber@$PROJECT_ID.iam.gserviceaccount.com key.json
```

### Copy key into DevicePilot
Click <walkthrough-editor-open-file filePath="google-cloud-iot-core-onboarding/key.json">here</walkthrough-editor-open-file> to open key file and copy its content into DevicePilot.
