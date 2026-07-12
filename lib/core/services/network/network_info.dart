import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// {@template network_info}
/// Abstract connectivity monitor used by the network layer and repositories.
/// {@endtemplate}
abstract interface class NetworkInfo {
  /// Stream of connectivity status changes.
  Stream<bool> get onStatusChange;

  /// Returns true if the device is currently connected to a network.
  Future<bool> get isConnected;

  /// Returns the current connectivity result list.
  Future<List<ConnectivityResult>> get connectivityResult;
}

/// {@template connectivity_network_info}
/// [NetworkInfo] implementation backed by [connectivity_plus].
/// {@endtemplate}
class ConnectivityNetworkInfo implements NetworkInfo {
  /// {@macro connectivity_network_info}
  ConnectivityNetworkInfo({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Stream<bool> get onStatusChange => _connectivity.onConnectivityChanged
      .map((List<ConnectivityResult> results) => _isConnected(results));

  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    return _isConnected(results);
  }

  @override
  Future<List<ConnectivityResult>> get connectivityResult async {
    return _connectivity.checkConnectivity();
  }

  bool _isConnected(List<ConnectivityResult> results) {
    return results.isNotEmpty &&
        !results.contains(ConnectivityResult.none) &&
        !results.contains(ConnectivityResult.bluetooth);
  }
}
