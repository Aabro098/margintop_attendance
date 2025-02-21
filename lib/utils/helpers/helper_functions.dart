import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class HelperFunctions {
  static void showErrorSnackbar(String message) {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 600),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 18)),
      backgroundColor: const Color.fromARGB(255, 158, 39, 30),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void showSuccessSnackbar(String message, {int time = 1000}) {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();

    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
      duration: Duration(milliseconds: time),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void showInfoSnackbar(String message, {int time = 1000}) {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();

    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF31D3C8),
      content: Text(message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
      duration: Duration(milliseconds: time),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
