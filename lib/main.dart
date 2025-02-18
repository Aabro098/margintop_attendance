import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

/*
TODO: Theme switching integration (provider and sharedPreferences)
TODO: Implement Custom Made Classes for fonts, icons and images in app
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lighttheme,
      darkTheme: AppTheme.darkTheme,
      title: 'Order Tracker',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Order Tracker',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: const Center(
          child: Text('Body.'),
        ),
      ),
    );
  }
}
