import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_steps/network/connectivity_interceptor.dart';
import 'package:flutter_clean_architecture_steps/network/logging_interceptor.dart';

/// The one way this app talks to the network.
///
/// Dio lives inside this class and never leaves it: callers pass a path and a
/// query, and get a decoded body back. The base url, the timeouts and the
/// logging are configured here alone.
///
/// It exposes [get] alone, because reading is all this app does.
class ApiClient {
  static const _baseUrl = 'https://dummyjson.com';
  static const _timeout = Duration(seconds: 15);

  final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: _timeout,
            receiveTimeout: _timeout,
          ),
        )
        ..interceptors.addAll([
          ConnectivityInterceptor(),
          LoggingInterceptor(),
        ]);

  /// Reads [path] and returns the decoded body.
  ///
  /// Dio decodes the json itself and throws on a failing status code, so
  /// neither is left to the caller.
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );

    return response.data ?? const {};
  }

  /// Drops the connections this client holds open. Only whoever built this
  /// client may call it: any request after it throws.
  void close() => _dio.close();
}
