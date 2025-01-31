# 🏗️ Flutter Base Project

[![es](https://img.shields.io/badge/lang-es-yellow.svg)](https://https://github.com/wdavid73//master/README.es.md)

This is a base project in Flutter designed as a template for future developments. It contains essential configurations and packages to quickly start new projects.

---

## 📌 Prerequisites

Make sure you have the following items installed:

- **Flutter** (If using FVM, run `fvm use <version>` to configure the appropriate version).
- **Dart**
- **Android Studio or VS Code** (Optional but recommended)
- **Physical device or emulator configured** **Flutter** (Optional but recommended)

---

## 🚀 Useful Commands

| Command             | Description                                                              |
|---------------------|--------------------------------------------------------------------------|
| `flutter pub get`   | Download project dependencies                                            | |
| `flutter run`       | Runs the application on the connected device/emulator                    | |
| `flutter build apk` | Generate an APK file for Android                                         | |
| `flutter build ios` | Generate iOS version (requires macOS)                                    | | `flutter clean` | `flutter build ios` | Generate iOS version (requires macOS)
| `flutter clean`     | Deletes generated files and clears cache                                 | `flutter clean` | `flutter build ios` | Deletes generated files and cleans cache |
| `fvm flutter run`   | (If using FVM) Runs the app with the Flutter version defined in `.fvmrc` |
| `dart fix --apply`  | Automatically apply suggested fixes                                      |
| `flutter analyze`   | Analyze the code for errors and warnings                                 | `flutter test` | | run `flutter test` | run `flutter analyze` | run `flutter test` | run
| `flutter test`      | Runs the project's unit tests                                            |

---



| Package Description | |
|---------------------|-|
<!--
| `flutter_bloc` | BLoC-based state management |
|  `get_it` | Simple dependency injection | |
|  `equatable` | Facilitates object comparison in Dart | |
| `dio` | Powerful and flexible HTTP client | |
| `shared_preferences` | Key-value data storage on the device | `flutter_localizations` | `flutter_localizations` | `flutter_localizations
| `flutter_localizations` |  Multi-language support | |
|  `hive` | Fast and efficient local database | `hive` | Local database | | | `hive` | Local database | |hive` | Local database
-->
*(You can add more packages as required by your base project).

---
## 🔧 Before running your project
After creating your Flutter project based on this template please perform the following steps.

### 🌐 1. Environment variables.

1. Create the .env file based on the .env.template file
2. Change the value of your API_URL variable.

### ✏️ 2. Change package name

As you are creating a project based on a template it is necessary that you change the name of the app to avoid conflicts when you want to upload your app to the stores.

- Verify that the **change_app_package_name** package is in the **pubspec.yaml** file in the **dev_dependencies** section.
- Run the following command to get all the packages that the project needs initially
```sh
flutter pub get
```
- Now run the following command to change the app's name
```sh
dart run change_app_package_name:main com.<your_domain>.<app_name>.
```
- **(Optional)** if you are using FVM **(Flutter Version Manager)** the command is like this
```sh
fvm dart run change_app_package_name:main com.<your_domain>.<app_name>.
```

### 3. Change app launcher icon (Optional)

This step is optional, to change the app icon you should do the following

- Verify that the **flutter_launcher_icons** package is in the **pubspec.yaml** in the **dev_dependencies** section.
- In the pubspec.yaml go to the **flutter_launcher_icons** section and in the path specified in **image_path** specify the icon of your app.
- Run the following command to get all the packages that the project needs initially
```sh
flutter pub get
```
- Now run the following command to change the icon of the app
```sh
dart run flutter_launcher_icons
```
- **(Caution!)** if you changed the path of your app icon you must also change the path in pubspec.yaml
```
flutter:
  assets:
    - assets/icon/ <-- **Modify the path of your icon here**
```
- **(Optional)** if you are using FVM **(Flutter Version Manager)** the command is as follows.
```sh
fvm dart run flutter_launcher_icons
```

### 4. Change the app splash screen (Optional)

If you want to change the splash screen of the app you should do the following steps

- Verify in the **pubspec.yaml** file that the **flutter_native_splash** package is in the **dependencies** section.
- **(Optional)** If you want to change the color of the splash screen you must do the following
```
flutter_native_splash:
  color: “#252829” <-- **Modify the splash screen color here**
```
- Run the following command to get all the packages that the project needs initially.
```sh
flutter pub get
```
- Now run the following command to change the splash screen of the app
```sh
dart run flutter_native_splash:create
```
- **(Optional)** if you are using FVM **(Flutter Version Manager)** the command is as follows
```sh
fvm dart run flutter_native_splash:create
```

---

## ▶️ How to Run the Project

### With Android Studio
1. Open the project in **Android Studio**.
2. Connect an emulator or a physical device.
   Press the **Run** button or use the shortcut `Shift + F10`.

### With Command Line
- If you use FVM:
 ```sh
 fvm flutter pub get
 fvm flutter run
 ```
- Without FVM:
 ```sh
 flutter pub get
 flutter run
 ```


## 📦 Create Build (APK or AAB) for Android

To create an APK or AAB file for Android, follow these steps:

1. **Generate APK**:
   Run the following command to generate an APK file:
    ```sh
    flutter build apk
    ```
    This command will create the APK file in the ```build/app/outputs/flutter-apk/``` directory.

2. **Generate AAB** (Android App Bundle):
   If you want to generate an AAB (recommended for Google Play Store release), use the following command:
     ```sh
     flutter build appbundle
     ```
    This command will create the AAB file in the ```build/app/outputs/bundle/release/``` directory

3. **Additional options**:
    If you need to sign the APK or AAB for production, you must configure your ```keystore``` in the ```build.gradle``` file. Make sure you have a key file (```keystore```) and add the signing configuration:
    ```groovy
    android { 
        signingConfigs{
            release {
                storeFile file("path/to/your.keystore")
                storePassword "your_keystore_password"
                keyAlias "your_key_alias"
                keyPassword "your_key_password"
            }
        }
        buildTypes {
            release {
                signingConfig signingConfigs.release
            }
        }
    }
    ```

## 🍏 Create Build (IPA) for iOS

To create an IPA file for iOS, follow these steps:

1. **Prerequisites**:
   - Make sure you have Xcode installed on macOS.
   - You must have an Apple developer account and be registered in the Apple Developer Program.
2. **Generate Build for iOS**:
   Run the following command to generate a build for iOS:
     ```sh
     flutter build ios --release
     ```
     This will compile the application in release mode for iOS.

3. **Create IPA**:
   To create an IPA file (which you can install on a device or submit to the App Store), open the project in Xcode:
   - Open the ```ios/Runner.xcworkspace``` file.
   - In Xcode, select the target device (it can be a physical device or a simulator).
   - Go to ```Product > Archive``` to create the archive.
   - Once archiving is complete, the Organizer window will open. From there, you can export the IPA file.

4. **Sign and configure the profile**:
 To publish the app to the App Store, make sure you have a signing certificate and provisioning profile configured in Xcode.

### 📄 License
This project is under the MIT license. Feel free to modify it and adapt it to your needs.

### 💡 Happy coding with Flutter! 🚀
This `README.md` is clear, modular and adaptable for any project you use as a base. You can modify it according to the specific needs of your template. 🚀