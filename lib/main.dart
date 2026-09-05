import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';
import 'package:flutter_clean_architecture_steps/router/app_router.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/style/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const RecipesApp());
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.strings.appTitle,
      theme: AppTheme.light,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: AppRoutes.recipeList,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
