#!/usr/bin/env bash
set -e
mkdir -p lib assets
mv -f main.dart lib/main.dart
mv -f index.html assets/index.html
mv -f icon.png icon_fg.png icon_bg.png assets/
flutter create --platforms=android --org com.mariam --project-name workout_schedule .
sed -i 's/android:label="[^"]*"/android:label="جدول تمارين نوار"/' android/app/src/main/AndroidManifest.xml
flutter pub get
dart run flutter_launcher_icons
flutter build apk --release
