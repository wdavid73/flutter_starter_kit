import 'package:flutter/widgets.dart';

/// Wraps a generated [LocalizationsDelegate] so that it accepts every locale
/// the app supports, loading [fallback] when [inner] does not provide it.
///
/// Packages own their languages independently. Without this wrapper, Flutter
/// reports a debug warning when the app supports a locale that a package
/// does not translate.
class FallbackLocalizationsDelegate<T> extends LocalizationsDelegate<T> {
  const FallbackLocalizationsDelegate(
    this.inner, {
    this.fallback = const Locale('en'),
  });

  final LocalizationsDelegate<T> inner;
  final Locale fallback;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<T> load(Locale locale) =>
      inner.load(inner.isSupported(locale) ? locale : fallback);

  @override
  bool shouldReload(covariant FallbackLocalizationsDelegate<T> old) =>
      inner.shouldReload(old.inner);
}
