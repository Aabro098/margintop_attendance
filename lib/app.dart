import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/common/widgets/custom_drawer.dart';
import 'package:flutter_boilerplate_mts/common/widgets/language_selector.dart';
import 'package:flutter_boilerplate_mts/extensions/context_extensions.dart';
import 'package:flutter_boilerplate_mts/localization/app_localization.dart';
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
      await Provider.of<LocalizationProvider>(
        contextToUse,
        listen: false,
      ).loadSavedLocale();
      await Provider.of<ThemeProvider>(contextToUse, listen: false).loadTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    final themeProvider = context.read<ThemeProvider>();
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
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
class MyHomePage extends StatefulWidget {
  ///
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.tr('title')),
        actions: const [LanguageSelector()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.tr('welcomeMessage')),
              const SizedBox(height: AppSizes.md),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 12,
                spacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () => showSuccessSnackbar('Success Message'),
                    child: const Text('Success SnackBar'),
                  ),
                  ElevatedButton(
                    onPressed: () => showErrorSnackbar('Error Message'),
                    child: const Text('Error SnackBar'),
                  ),
                  ElevatedButton(
                    onPressed: () => showInfoSnackbar('Info Message'),
                    child: const Text('Info SnackBar'),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              ElevatedButton(
                onPressed: () {
                  NotificationService().showNotification(
                    title: 'example_notification',
                    body: 'notification_body',
                  );
                },
                child: const Text('Show Notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
