import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_theme/platform_theme.dart';

class _MockStorage extends Mock implements Storage {}

void main() {
  late Storage storage;

  setUp(() {
    storage = _MockStorage();
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.write(any(), any<dynamic>()))
        .thenAnswer((_) async {});
    when(() => storage.delete(any())).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  test('starts in light mode', () {
    expect(ThemeModeCubit().state.isDarkMode, isFalse);
  });

  blocTest<ThemeModeCubit, ThemeModeState>(
    'toggleTheme switches to dark and back to light',
    build: ThemeModeCubit.new,
    act: (cubit) => cubit
      ..toggleTheme()
      ..toggleTheme(),
    expect: () => [
      const ThemeModeState(isDarkMode: true),
      const ThemeModeState(),
    ],
  );

  test('state survives a JSON round trip', () {
    final cubit = ThemeModeCubit();
    final json = cubit.toJson(const ThemeModeState(isDarkMode: true))!;

    expect(cubit.fromJson(json)?.isDarkMode, isTrue);
  });
}
