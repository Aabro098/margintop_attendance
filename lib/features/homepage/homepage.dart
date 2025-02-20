import 'package:flutter/material.dart';
import 'package:i18next/i18next.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.themeProvider,
    required this.onLanguageChanged,
  });

  final ThemeProvider themeProvider;
  final Function(Locale) onLanguageChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18Next.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          i18n?.t('title') ?? "Fallback Title",
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            children: [
              // TODO: Fix the i18next t() method issue. (Not working as intended)
              Text(i18n?.t('helloMessage',
                      //// This named parameter is not working.
                      //// arguments: {'name': 'Tracker', 'world': 'Flutter'}
                      //* Replaced with variables.
                      variables: {'name': 'Tracker', 'world': 'Flutter'}) ??
                  "Fallback"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    widget.onLanguageChanged(const Locale('ne', 'NP')),
                child: const Text('Switch to Nepali'),
              ),
              ElevatedButton(
                onPressed: () =>
                    widget.onLanguageChanged(const Locale('en', 'US')),
                child: const Text('Switch to English'),
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
