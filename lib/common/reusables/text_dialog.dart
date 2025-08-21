import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/common/widgets/text_field.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';

class StylishInputDialog {
  final BuildContext context;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onSubmit;

  StylishInputDialog({
    required this.onSubmit,
    required this.context,
    required this.title,
    required this.hintText,
    required this.controller,
  });

  /// Shows the dialog and returns the user input as a string (or null if canceled)
  Future<String?> show() async {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final theme = Theme.of(context);
        final isDarkMode = DeviceUtility.isDarkMode(context);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.lg),
          ),
          elevation: 6,
          backgroundColor: isDarkMode ? Colors.black : Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min, // important! shrink vertically
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // stretch to fit width
              children: [
                AutoSizeText(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSizes.formHeight),
                TextFieldData(
                  controller: controller,
                  hintText: hintText,
                  maxLines: 4,
                ),
                const SizedBox(height: AppSizes.formHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(null),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          onSubmit();
                          Navigator.of(context).pop(controller.text);
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
