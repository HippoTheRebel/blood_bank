import 'package:blood_transfusion_register/utils/session.dart';
import 'package:flutter/material.dart';

Future<void> showCommonSnackBar({
  required String message,
  Color? bgColor,
}) async {
  ScaffoldMessenger.of(
    navigatorKey.currentContext!,
  ).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: bgColor ?? Colors.blueAccent,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
