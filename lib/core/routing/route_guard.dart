import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/providers/core_providers.dart';
import '../config/app_config.dart';
import 'app_routes.dart';

/// {@template route_guard}
/// Guards routes based on the configured authentication policy.
///
/// In development mode authentication enforcement is disabled so Phase 1
/// navigation can be verified without a feature auth flow.  In production,
/// unauthenticated users are redirected to [AppRoutes.auth].
/// {@endtemplate}
class RouteGuard {
  /// {@macro route_guard}
  RouteGuard({required this._ref, required this._config});

  final Ref _ref;
  final AppConfig _config;

  /// Returns the redirect path or null when the route is allowed.
  String? redirect(BuildContext context, GoRouterState state) {
    if (!_config.enforceAuth) {
      return null;
    }

    final String location = state.matchedLocation;
    final bool isAuthenticated = _isAuthenticated();

    final bool isPublicRoute = AppRoutes.publicRoutes.contains(location);
    final bool isProtectedRoute = AppRoutes.protectedRoutes.contains(location);

    if (isProtectedRoute && !isAuthenticated) {
      return AppRoutes.auth;
    }

    if (isPublicRoute && isAuthenticated && location != AppRoutes.splash) {
      return AppRoutes.home;
    }

    return null;
  }

  bool _isAuthenticated() {
    try {
      final FirebaseAuth auth = _ref.read(firebaseAuthProvider);
      return auth.currentUser != null;
    } on Exception {
      // Firebase may not be initialized during tests; treat as not authenticated.
      return false;
    }
  }
}

/// {@template route_guard_provider}
/// Provider for the route guard instance.
/// {@endtemplate}
final routeGuardProvider = Provider<RouteGuard>(
  (Ref ref) => RouteGuard(ref: ref, config: ref.watch(appConfigProvider)),
  name: 'routeGuardProvider',
);
