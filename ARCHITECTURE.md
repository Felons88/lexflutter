# Architecture

LEX follows a layered, feature-first architecture that separates the UI from
data and services.

## High-Level Layers

```
lib/
├── main.dart              # Entry point, bootstrapping
├── app.dart               # Top-level MaterialApp + Riverpod ProviderScope
├── core/                  # Shared, app-wide code
├── features/              # One folder per feature
└── shared/                # Shared components, models, providers, repositories
```

## Core Layer

`lib/core/` contains code that is used by every feature. It is divided into:

- **config** — environment configuration (`AppConfig`, `Environment`).
- **constants** — static constants.
- **errors** — failure types and the `Result` monad.
- **extensions** — `BuildContext` and other extensions.
- **logging** — `AppLogger` and `ErrorHandler`.
- **routing** — `GoRouter` configuration, routes, and `RouteGuard`.
- **services** — network, Firebase, device, analytics, permissions, storage,
  remote config, and connectivity.
- **theme** — design tokens and `ThemeData` factory.
- **utils** — pure helpers such as `Result`, `Failure`, `Validators`,
  `Formatters`, `DateUtils`, `CurrencyUtils`, and `PlatformUtils`.
- **widgets** — reusable base widgets (`LexAppBar`, `LexCard`, `LexButton`, etc.).

## Feature Layer

`lib/features/` is intentionally empty at the start. Each feature contains:

```
lib/features/<feature>/
├── data/
│   ├── models/            # Data models
│   └── repositories/      # Repository implementations
├── domain/
│   ├── entities/          # Domain entities
│   └── usecases/          # Feature-specific use cases
├── presentation/
│   ├── providers/         # Riverpod providers
│   ├── screens/           # Pages / screens
│   └── widgets/           # Feature-specific widgets
└── <feature>.dart         # Feature barrel file
```

## Shared Layer

`lib/shared/` holds cross-cutting code that is not part of `core` but is shared
by features:

- **animations** — transition builders and animation constants.
- **components** — shared feature-aware components.
- **models** — shared data models.
- **providers** — core Riverpod providers.
- **repositories** — shared repository interfaces/impls.

## State Management

State is managed with Riverpod. Providers live in `lib/shared/providers/` and
feature `presentation/providers/`. See [STATE_MANAGEMENT.md](STATE_MANAGEMENT.md)
for conventions.

## Dependency Flow

```
UI -> Riverpod providers -> Use cases / repositories -> Services / Firebase
```

- `core/services` are the lowest layer and interact with plugins, network, and
  Firebase.
- `core/utils` are pure helpers with no side effects.
- `core/widgets` are dumb and receive data via `ConsumerWidget` / `Consumer`.

## Routing

Navigation is handled by `go_router` with `StatefulShellRoute.indexedStack` for
tab-based navigation. `RouteGuard` decides redirects based on authentication and
environment configuration. See `lib/core/routing/`.

## Error Handling

Business errors are represented as `Failure` objects. `Result<T, Failure>` is
used to return either a value or a failure. The `ErrorHandler` captures global
Flutter errors and uncaught async errors.
