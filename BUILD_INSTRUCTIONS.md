# AARA — APK Build Instructions

## Prerequisites
- Flutter SDK installed and on PATH (`flutter --version`)
- Android SDK / Android Studio installed
- Java 17

---

## Step 1: Add google-services.json ⚠️ REQUIRED
Place your Firebase `google-services.json` at:
```
android/app/google-services.json
```
Get it from: Firebase Console → Your Project → Android App → Download config file

---

## Step 2: Get dependencies
```bash
flutter pub get
```

---

## Step 3: Build Debug APK (for testing)
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

---

## Step 4: Build Release APK (for deployment)

The current setup uses debug signing for release (acceptable for submission/testing).
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Install directly to connected device:
```bash
flutter install
```

### Or copy APK to device and install manually.

---

## Step 5 (Optional): Build App Bundle for Play Store
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

---

## Known: Google Sign-In on Release Build
If Google Sign-In fails on release APK, you need to add your release SHA-1 to Firebase:
1. Run: `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android`
2. Copy the SHA-1 fingerprint
3. Firebase Console → Project Settings → Android App → Add fingerprint

---

## App Details
- Package: `com.example.aara`
- Version: 1.0.0+1
- Min SDK: Flutter default (Flutter 3.x = API 21)
- Target SDK: Latest Flutter default
