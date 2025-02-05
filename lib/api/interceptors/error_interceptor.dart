import 'package:dio/dio.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';

class ApiErrorsInterceptor extends Interceptor {
  ApiErrorsInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response == null) {
      return handler.reject(_getExceptionForDioType(err));
    }

    int statusCode = err.response!.statusCode!;
    String? errorMessage;
    if (err.response?.data != null && err.response?.data is Map) {
      //? Adjust the key if needed
      errorMessage = err.response!.data['message']?.toString();
    }
    ErrorHandler errorHandler = handlerErrorResponse(err, errorMessage);

    if (statusCode == 401) {
      await _handlerUnauthorizedError(errorHandler);
    }

    return handler.reject(
      _getExceptionForStatusCode(statusCode, errorHandler),
    );
  }

  Future<void> _handlerUnauthorizedError(ErrorHandler errorHandler) async {
    // TODO: Clear shared preferences
    // TODO: navigate back to login screen
  }

  DioException _getExceptionForStatusCode(
    int statusCode,
    ErrorHandler errorHandler,
  ) {
    switch (statusCode) {
      case 400:
        return BadRequestException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 401:
        return UnauthorizedException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 404:
        return NotFoundException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 422:
        return ConflictException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 500:
        return InternalServerErrorException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      default:
        return UnknownException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
    }
  }
}

DioException _getExceptionForDioType(DioException err) {
  switch (err.type) {
    case DioExceptionType.connectionTimeout:
      return ConnectionTimeout(err.requestOptions);
    case DioExceptionType.sendTimeout:
      return SendTimeout(err.requestOptions);
    case DioExceptionType.receiveTimeout:
      return DeadlineExceeded(err.requestOptions);
    case DioExceptionType.connectionError:
      return NoInternetConnection(err.requestOptions);
    case DioExceptionType.badCertificate:
      return BadCertificate(err.requestOptions);
    case DioExceptionType.badResponse:
      return BadResponse(err.requestOptions);
    case DioExceptionType.unknown:
      return Unknown(err.requestOptions);
    case DioExceptionType.cancel:
      return ApiException(err.requestOptions);
  }
}