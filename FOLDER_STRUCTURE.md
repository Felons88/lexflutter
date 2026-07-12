# Folder Structure

```
lex/
├── android/                  # Android platform files
├── ios/                      # iOS platform files
├── linux/                    # Linux platform files
├── macos/                    # macOS platform files
├── windows/                  # Windows platform files
├── test/                     # Unit and widget tests
│   └── core/                 # Core utility tests
├── lib/
│   ├── app.dart              # LexApp + MaterialApp configuration
│   ├── main.dart             # Entry point and Firebase bootstrap
│   ├── core/                 # Shared, app-wide code
│   │   ├── config/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── extensions/
│   │   ├── logging/
│   │   ├── routing/
│   │   ├── services/
│   │   │   ├── analytics/
│   │   │   ├── device/
│   │   │   ├── firebase/
│   │   │   ├── network/
│   │   │   ├── permissions/
│   │   │   ├── remote_config/
│   │   │   └── storage/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   ├── features/             # Feature modules (empty at start)
│   └── shared/
│       ├── animations/
│       ├── components/
│       ├── models/
│       ├── providers/
│       └── repositories/
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## `lib/core/`

Code used across every part of the app. It must not depend on `features/`.

- **config/** — environment and build-time configuration.
- **constants/** — top-level constants (routes, API, etc.).
- **errors/** — `Failure` and `Result` classes.
- **extensions/** — Dart/Flutter extensions for cleaner UI code.
- **logging/** — `AppLogger` and `ErrorHandler`.
- **routing/** — `GoRouter` setup, route definitions, and guards.
- **services/** — wrappers around Firebase, plugins, and network clients.
- **theme/** — design tokens and `ThemeData` factory (`AppTheme`).
- **utils/** — pure, side-effect-free helpers.
- **widgets/** — base widgets used by features and screens.

## `lib/features/`

Each feature owns its own data, domain, and presentation layers.

```
features/<feature>/
├── data/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── usecases/
├── presentation/
│   ├── providers/
│   ├── screens/
│   └── widgets/
└── <feature>.dart
```

## `lib/shared/`

Cross-cutting code that is not part of `core`:

- **animations/** — shared transition builders and animation helpers.
- **components/** — shared feature-aware components.
- **models/** — shared data models.
- **providers/** — core Riverpod providers.
- **repositories/** — shared repository abstractions.

## `test/`

Mirror the structure of `lib/` when adding tests. Foundation tests are in
`test/core/utils/...` and `test/core/errors/...`.
