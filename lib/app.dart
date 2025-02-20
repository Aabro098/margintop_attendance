import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/common/language_provider.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:ordertracking_flutter/features/homepage/homepage.dart';
import 'package:ordertracking_flutter/localization/app_localization.dart';
import 'package:ordertracking_flutter/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/*
TODO: Implement Custom Made Classes for fonts, icons and images in app
*/

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Default language

  Widget build(BuildContext context) {
    @override
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate, // For Material widgets
            GlobalWidgetsLocalizations.delegate, // For general widgets
            GlobalCupertinoLocalizations.delegate, // For iOS widgets
            AppLocalizationsDelegate(), // Custom localizations delegate
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.firstWhere(
              (supportedLocale) =>
                  supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode,
              orElse: () => supportedLocales.first,
            );
          },
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          title: 'Order Tracker',
          home: HomePage(themeProvider: themeProvider),
        );
      },
    );
  }
}
