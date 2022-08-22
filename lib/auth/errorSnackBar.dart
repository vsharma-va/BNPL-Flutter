import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
    var upTime = const Duration(milliseconds: 4000),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: upTime,
    ));
  }

  void showErrorSnackBar(
      {required String message, upTime = const Duration(milliseconds: 4000)}) {
    showSnackBar(message: message, backgroundColor: Colors.red, upTime: upTime);
  }
}
