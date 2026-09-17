/// The causes this app can name. Anything else is [ErrorCodes.unknown].
abstract final class ErrorCodes {
  static const noInternetConnection = 'NO_INTERNET_CONNECTION';
  static const timeout = 'TIMEOUT';
  static const notFound = 'NOT_FOUND';
  static const serverError = 'SERVER_ERROR';
  static const parsingError = 'PARSING_ERROR';
  static const cacheError = 'CACHE_ERROR';
  static const unknown = 'UNKNOWN';
}
