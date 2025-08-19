// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/common/widgets/animation_slide.dart';
import 'package:margintop_attendance/common/widgets/drawer_items.dart';
import 'package:margintop_attendance/screens/Profile/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:margintop_attendance/common/reusables/bottom_navbar.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
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
            Container(
              width: 120.0,
              height: 120.0,
              margin: const EdgeInsets.only(top: 36.0, bottom: 36.0),
              child: SvgPicture.asset(
                AppLogos.markWhite,
                color: AppColorsLight.logoColor,
                height: 82,
                width: 82,
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
                Navigator.push(
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
                Navigator.push(
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
