import 'dart:io';

import 'package:dio/dio.dart';

import '../../config/app_config.dart';
import '../../logging/logger.dart';

/// {@template dio_client}
/// Configured [Dio] HTTP client for backend communication.
///
/// The client is intentionally lean in Phase 1; feature interceptors
/// (auth tokens, refresh, retries) are added by the respective layers.
/// {@endtemplate}
class DioClient {
  /// {@macro dio_client}
  DioClient({required this._config, this._logger}) {
    _dio = _createDio();
  }

  final AppConfig _config;
  final AppLogger? _logger;
  late final Dio _dio;

  Dio get dio => _dio;

  Dio _createDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: _config.apiBaseUrl,
        connectTimeout: Duration(seconds: _config.connectTimeoutSeconds),
        receiveTimeout: Duration(seconds: _config.receiveTimeoutSeconds),
        sendTimeout: Duration(seconds: _config.sendTimeoutSeconds),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    dio.interceptors.add(_LoggingInterceptor(_logger));
    return dio;
  }
}

class _LoggingInterceptor extends Interceptor {
  _LoggingInterceptor(this._logger);

  final AppLogger? _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger?.d('HTTP ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger?.d('HTTP ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger?.e(
      'HTTP ${err.response?.statusCode} ${err.requestOptions.path}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
