// ignore_for_file: use_build_context_synchronously

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Blog/main_blog.dart';
import 'package:margintop_solutions/screens/Blog/your_blog.dart';
import 'package:margintop_solutions/screens/Homepage/calendar.dart';
import 'package:margintop_solutions/screens/Homepage/homepage.dart';
import 'package:margintop_solutions/screens/Profile/app_settings.dart';
import 'package:margintop_solutions/utils/providers/index_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.title});

  final String title;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> screens = [
    const HomePage(), // index 0
    const AppCalendar(), // index 1
    const AppSettings(), // index 2
  ];

  final List<Widget> blogs = [
    const MainBlog(), // index 0
    const YourBlog(), // index 1
  ];

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final indexProvider = context.read<IndexProvider>();
      indexProvider.setIndex(0);
    });
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

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            widget.title == "Home"
                ? screens[selectedIndex]
                : blogs[selectedIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 300),
                color: context.colorScheme.primary,
                height: 56,
                index: selectedIndex,
                items: widget.title == "Home"
                    ? <Widget>[
                        _buildNavItem(
                          icon: Iconsax.home,
                          isSelected: selectedIndex == 0,
                        ),
                        _buildNavItem(
                          icon: Iconsax.calendar,
                          isSelected: selectedIndex == 1,
                        ),
                        _buildNavItem(
                          icon: Iconsax.user,
                          isSelected: selectedIndex == 2,
                        ),
                      ]
                    : <Widget>[
                        _buildNavItem(
                          icon: Iconsax.activity,
                          isSelected: selectedIndex == 0,
                        ),
                        _buildNavItem(
                          icon: Iconsax.status,
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

  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
  }) {
    return Icon(
      icon,
      size: isSelected ? 28 : 24,
      color: Colors.white,
    );
  }
}
