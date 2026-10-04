import 'package:bloc_test/bloc_test.dart';
import 'package:core_ui/core_ui.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_auth/src/l10n/generated/auth_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_session/platform_session.dart';

class _MockAuthBloc extends MockBloc<AuthEvent, AuthState>
    implements AuthBloc {}

class _MockSignInCubit extends MockCubit<SignInFormState>
    implements SignInFormCubit {}

class _MockRegisterCubit extends MockCubit<RegisterFormState>
    implements RegisterFormCubit {}

void main() {
  late _MockSignInCubit signIn;

  setUp(() {
    final auth = _MockAuthBloc();
    signIn = _MockSignInCubit();
    final register = _MockRegisterCubit();
    when(() => auth.state)
        .thenReturn(const AuthState(authStatus: AuthStatus.notAuthenticated));
    when(() => signIn.state).thenReturn(const SignInFormState());
    when(() => register.state).thenReturn(const RegisterFormState());
    GetIt.instance
      ..registerSingleton<AuthBloc>(auth)
      ..registerSingleton<SignInFormCubit>(signIn)
      ..registerSingleton<RegisterFormCubit>(register);
  });

  tearDown(() => GetIt.instance.reset());

  Widget app(Locale locale) => MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          authLocalizationsDelegate,
          coreUiLocalizationsDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        home: Builder(
          builder: (context) => Theme(
            data: AppTheme.getLightTheme(context),
            child: const LoginScreen(),
          ),
        ),
      );

  testWidgets('shows the login texts in the current locale', (tester) async {
    await tester.pumpWidget(app(const Locale('es')));
    await tester.pump();

    expect(find.text('Acceda a su cuenta'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
  });

  testWidgets('tapping the login button submits the sign-in form',
      (tester) async {
    await tester.pumpWidget(app(const Locale('en')));
    await tester.pump();

    await tester.tap(find.text('Log In'));

    verify(() => signIn.onSubmit()).called(1);
  });

  test('errorByKey translates known keys and passes unknown ones through',
      () async {
    final l10n = await AuthLocalizations.delegate.load(const Locale('en'));

    expect(l10n.errorByKey('wrong-password'), l10n.wrongPassword);
    expect(l10n.errorByKey('something-else'), 'something-else');
    expect(l10n.errorByKey(null), isNull);
  });
}
