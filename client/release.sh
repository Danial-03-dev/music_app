#!/bin/bash

# Prevent Git Bash from rewriting / paths on Windows
export MSYS_NO_PATHCONV=1

VERSION="v1.0.0"  # Update for each release

# ----------- Build Android -----------
echo "Building Android APK..."
flutter build apk --release
ANDROID_APK="build/app/outputs/flutter-apk/app-release.apk"

# ----------- Create GitHub Release -----------
echo "Creating GitHub release $VERSION..."
gh release create "$VERSION" \
    "$ANDROID_APK" \
    --generate-notes \
    --title "Release $VERSION"

echo "✅ Release $VERSION created successfully!"
echo "Android APK: $ANDROID_APK"
