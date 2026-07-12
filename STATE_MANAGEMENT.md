# State Management

LEX uses [Riverpod](https://riverpod.dev/) (v3) for state management, dependency
injection, and reactive caching. The architecture is provider-first: widgets
consume providers, and providers coordinate services, repositories, and use cases.

## Provider Conventions

- **Core providers** live in `lib/shared/providers/core_providers.dart`.
- **Feature providers** live in `lib/features/<feature>/presentation/providers/`.
- Providers are `final` top-level variables named with the `Provider` suffix.
- Providers should be `Provider` for read-only state, `StateProvider` for simple
  mutable state, `FutureProvider`/`AsyncNotifier` for async data, and
  `StateNotifier`/`AsyncNotifier` for complex state.
- `Ref` is used non-generically (`ProviderRef`, `WidgetRef`, etc.) as per
  Riverpod 3.x.

## Core Providers

`core_providers.dart` exposes the application dependencies:

- `appConfigProvider` — environment config.
- `loggerProvider` — `AppLogger` instance.
- `firebaseInitializerProvider` — `FutureProvider<FirebaseApp>`.
- `firebaseAuthProvider`, `firebaseFirestoreProvider`, `firebaseStorageProvider`,
  `firebaseMessagingProvider`, `firebaseAnalyticsProvider`,
  `firebaseCrashlyticsProvider`, `firebaseRemoteConfigProvider` — Firebase SDK
  singletons.
- `connectivityProvider`, `networkInfoProvider` — network state.
- `secureStorageServiceProvider` — secure storage.
- `analyticsServiceProvider`, `crashlyticsServiceProvider`,
  `remoteConfigServiceProvider` — service wrappers.
- `appInfoServiceProvider`, `deviceInfoServiceProvider` — device metadata.
- `permissionManagerProvider` — permission helpers.
- `dioClientProvider` — HTTP client.

## Theme Provider

`themeProvider` is a `StateProvider<ThemeMode>` that defaults to `ThemeMode.dark`.
It is imported from `flutter_riverpod/legacy.dart` because it uses `StateProvider`.

## Routing Provider

`appRouterProvider` returns a configured `GoRouter` instance. It watches the
`routeGuardProvider` so redirects react to auth state.

## Consumer Widgets

Screens and widgets extend `ConsumerWidget` and read/watch providers with `ref`:

```dart
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppConfig config = ref.watch(appConfigProvider);
    return Scaffold(...);
  }
}
```

## Avoiding Common Issues

- Do not use `context` to read providers when `ref` is available.
- Watch only what the widget needs. Use `select` for fine-grained rebuilds when
  a provider exposes a large object.
- Keep providers small and focused. One provider should have one responsibility.
- Use `overrideWithValue` for dependency injection in tests and `main.dart`.
- `FutureProvider` and `AsyncNotifier` are the preferred way to load async data.

## Error Handling

`AsyncValue` can be pattern-matched to separate loading, error, and data states:

```dart
final AsyncValue<FirebaseApp> firebase = ref.watch(firebaseInitializerProvider);

firebase.when(
  data: (app) => const HomeScreen(),
  loading: () => const SplashScreen(),
  error: (error, stack) => ErrorScreen(message: error.toString()),
);
```

Business errors are also represented as `Result<T, Failure>` in repositories and
use cases.
