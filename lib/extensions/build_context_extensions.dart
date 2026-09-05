import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';

/// Theme lookups on [BuildContext].
extension ThemeExtensions on BuildContext {
  /// The nearest [ThemeData]. Use it when a widget needs more than one part
  /// of the theme; otherwise prefer [textTheme] or [colorScheme].
  ThemeData get theme => Theme.of(this);

  /// The theme's text styles.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// The theme's colors.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

/// Localization lookup on [BuildContext].
extension LocalizationExtensions on BuildContext {
  /// The localized strings for the current locale.
  ///
  /// Shorthand for `S.of(context)`, so a widget reads
  /// `context.strings.appTitle` instead of naming the generated class.
  S get strings => S.of(this);
}

/// Navigation helpers on [BuildContext].
///
/// They keep call sites reading as one line of intent — `context.push(...)` —
/// instead of `Navigator.of(context).pushNamed(...)`, and they take a route
/// name rather than a widget, so a screen never imports the screen it opens.
///
/// Only the operations the app actually performs live here. More are added
/// when a screen needs them, not in advance.
extension NavigationExtensions on BuildContext {
  /// Pushes [routeName] on top of the current screen.
  ///
  /// [arguments] is handed to the route as `RouteSettings.arguments`. The
  /// future completes with the value the pushed screen pops with, or `null`
  /// if it popped without one.
  Future<T?> push<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Pops the current screen, optionally returning [result] to whoever
  /// pushed it.
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
}
