import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';

extension ThemeExtensions on BuildContext {
  /// Use it when a widget needs more than one part of the theme; otherwise
  /// prefer [textTheme] or [colorScheme].
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension LocalizationExtensions on BuildContext {
  S get strings => S.of(this);
}

/// These take a route name rather than a widget, so a screen never imports
/// the screen it opens.
extension NavigationExtensions on BuildContext {
  Future<T?> push<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
}
