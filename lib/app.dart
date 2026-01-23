import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_solutions/common/reusables/bottom_navbar.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Auth/login.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/local_storage/user_prefs.dart';
import 'package:margintop_solutions/utils/providers/theme.provider.dart';
import 'package:margintop_solutions/utils/theme/theme.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    await context.read<ThemeProvider>().loadTheme();
    await _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final token = await UserPrefs.getToken();

    if (mounted) {
      setState(() {
        _isAuthenticated = token.isNotEmpty;
        // _isAuthenticated = false;
        _isLoading = false;
      });
    }
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
          title: 'Margintop Solutions',
          home: _isLoading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: context.colorScheme.primary,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : _isAuthenticated
                  ? const BottomNavBar()
                  : const LoginScreen(),
        );
      },
    );
  }
}
