import 'package:flutter/material.dart';
import 'package:margintop_attendance/common/widgets/custom_drawer.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/helpers/notification_service.dart';
import 'package:margintop_attendance/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  ///
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      drawer: const CustomDrawer(
        userName: "Jane Doe",
        userEmail: "jane.doe@example.com",
        profileImageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('title'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('welcomeMessage'),
              const SizedBox(height: AppSizes.md),
              const SizedBox(height: AppSizes.md),
              ElevatedButton(
                onPressed: () {
                  NotificationService().showNotification(
                    title: 'example_notification',
                    body: 'notification_body',
                  );
                },
                child: const Text('Show Notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
