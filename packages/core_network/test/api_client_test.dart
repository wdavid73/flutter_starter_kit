import 'package:core_network/core_network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('createBaseOptions uses the configured base URL', () {
    ApiClient.configure(baseUrl: 'http://localhost:3000/api');

    final options = ApiClient.createBaseOptions();

    expect(options.baseUrl, 'http://localhost:3000/api');
    expect(options.headers['Content-Type'], 'application/json');
  });
}
