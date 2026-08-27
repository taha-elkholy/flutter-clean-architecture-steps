import 'package:flutter/material.dart';

// The app's single source of truth for colors and text styles.
//
// Nothing here is exposed on its own: pages and widgets read what they
// need through `Theme.of(context)`. Adding a dark theme later means
// adding a second ThemeData here, and touching no widgets at all.
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    colorScheme: _lightScheme,
    scaffoldBackgroundColor: _lightScheme.surface,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightScheme.surface,
      elevation: 0,
      // An AppBar builds its title from its own defaults, not from
      // textTheme, so the bold title has to be handed to it directly.
      titleTextStyle: _appBarTitle,
      actionsIconTheme: IconThemeData(color: _lightScheme.secondary),
    ),
  );

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,

    // Page and app bar background.
    surface: Color(0xFFFBF8F4),
    // Headings and recipe names — the darkest text on the page.
    onSurface: Color(0xFF2B2420),
    // Secondary text: the cuisine/difficulty line, the search hint, the
    // broken-image icon.
    onSurfaceVariant: Color(0xFFA08F76),
    // The block behind an image that is loading or failed.
    surfaceContainerHighest: Color(0xFFEFE7DC),
    // The translucent white pill behind a card's rating.
    surfaceContainerLowest: Color(0xE6FFFFFF),

    // The terracotta accent: the selected sort chip, the refresh spinner,
    // the bouncing loading dots.
    primary: Color(0xFFC8683B),
    onPrimary: Colors.white,

    // App bar action icons and the unselected sort chip's label.
    secondary: Color(0xFF7A6A55),
    onSecondary: Colors.white,

    // The rating badge's star and number.
    tertiary: Color(0xFFB4501F),
    onTertiary: Colors.white,

    // The sort chips' hairline border.
    outline: Color(0xFFE4D9C8),

    error: Color(0xFFB3261E),
    onError: Colors.white,
  );

  // The Material title size for an app bar, in bold.
  static final TextStyle _appBarTitle = TextStyle(
    color: _lightScheme.onSurface,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  // Sizes and weights only. Colors are left out on purpose — Flutter
  // resolves them from the ColorScheme, so a second theme restyles every
  // piece of text in the app by changing colors in one place.
  static const TextTheme _textTheme = TextTheme(
    // The recipe name on the details page.
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    // "Ingredients" / "Instructions" section headings.
    titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    // The cuisine/difficulty/calories line and the sort chip labels.
    bodySmall: TextStyle(fontSize: 13),
    // A grid card's recipe name.
    labelLarge: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
    // The star rating badge on a grid card.
    labelMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    // A grid card's cuisine/difficulty line.
    labelSmall: TextStyle(fontSize: 10.5),
  );
}
