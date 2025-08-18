import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';

class AppDrawerWrapper extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  final AdvancedDrawerController controller;

  const AppDrawerWrapper({
    super.key,
    required this.child,
    required this.drawer,
    required this.controller,
  });

  @override
  State<AppDrawerWrapper> createState() => _AppDrawerWrapperState();
}

class _AppDrawerWrapperState extends State<AppDrawerWrapper> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = DeviceUtility.isDarkMode(context);

    return AdvancedDrawer(
      controller: widget.controller,
      openRatio: 0.7,
      openScale: 0.8,
      animationCurve: Curves.easeInOut,
      backdrop: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              isDarkMode ? Colors.white10 : Colors.grey.shade300
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      drawer: widget.drawer,
      child: widget.child,
    );
  }
}
