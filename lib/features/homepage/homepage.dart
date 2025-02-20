import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/common/localization_provider.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:ordertracking_flutter/localization/app_localization.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.themeProvider,
  });

  final ThemeProvider themeProvider;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider =
        Provider.of<LocalizationProvider>(context); // Get the language provider
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language), // Language icon
            onSelected: (String value) {
              // Change the language on selection
              if (value == 'en') {
                localizationProvider.switchLocale(
                    const Locale('en', 'US')); // Switch to English
              } else if (value == 'ne') {
                localizationProvider
                    .switchLocale(const Locale('ne', 'NP')); // Switch to Nepali
              }
            },
            itemBuilder: (BuildContext context) {
              return <String>['en', 'ne'].map((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child:
                      Text(value.toUpperCase()), // Show language in uppercase
                );
              }).toList();
            },
          ),
        ],
        centerTitle: true,
        title: Text(AppLocalizations.of(context)?.translate('title') ??
            ''), // Set the app title
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Theme:'),

                  // * Dropdopwn Menu for changing the Theme of the app.
                  DropdownButton<ThemeMode>(
                    value: widget.themeProvider
                        .themeMode, //The default value to be seen in the dropdopwn menu
                    onChanged: (ThemeMode? newMode) {
                      if (newMode != null) {
                        widget.themeProvider.setTheme(
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
            ],
          ),
        ),
      ),
    );
  }
}
