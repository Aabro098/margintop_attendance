import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/helpers/app_globals.dart';

void showErrorSnackbar(
  String message, {
  required BuildContext context,
}) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red, // overrides theme
      content: AutoSizeText(message, textAlign: TextAlign.center),
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
      content: AutoSizeText(message, textAlign: TextAlign.center),
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
      content: AutoSizeText(message, textAlign: TextAlign.center),
    ),
  );
}
