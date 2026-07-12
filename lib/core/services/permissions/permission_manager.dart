import 'package:permission_handler/permission_handler.dart';

import '../../errors/failure.dart';
import '../../utils/result.dart';

/// {@template permission_manager}
/// Coordinates device permission requests and maps results to [Failure]
/// when access is denied.
/// {@endtemplate}
class PermissionManager {
  /// {@macro permission_manager}
  const PermissionManager();

  /// Requests camera permission.
  Future<Result<void, Failure>> requestCamera() async {
    return _request(Permission.camera);
  }

  /// Requests microphone permission.
  Future<Result<void, Failure>> requestMicrophone() async {
    return _request(Permission.microphone);
  }

  /// Requests photo library permission.
  Future<Result<void, Failure>> requestPhotos() async {
    return _request(Permission.photos);
  }

  /// Requests notification permission.
  Future<Result<void, Failure>> requestNotifications() async {
    return _request(Permission.notification);
  }

  /// Requests location permission.
  Future<Result<void, Failure>> requestLocation() async {
    return _request(Permission.location);
  }

  /// Checks whether a permission is permanently denied.
  Future<bool> isPermanentlyDenied(Permission permission) async {
    return permission.isPermanentlyDenied;
  }

  Future<Result<void, Failure>> _request(Permission permission) async {
    final PermissionStatus status = await permission.request();
    if (status.isGranted || status.isLimited) {
      return Result<void, Failure>.success(null);
    }
    if (status.isPermanentlyDenied) {
      return Result<void, Failure>.failure(
        Failure.permission(
          code: 'permanently_denied',
        ),
      );
    }
    return Result<void, Failure>.failure(
      Failure.permission(
        code: 'denied',
      ),
    );
  }
}

