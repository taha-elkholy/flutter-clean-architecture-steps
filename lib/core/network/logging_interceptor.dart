import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_steps/core/helpers/log_helpers.dart';

class LoggingInterceptor extends Interceptor {
  static const _name = 'API';

  static const _encoder = JsonEncoder.withIndent('  ');

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    debugLog(
      '$_name onRequest',
      _requestLines(options).join('\n'),
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog(
      '$_name onResponse',
      [
        ..._requestLines(response.requestOptions),
        'status: ${response.statusCode}',
        'body: ${_pretty(response.data)}',
      ].join('\n'),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugLog(
      '$_name onError',
      [
        ..._requestLines(err.requestOptions),
        'type: ${err.type.name}',
        if (err.response?.statusCode case final status?) 'status: $status',
        if (err.message case final message?) 'message: $message',
        if (err.response?.data case final data?) 'body: ${_pretty(data)}',
      ].join('\n'),
    );
    handler.next(err);
  }

  /// Shared by all three, so a response can be read without scrolling back to
  /// find what asked for it. [RequestOptions.uri] already carries the query.
  static List<String> _requestLines(RequestOptions options) => [
    '${options.method} ${options.uri}',
    'headers: ${_pretty(options.headers)}',
    if (options.data case final data?) 'data: ${_pretty(data)}',
  ];

  /// A failing response often carries an html page or plain text rather than
  /// json, and that is printed as it is.
  static String _pretty(Object? value) => switch (value) {
    Map<dynamic, dynamic>() || List<dynamic>() => _encoder.convert(value),
    _ => '$value',
  };
}
