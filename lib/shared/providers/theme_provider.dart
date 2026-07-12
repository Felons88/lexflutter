import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// {@template theme_provider}
/// Controls the active theme mode for the LEX app.
///
/// The dark mode is the default identity and is therefore the initial value.
/// {@endtemplate}
final StateProvider<ThemeMode> themeProvider = StateProvider<ThemeMode>(
  (Ref ref) => ThemeMode.dark,
  name: 'themeProvider',
);
