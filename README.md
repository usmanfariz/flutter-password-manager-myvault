# MyVault

A simple password manager built with Flutter. It allows you to securely store, view, and copy login credentials.

## Features
- Add, view, delete passwords
- Passwords stored securely on device using `flutter_secure_storage`
- Copy password to clipboard
- Biometric or PIN authentication before accessing the vault using local_auth

## Getting Started
```bash
flutter pub get
flutter run
```

## Requirements
- Flutter SDK
- Android device/emulator with biometric support (or PIN)
- Minimum SDK: Android 6.0 (API 23)
## Permissions (Android)
Ensure AndroidManifest.xml includes the following for biometric access:
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
```
