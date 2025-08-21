import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/providers/drawer_provider.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({
    super.key,
    required this.drawerProvider,
    required this.theme,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final DrawerProvider drawerProvider;
  final ThemeData theme;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: Icon(widget.icon, color: Colors.white),
      title: Row(
        children: [
          AutoSizeText(
            widget.label,
            style: widget.theme.textTheme.titleMedium
                ?.copyWith(color: Colors.white),
          ),
          if (widget.drawerProvider.selectedItem == widget.label) ...[
            const SizedBox(width: AppSizes.lg),
            Container(
              width: AppSizes.sm,
              height: AppSizes.sm,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      tileColor: Colors.transparent,
      selected: false,
    );
  }
}
