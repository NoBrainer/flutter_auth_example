# flutter_auth_example

## Running the App

In Android Studios or IntelliJ:

1. (Optional) If testing with an emulated device then you need to start the device before running the app.
    - Go to: Device Manager, start it, and power it on.
2. Pick a device in the "Flutter Device Selection" dropdown.
    - "Chrome (web)" is convenient to use since you can use the browser developer tools.
    - "Windows (desktop)" is another option.
    - You can also pick any emulated or connected devices.
3. Pick `main.dart` in the "Select Run/Debug Configuration" dropdown.
4. Click the Run button.

## Development Environment Setup

If this is your first Flutter project, here are some useful resources:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

To start setting up your development environment, follow the "Get started" steps at
[Flutter documentation](https://docs.flutter.dev/). You'll want to make sure to:

- Install Flutter SDK
    - Note: If you use multiple drives, you want this to be on the same drive as your IDE files.
- Install Android Studio (You want this even if you're using another IDE, because it includes some other Android
  dependencies.)
    - Note: If you use multiple drives, you want the Android SDK to be on the same drive as your IDE files.
    - If you do have it installed somewhere other than the default location, make sure to run:
      ```
      flutter config --android-sdk path/to/sdk
      ```
- Set up Android emulator
    - Note: Google Play Services is required for push notifications.
- Agree to Android licenses
- (Optional) Install another IDE (VS Code or IntelliJ)
- Install the Flutter and Dart plugins for your IDE
- Verify Flutter is properly setup with `flutter doctor`

## Examples to Reference

- [Flutter Casual Games Toolkit](https://flutter.dev/games)
    - [Game Template](https://github.com/flutter/samples/tree/main/game_template) with sound effects, music, settings,
      ads, in-app purchases, game services (for leaderboard and achievements), and crash reporting
- [Bare Flame game](https://docs.flame-engine.org/latest/tutorials/bare_flame_game.html)

## Upgrading Dependencies

```
# Check outdated dependencies
flutter pub outdated

# Upgrade all dependencies
flutter pub upgrade

# If you get errors when running the app, you may need to clean things
flutter clean
flutter pub get
```

## Upgrading Flutter

When upgrading Flutter, you will most likely need to also refresh your platform directories (android, ios, linux, macos,
web, windows). This entire process is easily done in several steps:

1. Upgrade flutter:
    ```
    flutter upgrade
    ```
2. Delete platform directories.
3. Re-create platform directories:
    ```
    # recreate all platforms:
    flutter create .
    
    # or only recreate specific platforms:
    flutter create --platforms=android,ios .
    ```
4. Check git changes to verify changes.
    - If you made any manual changes to the platform files, this is where you'll catch them.
5. Run the app to verify it works.
    - If you have an issues, doing this may help:
      ```
      # 1. Clean flutter
      flutter clean
      
      # 2. (May not be necessary) Repair pub cache
      flutter pub cache repair
      
      # 3. Restart your IDE
      
      # 4. Get dependencies
      flutter pub get
      ```

## Building and Deploying Directly to Android Device

Note: We use a fat APK for simplicity, but if the app is made available in Google Play, it's recommended to instead use
app bundles.

See: https://docs.flutter.dev/deployment/android

### Prototype Release Process

1. Update `CHANGELOG.md`, commit, and push.
2. Tag the latest commit with `release-YYYY-MM-DD` to keep track of what is released. Push these changes with tags.
    - If you tag multiple times in one day, simply add a counter to the end, for example: `release-2024-04-27.1`.
3. Build the fat APK file:
    ```
    flutter build apk
    ```
4. Rename the fat APK (located at `build/app/outputs/apk/release/app-release.apk`) to to `app-release-YYYY-MM-DD.apk`
5. Save it to cloud storage accessible to both your development environment and the mobile device.
6. Upload `CHANGELOG.md` to replace the old version in cloud storage.
7. Download the fat APK onto your device and install it.
    - You just need to allow your device to "Install unknown apps" to be able to install it.
    - IMPORTANT: Make sure to turn off the permission to "Install unknown apps" after installation.

### Developer Release Process

1. Setup your device:
    - [Enable Developer options](https://developer.android.com/tools/adb)
    - Option 1: Wi-Fi
        - Connect your device to the same Wi-Fi network as your computer
        - Enable adb debugging (per link above) and set Developer options:
            - Wireless debugging: On
            - Disable adb authorization timeout: On
            - Tap "Wireless debugging"
        - Pair device with IDE:
            - Open Device Manager and click "Pair using Wi-Fi"
            - In device settings: Developer options > Wireless debugging
            - Click one of the pairing options
        - Verify your device is connected with the IDE's Device Manager
    - Option 2: USB
        - Connect your device via USB
        - Enable adb debugging (per link above) and set Developer options:
            - USB debugging: On
            - Disable adb authorization timeout: On
        - Verify your device is connected with IDE's Device Manager
2. Build an APK (Android Package) and deploy to connected device:
    - Simplest Option: Fat APK (larger file, includes build for all devices, may be fine for small apps)
      ```
      flutter build apk
      flutter install
      ```
    - Optimized Option: Split APK files
      ```
      flutter build apk --split-per-abi
      
      # Option 1: ARM 32-bit
      flutter install --use-application-binary=build/app/outputs/apk/release/app-arm64-v8a-release.apk
      
      # Option 2: ARM 64-bit
      flutter install --use-application-binary=build/app/outputs/apk/release/app-armeabi-v7a-release.apk
      
      # Option 3: x86 64-bit
      flutter install --use-application-binary=build/app/outputs/apk/release/app-x86_64-release.apk
      ```
    - Note: You can install this APK file without Flutter and an IDE setup. You just need to deal with Google Play
      trying to prevent you from installing "unsafe" apps.
        - IMPORTANT: Make sure to turn off the permission to "Install unknown apps" after you install it.
3. For security purposes, turn off Wireless & USB debugging.
4. If connected with USB, safely disconnect USB device from computer
