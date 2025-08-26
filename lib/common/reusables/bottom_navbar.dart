// ignore_for_file: use_build_context_synchronously

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/common/reusables/app_drawer_wrapper.dart';
import 'package:margintop_attendance/common/reusables/menu_icon.dart';
import 'package:margintop_attendance/common/widgets/custom_drawer.dart';
import 'package:margintop_attendance/screens/Homepage/calendar.dart';
import 'package:margintop_attendance/screens/Homepage/homepage.dart';
import 'package:margintop_attendance/services/user_services.dart';
import 'package:margintop_attendance/utils/helpers/helper_functions.dart';
import 'package:margintop_attendance/utils/providers/index_provider.dart';
import 'package:margintop_attendance/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
  }) {
    return Icon(
      icon,
      size: isSelected ? 28 : 24,
      color: Colors.white,
    );
  }

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> screens = [
    const HomePage(), // index 0
    const AppCalendar(), // index 1
  ];

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<UserProvider>();
    if (provider.name == "--") {
      _getUserDetails();
    }
  }

  Future<void> _getUserDetails() async {
    final provider = context.read<UserProvider>();
    try {
      final response = await UserServices().userDetails();
      if (response != null) {
        if (response['message'] == "Success" && response["status"] == 1) {
          provider.setUserDetails(
              name: response['data']['name'], email: response['data']['email']);
        } else {
          showErrorSnackbar(response['message'], context: context);
        }
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<IndexProvider>(context);
    final selectedIndex = navProvider.selectedIndex;
    final theme = Theme.of(context);
    return AppDrawerWrapper(
      drawer: const CustomDrawer(),
      controller: _advancedDrawerController,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            screens[selectedIndex],
            MenuIcon(
              drawerController: _advancedDrawerController,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 300),
                color: theme.colorScheme.primary,
                height: 65,
                index: selectedIndex,
                items: <Widget>[
                  BottomNavBar._buildNavItem(
                    icon: Iconsax.home,
                    isSelected: selectedIndex == 0,
                  ),
                  BottomNavBar._buildNavItem(
                    icon: Iconsax.calendar,
                    isSelected: selectedIndex == 1,
                  ),
                ],
                onTap: (index) {
                  navProvider.setIndex(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
