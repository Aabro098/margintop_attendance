import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/common/localization_provider.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:ordertracking_flutter/features/homepage/homepage.dart';
import 'package:ordertracking_flutter/localization/app_localization.dart';
import 'package:ordertracking_flutter/utils/helpers/localization_manager.dart';
import 'package:ordertracking_flutter/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/*
TODO: Implement Custom Made Classes for fonts, icons and images in app
*/

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Default language

  @override
  Widget build(BuildContext context) {
    @override
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return MaterialApp(
          locale: localizationProvider.locale,
          scaffoldMessengerKey: scaffoldMessengerKey,
          supportedLocales: LocalizationManager.supportedLocaleList,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
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
