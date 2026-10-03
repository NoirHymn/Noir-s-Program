#!/usr/bin/env bash
set -e
mkdir -p lib assets
mv -f main.dart lib/main.dart
mv -f index.html assets/index.html
flutter create --platforms=android --org com.mariam --project-name workout_schedule .
sed -i 's/android:label="[^"]*"/android:label="جدول التمرين"/' android/app/src/main/AndroidManifest.xml
flutter pub get
flutter build apk --release
