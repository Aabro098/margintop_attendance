import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';

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
            const Icon(Iconsax.tick_circle, color: Colors.white),
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

String formatToTime(String time) {
  DateTime dateTime;
  if (time == '') {
    return '';
  }
  if (time.contains("T")) {
    // ✅ Case 1: Full ISO datetime string
    dateTime = DateTime.parse(time).toLocal();
  } else {
    // ✅ Case 2: Plain time (HH:mm:ss), assume today’s date
    final now = DateTime.now();
    final parts = time.split(":");
    dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  // Format to desired style (e.g. 7:48 AM, 10:45 AM)
  final formatter = DateFormat.jm();
  return formatter.format(dateTime);
}
