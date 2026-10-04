// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_ui_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CoreUiLocalizationsEn extends CoreUiLocalizations {
  CoreUiLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get isRequired => 'This field is required';

  @override
  String get isEmpty => 'Please fill out the field';

  @override
  String get isEmptyList => 'Please select at least one item';

  @override
  String get isEmptySelect => 'Please select an option';

  @override
  String get isEmail => 'Please enter a valid email';

  @override
  String get isNotEqual => 'Values do not match';

  @override
  String get isNotEqualPassword => 'Passwords do not match';

  @override
  String get isPasswordLength => 'Password must be at least 6 characters long';

  @override
  String get isInvalidPasswordPattern =>
      'Password must be 6–20 characters with uppercase, lowercase, and a number.';
}
