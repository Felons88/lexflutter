# Theme System

LEX uses a custom Material 3 theme with a dark-first identity. The theme is built
from design tokens that are exposed as `ThemeExtension`s for easy access anywhere
in the widget tree.

## Theme Factory

- `AppTheme.dark` and `AppTheme.light` return fully configured `ThemeData`.
- `ThemeData` uses `useMaterial3: true`.
- Component themes are generated for `AppBar`, `Card`, `BottomNavigationBar`,
  `NavigationBar`, `Dialog`, `BottomSheet`, `SnackBar`, `InputDecoration`,
  `ElevatedButton`, `OutlinedButton`, `TextButton`, `IconButton`, `FloatingActionButton`,
  `TabBar`, and `Divider`.

## Design Tokens

All tokens are available through `Theme.of(context).extension<...>()` and
extensions on `BuildContext`.

### Colors

`AppColors` is a `ThemeExtension` that holds:

- `primaryGradient` — purple/magenta gradient for CTAs and hero backgrounds.
- `accentGradient` — magenta/purple gradient for badges and emphasis.
- `surfaceGradient` — dark-to-elevated gradient for floating surfaces.
- `success`, `onSuccess` — positive state.
- `warning`, `onWarning` — attention state.
- `info`, `onInfo` — helper state.
- `glassBackground` / `glassBorder` — glassmorphism card values.
- `shadow` — shadow tint.
- `shimmerBase` / `shimmerHighlight` — shimmer placeholder colors.

The `ColorScheme` in `AppTheme` defines primary, secondary, tertiary, error,
surface, onSurface, surfaceContainerHighest, outline, and other Material 3
color roles.

### Typography

`AppTypography` builds a `TextTheme` from `Typography.material2021` with a
7-weight scale. The default font family is `Roboto`.

| Token | Size | Weight | Line Height |
|-------|------|--------|-------------|
| displayLarge | 57 | w700 | 1.12 |
| displayMedium | 45 | w700 | 1.16 |
| displaySmall | 36 | w700 | 1.22 |
| headlineLarge | 32 | w700 | 1.25 |
| headlineMedium | 28 | w600 | 1.28 |
| headlineSmall | 24 | w600 | 1.33 |
| titleLarge | 22 | w600 | 1.27 |
| titleMedium | 16 | w600 | 1.5 |
| titleSmall | 14 | w600 | 1.43 |
| bodyLarge | 16 | w400 | 1.5 |
| bodyMedium | 14 | w400 | 1.5 |
| bodySmall | 12 | w400 | 1.33 |
| labelLarge | 14 | w600 | 1.43 |
| labelMedium | 12 | w600 | 1.33 |
| labelSmall | 11 | w600 | 1.45 |

### Spacing

`AppSpacing` is a 4dp grid scale:

| Token | Value |
|-------|-------|
| none | 0 |
| xxs | 2 |
| xs | 4 |
| sm | 8 |
| md | 12 |
| lg | 16 |
| xl | 24 |
| xxl | 32 |
| xxxl | 48 |
| huge | 64 |

Helper getters such as `allMd`, `horizontalLg`, and `verticalXl` return
`EdgeInsets`.

### Radius

`AppRadius` holds corner radius tokens:

| Token | Value |
|-------|-------|
| none | 0 |
| xs | 4 |
| sm | 8 |
| md | 12 |
| lg | 16 |
| xl | 24 |
| xxl | 32 |
| full | 1000 |

`BorderRadius` and `Radius` getters are provided.

### Shadows

`AppShadows` provides elevation shadows:

- `none`
- `xs` (2dp)
- `sm` (4dp)
- `md` (8dp)
- `lg` (16dp)
- `xl` (32dp)
- `glow` (pink/purple brand glow)

### Durations

`AppDurations` controls animation timing:

| Token | Value |
|-------|-------|
| instant | 0ms |
| fast | 150ms |
| normal | 250ms |
| slow | 400ms |
| slower | 600ms |

### Animations & Curves

`AppAnimations` re-exports `AppCurves` and `AppDurations` and adds spring
constants (`springDefault`, `springSoft`, `springSnappy`) plus page transition
durations.

`AppCurves` defines:

- `defaultCurve` — `easeInOut`
- `enter` — `decelerate`
- `exit` — `easeIn`
- `emphasized` — `easeInOutCubicEmphasized`
- `bounce` — `elasticOut`
- `spring` — `fastOutSlowIn`
- `linear` — `linear`

## Accessing Tokens

Access tokens from any `BuildContext`:

```dart
final AppColors colors = Theme.of(context).extension<AppColors>()!;
final AppSpacing spacing = Theme.of(context).extension<AppSpacing>()!;
```

Or use the extension helpers in `lib/core/extensions/build_context_extensions.dart`.

## Theme Mode

The active theme mode is controlled by the `themeProvider` in
`lib/shared/providers/theme_provider.dart`. The default is `ThemeMode.dark`.
