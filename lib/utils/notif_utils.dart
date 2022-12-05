import 'package:flutter/material.dart';

class NotifUtils {
  static Future showSnackBar(BuildContext c,
      {String? message, Color? color, required bool isSuccess}) async {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(isSuccess ? Icons.check : Icons.cancel),
            Text(message ?? ""),
          ],
        ),
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
