// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AuthLocalizationsEn extends AuthLocalizations {
  AuthLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signInAccount => 'Sign in to your account';

  @override
  String get notHaveAccount => 'Don\'t have an account?';

  @override
  String get createOneHere => 'Create one here';

  @override
  String get signUp => 'Sign Up';

  @override
  String get login => 'Log In';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get comingSoon => 'Coming soon...';

  @override
  String get fullnameLabel => 'Full name';

  @override
  String get fullnameHint => 'Enter your full name';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get connectionTimeOut => 'The connection request timed out.';

  @override
  String get invalidCredential =>
      'Invalid credentials. Check your email and password.';

  @override
  String get emailAlreadyInUse => 'This email is already registered.';

  @override
  String get wrongPassword => 'Incorrect password.';

  @override
  String get invalidEmail => 'Invalid email format.';

  @override
  String get weakPassword =>
      'Password is too weak (must be at least 6 characters).';
}
