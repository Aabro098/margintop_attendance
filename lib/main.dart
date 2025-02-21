import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/app.dart';
import 'package:ordertracking_flutter/common/localization_provider.dart';
import 'package:ordertracking_flutter/common/theme.provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeProvider themeProvider = ThemeProvider();
  LocalizationProvider languageProvider = LocalizationProvider();
  await themeProvider.loadTheme();
  runApp(
    // *Using MutliProvider for further addition of providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => languageProvider,
        )
      ],
      child: const App(),
    ),
  );
}
