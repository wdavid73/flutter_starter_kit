import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';

class BadRequestException extends DioException {
  BadRequestException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    /*final context = requestOptions.extra['context'] as BuildContext?;
    if (context == null)  return 'DioException [BadRequest]: $message';
    return AppLocalizations.of(context).translate('badRequest');*/
    return 'DioException [BadRequest]: $message';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [Unauthorized]: $message';
  }
}

class NotFoundException extends DioException {
  NotFoundException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [NotFound]: $message';
  }
}

class ConflictException extends DioException {
  ConflictException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [Conflict]: $message';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [InternalServerError]: $message';
  }
}

class UnknownException extends DioException {
  UnknownException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [UnknownException]: $message';
  }
}

class NoInternetConnection extends DioException {
  NoInternetConnection(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceeded extends DioException {
  DeadlineExceeded(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class BadCertificate extends DioException {
  BadCertificate(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The certificate is not reliable.';
  }
}

class BadResponse extends DioException {
  BadResponse(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error processing the response';
  }
}

class Unknown extends DioException {
  Unknown(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'unknown server error';
  }
}

class ConnectionTimeout extends DioException {
  ConnectionTimeout(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection timeout has been exceeded';
  }
}

class SendTimeout extends DioException {
  SendTimeout(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Send lead time has been exceeded';
  }
}

class ApiException extends DioException {
  ApiException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'An unknown error occurred processing the request.';
  }
}

class GoogleSignInError {
  final String message;

  GoogleSignInError(this.message);

  @override
  String toString() => "GoogleSignInError: $message";
}