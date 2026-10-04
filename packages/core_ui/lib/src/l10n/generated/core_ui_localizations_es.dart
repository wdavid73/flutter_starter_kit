// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_ui_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CoreUiLocalizationsEs extends CoreUiLocalizations {
  CoreUiLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get isRequired => 'El campo es requerido';

  @override
  String get isEmpty => 'Por favor llene el campo';

  @override
  String get isEmptyList => 'Por favor seleccione al menos un elemento';

  @override
  String get isEmptySelect => 'Por favor seleccione un elemento';

  @override
  String get isEmail => 'Por favor ingrese un correo valido';

  @override
  String get isNotEqual => 'Los valores no son iguales';

  @override
  String get isNotEqualPassword => 'Las contraseñas no coinciden';

  @override
  String get isPasswordLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get isInvalidPasswordPattern =>
      'La contraseña debe contener entre 6 y 20 caracteres, incluir mayúscula, minúscula y número.';

  @override
  String get loading => 'Cargando...';
}
