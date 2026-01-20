import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:margintop_solutions/extensions/extensions.dart';

class MenuIcon extends StatefulWidget {
  final AdvancedDrawerController drawerController;

  const MenuIcon({
    super.key,
    required this.drawerController,
  });

  @override
  State<MenuIcon> createState() => _MenuIconState();
}

class _MenuIconState extends State<MenuIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 12, 0),
      child: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: widget.drawerController,
              builder: (_, value, __) {
                return IconButton(
                  icon: Icon(
                    value.visible ? Icons.close : Iconsax.menu5,
                    color: context.colorScheme.primary,
                  ),
                  onPressed: () {
                    if (value.visible) {
                      widget.drawerController.hideDrawer();
                    } else {
                      widget.drawerController.showDrawer();
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
