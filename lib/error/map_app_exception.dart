import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_steps/error/app_exception.dart';
import 'package:flutter_clean_architecture_steps/error/error_codes.dart';

/// Turns anything thrown at the network into a named [AppException]. The only
/// place that knows about Dio.
AppException mapAppException(Object error) {
  return switch (error) {
    final AppException appException => appException,
    final DioException dioException => _mapDioException(dioException),
    FormatException() || TypeError() => const GeneralException(
      errorCode: ErrorCodes.parsingError,
    ),
    _ => const GeneralException(errorCode: ErrorCodes.unknown),
  };
}

AppException _mapDioException(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const GeneralException(
      errorCode: ErrorCodes.timeout,
    ),
    DioExceptionType.badResponse => _mapBadResponse(error.response),
    DioExceptionType.connectionError ||
    DioExceptionType.unknown => _mapUnderlyingError(error.error),
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel => const GeneralException(
      errorCode: ErrorCodes.unknown,
    ),
  };
}

/// Built only once a real status code has been read, which is what keeps
/// [ServerException.statusCode] non-null everywhere else.
AppException _mapBadResponse(Response<dynamic>? response) {
  return switch (response?.statusCode) {
    final int statusCode => ServerException(
      errorCode: statusCode == 404
          ? ErrorCodes.notFound
          : ErrorCodes.serverError,
      statusCode: statusCode,
    ),
    null => const GeneralException(errorCode: ErrorCodes.unknown),
  };
}

/// Dio hands back whatever was thrown underneath, so that decides.
AppException _mapUnderlyingError(Object? error) {
  return switch (error) {
    final AppException appException => appException,
    final SocketException socketException => _mapSocketException(
      socketException,
    ),
    FormatException() || TypeError() => const GeneralException(
      errorCode: ErrorCodes.parsingError,
    ),
    _ => const GeneralException(errorCode: ErrorCodes.unknown),
  };
}

/// A null [SocketException.address] means no endpoint was ever reached, which
/// is what being offline looks like. A refusal from one carries its address.
AppException _mapSocketException(SocketException error) {
  return switch (error.address) {
    null => const GeneralException(
      errorCode: ErrorCodes.noInternetConnection,
    ),
    _ => const GeneralException(errorCode: ErrorCodes.unknown),
  };
}
