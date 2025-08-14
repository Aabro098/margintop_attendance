import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/screens/Homepage/homepage.dart';
import 'package:margintop_attendance/screens/Profile/app_settings.dart';
import 'package:margintop_attendance/utils/providers/index_provider.dart';
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
    const Scaffold(), // index 1
    const AppSettings(), // index 2
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<IndexProvider>(context);
    final selectedIndex = navProvider.selectedIndex;
    final theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          screens[selectedIndex],
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
                BottomNavBar._buildNavItem(
                  icon: Icons.person_outline_rounded,
                  isSelected: selectedIndex == 2,
                ),
              ],
              onTap: (index) {
                navProvider.setIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
