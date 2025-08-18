import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:margintop_attendance/app.dart';
import 'package:margintop_attendance/utils/helpers/notification_service.dart';
import 'package:margintop_attendance/utils/providers/drawer_provider.dart';
import 'package:margintop_attendance/utils/providers/index_provider.dart';
import 'package:margintop_attendance/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initiNotification();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IndexProvider()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
      ],
      child: const App(),
    ),
  );
}
