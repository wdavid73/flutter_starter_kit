import 'package:core_storage/core_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late KeyValueStorageService storage;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    storage = KeyValueStorageServiceImpl();
  });

  test('stores and reads back a String', () async {
    await storage.setKeyValue<String>('token', 'abc');

    expect(await storage.getValue<String>('token'), 'abc');
  });

  test('stores and reads back a bool', () async {
    await storage.setKeyValue<bool>('flag', true);

    expect(await storage.getValue<bool>('flag'), isTrue);
  });

  test('returns null for a missing key', () async {
    expect(await storage.getValue<String>('missing'), isNull);
  });

  test('removeKey deletes the stored value', () async {
    await storage.setKeyValue<int>('count', 3);

    await storage.removeKey('count');

    expect(await storage.getValue<int>('count'), isNull);
  });
}
