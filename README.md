# habyte

A group assignment for the Mobile Apps Development course.


## Building the project

Visit [Flutter homepage](https://flutter.dev) to install the latest stable version and run `flutter pub get` on the root directory of the project. Then, use `flutter run` to debug on AVD or a physical device via `adb`. Use `flutter build apk` to build a distributable apk file.


## Project Structure

- android: Android apps template (do not modify)
- assets: Equavalent to `drawable` or `raw` of Android resources folder
- ios: iOS apps template (do not modify)
- lib: Main application code, where all layout and functions are defined
  - models: Model definition. The M in MVVM.
  - services: Services that interface with native platform.
  - utils: Utilities
  - viewmodels: Viewmodels. The VM in MVVM.
  - views: Code related to drawing layouts on screen. The V in MVVM.
- macos: MacOS apps template (do not modify)
- test: Code for tests (N/A)
- web: Web app template (do not modify)
- windows: Windows apps template (do not modify)
