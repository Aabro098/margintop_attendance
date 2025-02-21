import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/features/homepage/homepage.dart';

class HelperFunctions {
  HelperFunctions._();

  // TODO: Modularize styling of the snackbars.
  // TODO: Add custom snackbar packages if necessary (awesome_snackbar_content,top_snackbar_flutter,delightful_toast)
  void showErrorSnackbar(String message) {
    // remove the previous snackbar
    ScaffoldMessenger.of(scaffoldKey.currentContext!).hideCurrentSnackBar();

    // store text and create snackbar variable
    final text = Text(message,
        style: const TextStyle(color: Colors.white, fontSize: 18));

    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 600),
      content: text,
      backgroundColor: const Color.fromARGB(255, 158, 39, 30),
    );

    // show snackbar
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackBar);
  }

  void showSuccessSnackbar(String message, {int time = 0}) {
    // remove snackbar if any
    ScaffoldMessenger.of(scaffoldKey.currentContext!).removeCurrentSnackBar();

    // store text and create snackbar variable
    final text = Text(message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));

    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: text,
      duration: Duration(milliseconds: time),
    );

    // show snackbar
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackBar);
  }

  void showInfoSnackbar(String message, {int time = 0}) {
    // remove snackbar if any
    ScaffoldMessenger.of(scaffoldKey.currentContext!).removeCurrentSnackBar();

    // store text and create snackbar variable
    final text = Text(message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));

    final snackBar = SnackBar(
        backgroundColor: const Color(0xFF31D3C8),
        content: text,
        duration: Duration(milliseconds: time));

    // show snackbar
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackBar);
  }
}
