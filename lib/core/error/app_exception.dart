/// What the data layer throws: a code naming the cause, never a message.
///
/// Sealed and split in two because only a refusal from the server has a
/// status code, so only [ServerException] carries one.
sealed class AppException implements Exception {
  const AppException({required this.errorCode});

  final String errorCode;
}

/// The server answered and refused. [statusCode] is always a real one.
final class ServerException extends AppException {
  const ServerException({required super.errorCode, required this.statusCode});

  final int statusCode;
}

/// Everything else: no connection, a timeout, an unreadable body.
final class GeneralException extends AppException {
  const GeneralException({required super.errorCode});
}
