import 'package:dio/dio.dart';

ErrorHandler handlerErrorResponse(
  DioException err,
  String? message,
) {
  return ErrorHandler(
    requestOptions: err.requestOptions,
    message: message ?? err.message,
    error: err.error,
  );
}

class ErrorHandler {
  final String? message;
  final Object? error;
  final RequestOptions requestOptions;

  ErrorHandler({
    this.message,
    this.error,
    required this.requestOptions,
  });
}