import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool showArrow;

  const SettingItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.showArrow = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(
          vertical: AppSizes.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
            if (showArrow)
              const Icon(
                Icons.chevron_right,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
