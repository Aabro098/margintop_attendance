import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:ordertracking_flutter/features/homepage/homepage.dart';
import 'package:ordertracking_flutter/localization/app_localization.dart';
import 'package:ordertracking_flutter/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/*
TODO: Implement Custom Made Classes for fonts, icons and images in app
TODO: Implement Localization using i18next
*/

class App extends StatefulWidget {
  const App({super.key});

  //! Creating list of locales for the current languages
  final List<Locale> locales = const [
    Locale('en', 'US'),
    Locale('np', 'NP'),
    // TODO: add multi plural language(s)
  ];
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale = Locale('en', 'US'); // Default language

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Widget build(BuildContext context) {
    @override
    //* Selects the first language(English) as initial language.

        final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationDelegate(supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ne', 'NP'),
        ]),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      title: 'Order Tracker',
      home: HomePage(
          themeProvider: themeProvider, onLanguageChanged: _changeLanguage),
    );
  }
}
