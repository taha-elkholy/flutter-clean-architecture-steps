// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Recipes`
  String get appTitle {
    return Intl.message(
      'Recipes',
      name: 'appTitle',
      desc: 'Application title, also shown in the recipe list app bar',
      args: [],
    );
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message(
      'Top Rated',
      name: 'topRated',
      desc: 'Recipe list sort chip: highest rated recipes first',
      args: [],
    );
  }

  /// `Most Reviewed`
  String get mostReviewed {
    return Intl.message(
      'Most Reviewed',
      name: 'mostReviewed',
      desc: 'Recipe list sort chip: most reviewed recipes first',
      args: [],
    );
  }

  /// `{cuisine} · {difficulty}`
  String recipeMeta(String cuisine, String difficulty) {
    return Intl.message(
      '$cuisine · $difficulty',
      name: 'recipeMeta',
      desc: 'Meta line under a recipe card: cuisine and difficulty',
      args: [cuisine, difficulty],
    );
  }

  /// `Recipe name placeholder`
  String get recipeNamePlaceholder {
    return Intl.message(
      'Recipe name placeholder',
      name: 'recipeNamePlaceholder',
      desc: 'Fake recipe name shown inside the skeleton loading cards',
      args: [],
    );
  }

  /// `Cuisine`
  String get cuisinePlaceholder {
    return Intl.message(
      'Cuisine',
      name: 'cuisinePlaceholder',
      desc: 'Fake cuisine shown inside the skeleton loading cards',
      args: [],
    );
  }

  /// `Easy`
  String get difficultyPlaceholder {
    return Intl.message(
      'Easy',
      name: 'difficultyPlaceholder',
      desc: 'Fake difficulty shown inside the skeleton loading cards',
      args: [],
    );
  }

  /// `No recipes to show`
  String get noRecipes {
    return Intl.message(
      'No recipes to show',
      name: 'noRecipes',
      desc:
          'Message shown on the recipe list when a sort comes back with no recipes',
      args: [],
    );
  }

  /// `Search recipes...`
  String get searchHint {
    return Intl.message(
      'Search recipes...',
      name: 'searchHint',
      desc: 'Hint text of the search field in the search page app bar',
      args: [],
    );
  }

  /// `Type a recipe name and hit enter`
  String get searchEmptyState {
    return Intl.message(
      'Type a recipe name and hit enter',
      name: 'searchEmptyState',
      desc: 'Message shown on the search page before any search is made',
      args: [],
    );
  }

  /// `No recipes matched your search`
  String get searchNoResults {
    return Intl.message(
      'No recipes matched your search',
      name: 'searchNoResults',
      desc: 'Message shown on the search page when a search returns nothing',
      args: [],
    );
  }

  /// `{cuisine} · {difficulty} · {calories} cal`
  String recipeMetaWithCalories(
    String cuisine,
    String difficulty,
    int calories,
  ) {
    return Intl.message(
      '$cuisine · $difficulty · $calories cal',
      name: 'recipeMetaWithCalories',
      desc:
          'Meta line on the details page: cuisine, difficulty and calories per serving',
      args: [cuisine, difficulty, calories],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: 'Section title above the ingredients list on the details page',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: 'Section title above the instructions list on the details page',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc:
          'Fallback error message, used for any error code with no message of its own',
      args: [],
    );
  }

  /// `No internet connection. Check your network and try again`
  String get noInternetConnectionError {
    return Intl.message(
      'No internet connection. Check your network and try again',
      name: 'noInternetConnectionError',
      desc: 'Error message shown when the device has no network connection',
      args: [],
    );
  }

  /// `The request took too long. Please try again`
  String get timeoutError {
    return Intl.message(
      'The request took too long. Please try again',
      name: 'timeoutError',
      desc: 'Error message shown when a request times out',
      args: [],
    );
  }

  /// `We could not find what you were looking for`
  String get notFoundError {
    return Intl.message(
      'We could not find what you were looking for',
      name: 'notFoundError',
      desc: 'Error message for HTTP 404',
      args: [],
    );
  }

  /// `The server ran into a problem. Please try again later`
  String get serverError {
    return Intl.message(
      'The server ran into a problem. Please try again later',
      name: 'serverError',
      desc: 'Error message for a failing response from the server',
      args: [],
    );
  }

  /// `We could not read the response from the server`
  String get parsingError {
    return Intl.message(
      'We could not read the response from the server',
      name: 'parsingError',
      desc:
          'Error message shown when the response body is not in the shape the app expects',
      args: [],
    );
  }

  /// `We could not read the data saved on your device`
  String get cacheError {
    return Intl.message(
      'We could not read the data saved on your device',
      name: 'cacheError',
      desc:
          'Error message shown when reading from or writing to the local database fails, whichever table it was',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: 'Button that runs the failed request again',
      args: [],
    );
  }

  /// `Page not found`
  String get routeNotFoundTitle {
    return Intl.message(
      'Page not found',
      name: 'routeNotFoundTitle',
      desc: 'App bar title of the fallback screen shown for an unknown route',
      args: [],
    );
  }

  /// `No screen is registered for "{routeName}".`
  String routeNotFoundMessage(String routeName) {
    return Intl.message(
      'No screen is registered for "$routeName".',
      name: 'routeNotFoundMessage',
      desc:
          'Body of the fallback screen, naming the route that could not be resolved',
      args: [routeName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
