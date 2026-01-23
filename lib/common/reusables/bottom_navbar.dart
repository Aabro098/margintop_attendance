import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/models/nav_item_model.dart';
import 'package:margintop_solutions/screens/Homepage/calendar.dart';
import 'package:margintop_solutions/screens/Homepage/homepage.dart';
import 'package:margintop_solutions/screens/Profile/app_settings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
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

  final List<NavItemModel> navItems = [
    NavItemModel(
      icon: Iconsax.home,
      content: const HomePage(),
    ),
    NavItemModel(
      icon: Iconsax.calendar,
      content: const AppCalendar(),
    ),
    NavItemModel(
      icon: Iconsax.user,
      content: const AppSettings(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<IndexProvider>();
    final selectedIndex = navProvider.selectedIndex;

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
            child: RepaintBoundary(
              child: GNav(
                gap: 8,
                padding: const EdgeInsets.all(12),
                selectedIndex: selectedIndex,
                onTabChange: (index) async {
                  await navProvider.setIndex(index);
                },
                tabs: List.generate(
                  navItems.length,
                  (index) {
                    final item = navItems[index];
                    final isSelected = selectedIndex == index;
                    return GButton(
                      icon: item.icon,
                      leading: Column(
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.white,
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.xs),
                              child: Container(
                                width: 32,
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
