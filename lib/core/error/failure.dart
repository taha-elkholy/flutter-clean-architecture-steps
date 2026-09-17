import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/core/error/app_exception.dart';
import 'package:flutter_clean_architecture_steps/core/error/error_codes.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';

/// A failure as the UI sees it: something to show, and nothing else.
class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Phrases [exception] for the screen.
Failure mapFailure(AppException exception) {
  return Failure(message: _messageFor(exception.errorCode));
}

/// An unnamed code falls back to the generic message.
String _messageFor(String errorCode) {
  return switch (errorCode) {
    ErrorCodes.noInternetConnection => S.current.noInternetConnectionError,
    ErrorCodes.timeout => S.current.timeoutError,
    ErrorCodes.notFound => S.current.notFoundError,
    ErrorCodes.serverError => S.current.serverError,
    ErrorCodes.parsingError => S.current.parsingError,
    ErrorCodes.cacheError => S.current.cacheError,
    _ => S.current.somethingWentWrong,
  };
}
