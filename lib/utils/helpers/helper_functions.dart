import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/helpers/app_globals.dart';

void showErrorSnackbar(
  String message, {
  required BuildContext context,
}) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red, // overrides theme
      duration: const Duration(seconds: 2),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.close_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                message,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(AppSizes.md),
    ),
  );
}

void showSuccessSnackbar(
  String message, {
  required BuildContext context,
}) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green, // overrides theme
      duration: const Duration(seconds: 2),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.tick_circle1, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                message,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(AppSizes.md),
    ),
  );
}

void showInfoSnackbar(
  String message, {
  required BuildContext context,
}) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue, // overrides theme
      duration: const Duration(seconds: 2),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.info_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                message,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(AppSizes.md),
    ),
  );
}

// This returns the time in the format like 7:48 AM for the time 2025-08-19T15:38:31.000000Z
String formatToTime(String isoTime) {
  // Parse the UTC string
  final dateTime = DateTime.parse(isoTime).toLocal(); // convert to local time

  // Format to desired style (7:48 AM)
  final formatter = DateFormat.jm(); // jm = hour:minute AM/PM
  return formatter.format(dateTime);
}
