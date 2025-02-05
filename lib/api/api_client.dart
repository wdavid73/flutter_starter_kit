import 'package:dio/dio.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/infrastructure/infrastructure.dart';

class ApiClient {
  final _client = createDio();
  ApiClient._internal();

  static final _singleton = ApiClient._internal();
  factory ApiClient() => _singleton;

  static BaseOptions createBaseOptions() => BaseOptions(
        baseUrl: Environment.apiUrl,
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {'Content-Type': 'application/json'},
      );

  static Dio createDio() {
    final storageDevice = KeyValueStorageServiceImpl();
    final dio = Dio(createBaseOptions());
    dio.interceptors.add(ApiTokenInterceptor(
      storageDevice,
    ));
    dio.interceptors.add(ApiErrorsInterceptor());
    return dio;
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) =>
      _client.get(url, queryParameters: serializerQueryParams(queryParams));

  Future<Response> post(String url, dynamic body) =>
      _client.post(url, data: body);

  Future<Response> put(String url, dynamic body) =>
      _client.put(url, data: body);

  Future<Response> patch(String url, dynamic body) =>
      _client.patch(url, data: body);

  Future<Response> delete(String url) => _client.delete(url);

  static ApiClient get instance {
    ApiClient defaultAppClientInstance = ApiClient();
    return defaultAppClientInstance;
  }
}