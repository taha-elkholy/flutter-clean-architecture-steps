import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_steps/core/error/app_exception.dart';
import 'package:flutter_clean_architecture_steps/core/error/error_codes.dart';

/// [Connectivity] reports the interface, not whether the internet is
/// reachable, so wifi that leads nowhere still goes out and fails later.
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final results = await _connectivity.checkConnectivity();
    final hasConnection = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (hasConnection) {
      handler.next(options);
      return;
    }

    // Carries the cause itself, so the mapping needs no case for it. The flag
    // lets the error reach the interceptors below, which is what logs it.
    handler.reject(
      DioException(
        requestOptions: options,
        error: const GeneralException(
          errorCode: ErrorCodes.noInternetConnection,
        ),
      ),
      true,
    );
  }
}
