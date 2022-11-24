import 'package:flutter/material.dart';

class NotifUtils {
  static Future showSnackBar(BuildContext c,
      {String? message, Color? color}) async {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(message ?? ""),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
