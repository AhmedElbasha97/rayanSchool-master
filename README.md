# rayanSchool

A Flutter-based school management application for students, parents, and teachers.

## Overview

**rayanSchool** is a mobile app built with Flutter and GetX that helps connect school users through a single platform.  
The app includes role-based screens and services for:

- Students
- Parents
- Teachers

It also includes Arabic and English support, push notifications, local persistence, file handling, media support, and embedded web content.

## Features

- Role-based login for different user types
- Student, parent, and teacher account pages
- Homework, files, books, questions, and schedules
- News, activities, albums, and school information
- Notifications with Firebase Cloud Messaging
- Local caching and persistent storage with Hive and SharedPreferences
- Arabic and English localization
- File download, pick, save, share, and open support
- WebView and in-app browser support
- Image picking and cached network images
- App analytics with Firebase Analytics
- Responsive UI with custom fonts and styles

## Tech Stack

- Flutter
- GetX
- Firebase Core
- Firebase Messaging
- Firebase Analytics
- Dio
- Hive / Hive Flutter
- Shared Preferences
- WebView Flutter / InAppWebView
- Cached Network Image
- File Picker
- Image Picker
- URL Launcher
- Share Plus

## Requirements

- Flutter SDK `>=3.0.0 <4.0.0`
- Dart SDK compatible with Flutter 3.x
- Android Studio / VS Code / Xcode
- Firebase project configured for the app

## Project Version

- **Version:** `3.1.5+110`

## Installation

1. Clone the repository.

```bash
git clone <repository-url>
cd rayanSchool
```

2. Get dependencies.

```bash
flutter pub get
```

3. Configure Firebase.

Make sure the Firebase configuration files are added for your target platforms, including:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

Also ensure `lib/firebase_options.dart` matches your Firebase project.

4. Run the app.

```bash
flutter run
```

## Assets

The app uses the following assets:

- `assets/images/`
- `assets/icons/`
- `assets/fonts/DroidKufiRegular.ttf`
- `assets/fonts/DroidKufiBold.ttf`
- `i18n/ar.json`
- `i18n/en.json`

## Fonts

The project uses the **DroidKufi** font family:

- DroidKufiRegular
- DroidKufiBold

## Localization

Supported languages:

- Arabic
- English

## Main Packages

Some of the important dependencies used in this project:

- `get`
- `dio`
- `firebase_core`
- `firebase_messaging`
- `firebase_analytics`
- `hive`
- `shared_preferences`
- `cached_network_image`
- `flutter_local_notifications`
- `permission_handler`
- `file_picker`
- `image_picker`
- `webview_flutter`
- `flutter_inappwebview`

## App Structure

A simplified structure of the project:

```text
lib/
├── I10n/
├── Utils/
├── globals/
├── models/
├── services/
├── views/
├── firebase_options.dart
└── main.dart
```

## Notes

- The app is configured with `publish_to: 'none'`, so it is intended for private/internal use.
- Firebase push notifications are initialized in the app startup flow.
- The app locks orientation to portrait mode.

## License

This project is private unless a license is added by the owner.
