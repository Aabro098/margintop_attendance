import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/common/widgets/custom_drawer.dart';
import 'package:flutter_boilerplate_mts/common/widgets/language_selector.dart';
import 'package:flutter_boilerplate_mts/extensions/context_extensions.dart';
import 'package:flutter_boilerplate_mts/localization/app_localization.dart';
import 'package:flutter_boilerplate_mts/screens/homepage/homepage.dart';
import 'package:flutter_boilerplate_mts/utils/constants/sizes.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/app_globals.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/helper_functions.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/localization_manager.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/notification_service.dart';
import 'package:flutter_boilerplate_mts/utils/providers/localization_provider.dart';
import 'package:flutter_boilerplate_mts/utils/providers/theme.provider.dart';
import 'package:flutter_boilerplate_mts/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final contextToUse = scaffoldMessengerKey.currentContext ?? context;
      Future.wait([
        Provider.of<LocalizationProvider>(
          contextToUse,
          listen: false,
        ).loadSavedLocale(),
        Provider.of<ThemeProvider>(contextToUse, listen: false).loadTheme(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocalizationProvider, ThemeProvider>(
      builder: (context, localizationProvider, themeProvider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
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
          title: 'Boilerplate',
          home: const MyHomePage(),
        );
      },
    );
  }
}

///
