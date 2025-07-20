import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/utils/providers/theme.provider.dart';
import 'package:ordertracking_flutter/utils/providers/localization_provider.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({
    super.key,
    required this.themeProvider,
    required this.localizationProvider,
  });
  final ThemeProvider themeProvider;
  final LocalizationProvider localizationProvider;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            enabled: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Theme:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<ThemeMode>(
                  value: themeProvider.themeMode,
                  onChanged: (ThemeMode? newMode) {
                    if (newMode != null) {
                      themeProvider.setTheme(newMode);
                      Navigator.pop(context);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                        value: ThemeMode.system, child: Text("System")),
                    DropdownMenuItem(
                        value: ThemeMode.light, child: Text("Light")),
                    DropdownMenuItem(
                        value: ThemeMode.dark, child: Text("Dark")),
                  ],
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            enabled: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Language:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: localizationProvider.locale.languageCode,
                  onChanged: (String? value) {
                    if (value != null) {
                      if (value == 'en') {
                        localizationProvider
                            .switchLocale(const Locale('en', 'US'));
                      } else if (value == 'ne') {
                        localizationProvider
                            .switchLocale(const Locale('ne', 'NP'));
                      }
                      Navigator.pop(context);
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text("🇺🇸 English")),
                    DropdownMenuItem(value: 'ne', child: Text("🇳🇵 Nepali")),
                  ],
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
