import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/common/language_provider.dart';
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
    final languageProvider =
        Provider.of<LanguageProvider>(context); // Get the language provider
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              languageProvider
                  .setLanguage(value); // Change the language on selection
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
            icon: Icon(Icons.language), // Language icon
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
              Text(AppLocalizations.of(context)?.translate('select_language') ??
                  ''),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(AppLocalizations.of(context)
                  //         ?.translate('select_language') ??
                  //     ''),

                  // // Display language selection text
                  // DropdownButton<String>(
                  //   value: languageProvider
                  //       .languageCode, // Current language selection
                  //   onChanged: (String? newValue) {
                  //     if (newValue != null) {
                  //       languageProvider
                  //           .setLanguage(newValue); // Change the language
                  //     }
                  //   },
                  //   items: <String>['en', 'ne'] // Corrected list of languages
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(
                  //           value.toUpperCase()), // Show language in uppercase
                  //     );
                  //   }).toList(),
                  // ),
                ],
              ),
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
