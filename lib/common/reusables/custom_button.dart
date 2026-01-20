import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.isLoading,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            label,
            style: context.textTheme.titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          if (isLoading) ...[
            const SizedBox(width: AppSizes.md),
            const Center(
              child: SizedBox(
                width: AppSizes.md,
                height: AppSizes.md,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
