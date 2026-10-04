import 'package:core_storage/core_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_session/platform_session.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class MockKeyValueStorageService extends Mock
    implements KeyValueStorageService {}
