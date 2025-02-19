import 'package:flutter/material.dart';
import 'package:i18next/i18next.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:ordertracking_flutter/utils/theme/theme.dart';
import 'package:provider/provider.dart';

/*
TODO: Implement Custom Made Classes for fonts, icons and images in app
TODO: Implement Localization using i18next
*/

class App extends StatefulWidget {
  const App({super.key});

  // !Creating list of locales for the current languages
  final List<Locale> locales = const [
    Locale('en', 'US'),
    Locale('nep', 'NP'),
    // TODO: add multi plural language(s)
  ];
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late Locale locale;

    @override
    void initState() {
      super.initState();
      locale = widget.locales.first;
    }

    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        I18NextLocalizationDelegate(
          locales: widget.locales,
          dataSource: AssetBundleLocalizationDataSource(
            // This is the path for the files declared in pubspec which should
            // contain all of your localizations
            bundlePath: 'lib/localization',
          ),
        ),
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      title: 'Order Tracker',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Order Tracker',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Theme:'),

                // * Dropdopwn Menu for changing the Theme of the app.
                DropdownButton<ThemeMode>(
                  value: themeProvider
                      .themeMode, //The default value to be seen in the dropdopwn menu
                  onChanged: (ThemeMode? newMode) {
                    if (newMode != null) {
                      themeProvider.setTheme(
                          newMode); // Calls provider function to set the theme and store preference
                    }
                  },
                  items: const [
                    // The "value" is passed to the onChanged function as parameter
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text("System Theme"),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text("Light Theme"),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text("Dark Theme"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
