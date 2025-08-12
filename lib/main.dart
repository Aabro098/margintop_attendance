import 'package:flutter/material.dart';
import 'package:margintop_attendance/app.dart';
import 'package:margintop_attendance/utils/helpers/notification_service.dart';
import 'package:margintop_attendance/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initiNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const App(),
    ),
  );
}
