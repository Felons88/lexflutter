# Dependencies

This file documents the main packages in `pubspec.yaml` and why they are used.

## Flutter SDK

- `flutter` — Flutter SDK.
- `cupertino_icons` — iOS-styled icons.

## State Management

- `flutter_riverpod` (^3.3.2) — Core state management and dependency injection.
- `hooks_riverpod` (^3.3.2) — Riverpod + Flutter Hooks integration.
- `flutter_hooks` (^0.21.3+1) — Reusable hook widgets.
- `riverpod_annotation` (^4.0.3) — Code-generation annotations for Riverpod.

## Routing

- `go_router` (^17.3.0) — Declarative routing, deep links, and nested navigation.

## Firebase

- `firebase_core` (^4.11.0) — Firebase SDK bootstrap.
- `firebase_auth` (^6.5.4) — Authentication.
- `cloud_firestore` (^6.6.0) — NoSQL database.
- `firebase_storage` (^13.4.3) — File storage.
- `firebase_messaging` (^16.4.1) — Push notifications.
- `firebase_analytics` (^12.4.3) — Event analytics.
- `firebase_crashlytics` (^5.2.4) — Crash reporting.
- `firebase_remote_config` (^6.5.3) — Remote configuration.
- `firebase_app_check` (^0.4.5) — App attestation.

## Networking & Storage

- `dio` (^5.10.0) — HTTP client.
- `flutter_secure_storage` (^10.3.1) — Encrypted local storage.
- `connectivity_plus` (^7.2.0) — Network connectivity status.

## UI & Media

- `cached_network_image` (^3.4.1) — Image caching and loading.
- `video_player` (^2.12.0) — Video playback.
- `better_player` (^0.0.84) — Advanced video player.
- `flutter_animate` (^4.5.2) — Animation utilities.
- `image_picker` (^1.2.3) — Pick images from camera/gallery.
- `camera` (^0.12.0+1) — Camera access.

## Utilities

- `intl` (^0.20.3) — Date/number formatting and localization.
- `logger` (^2.7.0) — Pretty console logging.
- `package_info_plus` (^10.2.0) — App version and package info.
- `device_info_plus` (^13.2.0) — Device information.
- `permission_handler` (^12.0.3) — Runtime permissions.
- `uuid` (^4.5.3) — UUID generation.
- `freezed_annotation` (^3.1.0) — Immutable data-class annotations.

## Dev Dependencies

- `flutter_test` — Testing framework.
- `flutter_lints` (^6.0.0) — Recommended lints.
- `build_runner` (^2.4.15) — Dart code generation.
- `freezed` (^3.0.6) — Immutable model code generation.
- `json_serializable` (^6.14.0) — JSON serialization code generation.

## Updating Dependencies

Run the following to check for newer versions:

```bash
flutter pub outdated
```

To upgrade to the latest compatible versions:

```bash
flutter pub upgrade
```

To upgrade with major version changes, use:

```bash
flutter pub upgrade --major-versions
```

After any code-generation-dependent package change, regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
```
