import 'package:flutter_clean_architecture_steps/core/error/error_codes.dart';

/// What the data layer throws: a code naming the cause, never a message.
///
/// Sealed and split by what each case carries: only a refusal from the server
/// has a status code, so only [ServerException] holds one.
sealed class AppException implements Exception {
  const AppException({required this.errorCode});

  final String errorCode;
}

/// The server answered and refused. [statusCode] is always a real one.
final class ServerException extends AppException {
  const ServerException({required super.errorCode, required this.statusCode});

  final int statusCode;
}

/// Local storage refused to read or write. One code for every table: the
/// screen has nothing different to say about which one failed.
final class CacheException extends AppException {
  const CacheException() : super(errorCode: ErrorCodes.cacheError);
}

/// Everything else: no connection, a timeout, an unreadable body.
final class GeneralException extends AppException {
  const GeneralException({required super.errorCode});
}
