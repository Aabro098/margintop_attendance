import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.lg),
          ),
          elevation: 6,
          backgroundColor: theme.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.formHeight),
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: hintText,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.lg),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(AppSizes.padding),
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(null),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        onSubmit();
                      },
                      child: const Text("Submit"),
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
