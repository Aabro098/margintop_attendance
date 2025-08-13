import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String profileImageUrl;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = DeviceUtility.isDarkMode(context);

    return Drawer(
      child: Container(
        color: isDarkMode ? Colors.black87 : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.secondary,
                    theme.colorScheme.primary
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(profileImageUrl),
                    backgroundColor: theme.colorScheme.inversePrimary,
                  ),
                  const SizedBox(height: 12),
                  AutoSizeText(
                    userName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  AutoSizeText(
                    userEmail,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Drawer items
            _buildDrawerItem(Iconsax.home, "Home", theme),
            _buildDrawerItem(Iconsax.settings, "Settings", theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    ThemeData theme,
  ) {
    return Center(
      child: ListTile(
        leading: Icon(
          icon,
          color: theme.colorScheme.secondary,
        ),
        dense: true,
        title: Text(
          title,
          style: theme.textTheme.headlineSmall
              ?.copyWith(color: theme.colorScheme.secondary),
        ),
        onTap: () {
          // Handle drawer item tap if needed
        },
      ),
    );
  }
}
