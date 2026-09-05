import 'package:flutter/material.dart';

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
