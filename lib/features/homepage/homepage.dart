import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/common/custom_button.dart';
import 'package:ordertracking_flutter/common/localization_provider.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:ordertracking_flutter/utils/helpers/toast_helper.dart';
import 'package:ordertracking_flutter/localization/app_localization.dart';
import 'package:ordertracking_flutter/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return ScaffoldMessenger(
      key: scaffoldMessengerKey, // ✅ Correctly using scaffoldMessengerKey
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.language),
              onSelected: (String value) {
                if (value == 'en') {
                  localizationProvider.switchLocale(const Locale('en', 'US'));
                } else if (value == 'ne') {
                  localizationProvider.switchLocale(const Locale('ne', 'NP'));
                }
              },
              itemBuilder: (BuildContext context) {
                return <String>['en', 'ne'].map((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList();
              },
            ),
          ],
          centerTitle: true,
          title: Text(AppLocalizations.of(context)?.translate('title') ?? ''),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              children: [
                CustomButton(
                  text: "Show Success Message",
                  onPressed: () {
                    HelperFunctions.showSuccessSnackbar("Operation Successful",
                        time: 1000);
                    showToast("Operation Successful");
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Show Error Message",
                  onPressed: () {
                    HelperFunctions.showErrorSnackbar("Something went wrong!");
                    showToast("Error Occurred!");
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Show Info Message",
                  onPressed: () {
                    HelperFunctions.showInfoSnackbar("This is an info message.",
                        time: 1000);
                    showToast("Info: Check details.");
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Theme:'),
                    DropdownButton<ThemeMode>(
                      value: widget.themeProvider.themeMode,
                      onChanged: (ThemeMode? newMode) {
                        if (newMode != null) {
                          widget.themeProvider.setTheme(newMode);
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text("System Theme")),
                        DropdownMenuItem(
                            value: ThemeMode.light, child: Text("Light Theme")),
                        DropdownMenuItem(
                            value: ThemeMode.dark, child: Text("Dark Theme")),
                      ],
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
