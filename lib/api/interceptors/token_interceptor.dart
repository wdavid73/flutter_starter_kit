import 'package:dio/dio.dart';
import 'package:front_scaffold_flutter_v2/infrastructure/infrastructure.dart';

class ApiTokenInterceptor extends Interceptor {
  final KeyValueStorageService _keyValueStorageService;

  ApiTokenInterceptor(this._keyValueStorageService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await getToken();

    if (token == null) {
      return handler.next(options);
    }

    if (isExpired(token)) {
      await _handleExpiredToken();
      return handler.next(options);
    }

    _addTokenToHeader(token, options);
    return handler.next(options);
  }

  bool isExpired(String token) {
    //? Add logic to check if token is expired
    return false;
  }

  void _addTokenToHeader(String token, RequestOptions options) {
    options.headers.addAll({
      'Authorization': 'Bearer $token',
    });
  }

  Future<void> _handleExpiredToken() async {}

  Future<String?> getToken() async {
    String? token = await _keyValueStorageService.getValue<String>('token');
    return token;
  }
}