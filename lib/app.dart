import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_attendance/common/reusables/bottom_navbar.dart';
import 'package:margintop_attendance/screens/Auth/login.dart';
import 'package:margintop_attendance/utils/helpers/app_globals.dart';
import 'package:margintop_attendance/utils/providers/theme.provider.dart';
import 'package:margintop_attendance/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final themeProvider = context.read<ThemeProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await themeProvider.loadTheme();
      _checkAuthentication();
    });
  }

  Future<void> _checkAuthentication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    setState(() {
      _isAuthenticated = (token != null && token.isNotEmpty);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          supportedLocales: const [
            Locale('en'),
          ],
          localizationsDelegates: const [
            FlutterQuillLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'Margintop Solutions Attendance',
          home: _isLoading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : (_isAuthenticated ? const BottomNavBar() : const LoginScreen()),
        );
      },
    );
  }
}
