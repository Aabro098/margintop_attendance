import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:i18next/i18next.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<I18Next> {
  final List<Locale> supportedLocales;

  AppLocalizationDelegate({required this.supportedLocales});

  @override
  bool isSupported(Locale locale) {
    return supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode);
  }

  @override
  Future<I18Next> load(Locale locale) async {
    // Determine correct JSON file based on locale
    String localeString = locale.languageCode == "ne" ? "np_NP" : "en_US";
    String jsonString =
        await rootBundle.loadString("assets/localization/$localeString.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Create I18Next instance
    return I18Next(
      locale,
      ResourceStore(
        data: {locale: jsonMap},
      ),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<I18Next> old) => false;
}
