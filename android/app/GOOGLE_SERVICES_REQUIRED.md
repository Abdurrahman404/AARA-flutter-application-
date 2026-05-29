# ⚠️ REQUIRED: Add google-services.json here

Before building the APK, you MUST place your `google-services.json` file in this folder:
  `android/app/google-services.json`

## How to get it:
1. Go to https://console.firebase.google.com
2. Select your AARA project
3. Click the Android app (com.example.aara)
4. Click the gear icon → "Download google-services.json"
5. Place the file in this folder: android/app/

Without this file, Firebase will not initialize and the app will crash on launch.
