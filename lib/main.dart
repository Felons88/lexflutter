import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/logging/error_handler.dart';
import 'core/logging/logger.dart';
import 'core/services/firebase/firebase_initializer.dart';
import 'shared/providers/core_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AppConfig config = AppConfig.fromEnvironment();
  final AppLogger logger = AppLogger(enabled: config.enableLogging);
  final ErrorHandler errorHandler = ErrorHandler(logger: logger);

  errorHandler.install();

  _initializeAndRun(config: config, logger: logger);
}

void _initializeAndRun({required AppConfig config, required AppLogger logger}) {
  final FirebaseInitializer initializer = FirebaseInitializer(logger: logger);

  initializer
      .initialize()
      .then((_) {
        runApp(
          ProviderScope(
            overrides: [loggerProvider.overrideWithValue(logger)],
            child: const LexApp(),
          ),
        );
      })
      .catchError((Object error) {
        logger.e('Failed to initialize Firebase', error: error);
        runApp(
          ProviderScope(
            overrides: [loggerProvider.overrideWithValue(logger)],
            child: const LexApp(),
          ),
        );
      });
}
