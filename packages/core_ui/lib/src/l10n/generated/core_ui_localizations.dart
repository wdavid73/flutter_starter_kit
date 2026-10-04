import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'core_ui_localizations_en.dart';
import 'core_ui_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CoreUiLocalizations
/// returned by `CoreUiLocalizations.of(context)`.
///
/// Applications need to include `CoreUiLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/core_ui_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CoreUiLocalizations.localizationsDelegates,
///   supportedLocales: CoreUiLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CoreUiLocalizations.supportedLocales
/// property.
abstract class CoreUiLocalizations {
  CoreUiLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CoreUiLocalizations? of(BuildContext context) {
    return Localizations.of<CoreUiLocalizations>(context, CoreUiLocalizations);
  }

  static const LocalizationsDelegate<CoreUiLocalizations> delegate =
      _CoreUiLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @isRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get isRequired;

  /// No description provided for @isEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please fill out the field'**
  String get isEmpty;

  /// No description provided for @isEmptyList.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one item'**
  String get isEmptyList;

  /// No description provided for @isEmptySelect.
  ///
  /// In en, this message translates to:
  /// **'Please select an option'**
  String get isEmptySelect;

  /// No description provided for @isEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get isEmail;

  /// No description provided for @isNotEqual.
  ///
  /// In en, this message translates to:
  /// **'Values do not match'**
  String get isNotEqual;

  /// No description provided for @isNotEqualPassword.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get isNotEqualPassword;

  /// No description provided for @isPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get isPasswordLength;

  /// No description provided for @isInvalidPasswordPattern.
  ///
  /// In en, this message translates to:
  /// **'Password must be 6–20 characters with uppercase, lowercase, and a number.'**
  String get isInvalidPasswordPattern;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;
}

class _CoreUiLocalizationsDelegate
    extends LocalizationsDelegate<CoreUiLocalizations> {
  const _CoreUiLocalizationsDelegate();

  @override
  Future<CoreUiLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreUiLocalizations>(
        lookupCoreUiLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_CoreUiLocalizationsDelegate old) => false;
}

CoreUiLocalizations lookupCoreUiLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return CoreUiLocalizationsEn();
    case 'es':
      return CoreUiLocalizationsEs();
  }

  throw FlutterError(
      'CoreUiLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
