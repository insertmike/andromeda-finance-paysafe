import 'package:flutter/material.dart';

class CustomSnackbar {
  CustomSnackbar._();
  static buildErrorSnackBar(BuildContext context, String message) {
    return SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.red),
    ));
  }

  static buildSuccessSnackBar(BuildContext context, String message) {
    return SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.green),
    ));
  }
}
