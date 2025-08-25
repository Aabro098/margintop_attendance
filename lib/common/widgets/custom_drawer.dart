// ignore_for_file: deprecated_member_use
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/common/widgets/animation_slide.dart';
import 'package:margintop_attendance/common/widgets/drawer_items.dart';
import 'package:margintop_attendance/screens/Profile/app_settings.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';
import 'package:provider/provider.dart';
import 'package:margintop_attendance/common/reusables/bottom_navbar.dart';
import 'package:margintop_attendance/utils/constants/image_strings.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/providers/drawer_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final drawerProvider = Provider.of<DrawerProvider>(context);
    final bool isDarkMode = DeviceUtility.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.sm),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(AppSizes.xl),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Company Logo at Top
            Padding(
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 24.0,
                    ),
                    child: Image.asset(
                      isDarkMode ? AppLogos.markDark : AppLogos.markWhite,
                      height: 152,
                      width: 136,
                    ),
                  ),
                  AutoSizeText(
                    "MarginTop Solutions",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),

            // Home
            DrawerItems(
              drawerProvider: drawerProvider,
              theme: theme,
              label: 'Attendance',
              icon: Iconsax.home,
              onTap: () {
                drawerProvider.setSelectedItem('Attendance');
                Navigator.pushReplacement(
                  context,
                  SlidePageRoute(
                    page: const BottomNavBar(),
                  ),
                );
              },
            ),

            // Profile
            DrawerItems(
              drawerProvider: drawerProvider,
              theme: theme,
              label: 'Profile',
              icon: Iconsax.user,
              onTap: () {
                drawerProvider.setSelectedItem('Profile');
                Navigator.pushReplacement(
                  context,
                  SlidePageRoute(
                    page: const AppSettings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
