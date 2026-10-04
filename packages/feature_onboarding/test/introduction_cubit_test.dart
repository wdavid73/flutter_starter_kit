import 'package:core_storage/core_storage.dart';
import 'package:feature_onboarding/feature_onboarding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorage extends Mock implements KeyValueStorageService {}

void main() {
  late KeyValueStorageService storage;

  setUp(() {
    storage = _MockStorage();
    when(() => storage.setKeyValue<bool>(any(), any())).thenAnswer((_) async {});
  });

  test('loads hasSeen=false when nothing was stored', () async {
    when(() => storage.getValue<bool>('hasSeenIntroduction'))
        .thenAnswer((_) async => null);

    final cubit = IntroductionCubit(storage);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.hasSeen, isFalse);
    expect(cubit.state.isLoading, isFalse);
  });

  test('loads hasSeen=true when it was stored', () async {
    when(() => storage.getValue<bool>('hasSeenIntroduction'))
        .thenAnswer((_) async => true);

    final cubit = IntroductionCubit(storage);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.hasSeen, isTrue);
  });

  test('markIntroductionAsSeen persists the flag and updates the state',
      () async {
    when(() => storage.getValue<bool>('hasSeenIntroduction'))
        .thenAnswer((_) async => false);
    final cubit = IntroductionCubit(storage);
    await Future<void>.delayed(Duration.zero);

    await cubit.markIntroductionAsSeen();

    verify(() => storage.setKeyValue('hasSeenIntroduction', true)).called(1);
    expect(cubit.state.hasSeen, isTrue);
  });
}
