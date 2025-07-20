import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/app.dart';
import 'package:ordertracking_flutter/utils/providers/localization_provider.dart';
import 'package:ordertracking_flutter/utils/providers/theme.provider.dart';
import 'package:ordertracking_flutter/utils/helpers/notification_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeProvider themeProvider = ThemeProvider();
  LocalizationProvider languageProvider = LocalizationProvider();

  // Notification Service initialization
  NotificationService().initiNotification();

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
