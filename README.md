# LEX

A premium Flutter marketplace and live-commerce application.

## Overview

LEX is a cross-platform Flutter app built with a clean, layered architecture.
It uses Riverpod for state management, GoRouter for navigation, and Firebase
for backend services. The project is organized around a scalable design system
and a feature-first folder structure.

## Tech Stack

- **Flutter** with Material 3
- **Riverpod** (v3) for dependency injection and state management
- **GoRouter** for declarative routing and deep links
- **Firebase** (Auth, Firestore, Storage, Messaging, Analytics, Crashlytics,
  Remote Config)
- **Dio** for HTTP networking
- **flutter_secure_storage** for local secrets

## Quick Start

1. Ensure Flutter is installed and on `PATH`.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Verification

```bash
flutter analyze
flutter test
```

Both commands should pass with no issues.

## Project Structure

See [ARCHITECTURE.md](ARCHITECTURE.md) and [FOLDER_STRUCTURE.md](FOLDER_STRUCTURE.md)
for details.

## State Management

See [STATE_MANAGEMENT.md](STATE_MANAGEMENT.md).

## Theme System

See [THEME_SYSTEM.md](THEME_SYSTEM.md).

## Dependencies

See [DEPENDENCIES.md](DEPENDENCIES.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
