// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AuthLocalizationsEs extends AuthLocalizations {
  AuthLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get signInAccount => 'Acceda a su cuenta';

  @override
  String get notHaveAccount => '¿No tienes cuenta?';

  @override
  String get createOneHere => 'Crea una aquí';

  @override
  String get signUp => 'Regístrate';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get comingSoon => 'Próximamente...';

  @override
  String get fullnameLabel => 'Nombre Completo';

  @override
  String get fullnameHint => 'Ingresa tu nombre completo';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Ingresa tu email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Ingresa tu contraseña';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmPasswordHint => 'Confirmar tu contraseña';

  @override
  String get connectionTimeOut =>
      'La solicitud de conexión tardó mucho tiempo y fue abortada.';

  @override
  String get invalidCredential =>
      'Credenciales incorrectas. Verifica tu correo y contraseña.';

  @override
  String get emailAlreadyInUse => 'Este correo electrónico ya está registrado.';

  @override
  String get wrongPassword => 'La contraseña es incorrecta.';

  @override
  String get invalidEmail => 'El formato del correo electrónico no es válido.';

  @override
  String get weakPassword =>
      'La contraseña es demasiado débil (debe tener al menos 6 caracteres).';
}
