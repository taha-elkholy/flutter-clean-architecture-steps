import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture_steps/core/error/failure.dart';

@immutable
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;

  const factory Result.failed(Failure failure) = Error<T>;

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onError,
  }) {
    return switch (this) {
      Success(:final data) => onSuccess(data),
      Error(:final failure) => onError(failure),
    };
  }
}

@immutable
final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

@immutable
final class Error<T> extends Result<T> {
  const Error(this.failure);

  final Failure failure;
}
