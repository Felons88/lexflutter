# Contributing to LEX

## Workflow

1. Create a feature branch from the latest default branch.
2. Make focused, minimal changes.
3. Run `flutter analyze` and `flutter test` before committing.
4. Open a pull request with a clear description and tests.

## Code Style

- Follow the `flutter_lints` rules in `analysis_options.yaml`.
- Prefer `final` and `const` where possible.
- Use `const` constructors for widgets and data classes.
- Keep widgets small and focused. Extract widgets rather than nesting deeply.
- Use `const` with constructors when possible.
- Do not hard-code strings, colors, or styles in UI files; use theme tokens and
  constants.

## Naming Conventions

- Files and classes: `PascalCase`.
- Variables and functions: `camelCase`.
- Private members: `_leadingUnderscore`.
- Constants: `kConstantName` for global constants.
- Providers: `lowerCamelCaseProvider`.

## Architecture

- Place app-wide code in `lib/core/`.
- Add feature code in `lib/features/<feature>/` with `data/`, `domain/`, and
  `presentation/` subfolders.
- Shared cross-cutting code goes in `lib/shared/`.
- Keep `core` independent of `features` and `shared`.

## Testing

- Add tests for `lib/core/utils` and `lib/core/errors`.
- Use `flutter_test` for widget tests and `test` for pure Dart logic.
- Run the full test suite before committing:

  ```bash
  flutter test
  ```

## Linting

The project uses strict lint rules. Ensure a clean analyzer before submitting:

```bash
flutter analyze
```

No analyzer issues or warnings should be present.

## Riverpod Guidelines

- Use `Provider` for immutable dependencies.
- Use `StateProvider` or `AsyncNotifier` for mutable state.
- Prefer `ref.watch` for reactive dependencies and `ref.read` for one-time reads.
- Use `select` to avoid unnecessary rebuilds.
- Do not pass `WidgetRef` into business logic; use `Provider` `ref` inside
  providers.

## Theme & UI

- Access theme tokens via `Theme.of(context).extension<Token>()` or the
  `BuildContext` extensions.
- Use `AppSpacing`, `AppRadius`, `AppColors`, `AppShadows`, and `AppDurations`
  instead of magic numbers.
- Support dark mode by default. Light mode is a secondary target.

## Commit Messages

- Use the imperative mood.
- Keep the first line under 50 characters.
- Add a description for non-trivial changes.

Example:

```
Add shimmer loading state to LexCard

- Adds LexSkeletonLoader for placeholder states.
- Updates card theme to remove default background.
```

## Pull Request Checklist

- [ ] `flutter analyze` passes with no issues.
- [ ] `flutter test` passes.
- [ ] New code follows the folder structure.
- [ ] Theme tokens are used instead of hard-coded values.
- [ ] Providers are named and placed correctly.
- [ ] No new dependencies are added without discussion.
