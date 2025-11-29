import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  snackBar(String message, {SnackBarStatus status = SnackBarStatus.success}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: status.getTextColor())),
        backgroundColor: status.getBackgroundColor(),
      ),
    );
  }
}

enum SnackBarStatus {
  success,
  error,
  info;

  Color getBackgroundColor() {
    switch (this) {
      case SnackBarStatus.success:
        return Colors.green;
      case SnackBarStatus.error:
        return Colors.red;
      case SnackBarStatus.info:
        return Colors.blueAccent;
    }
  }

  Color getTextColor() {
    switch (this) {
      case SnackBarStatus.success:
        return Colors.white;
      case SnackBarStatus.error:
        return Colors.white;
      case SnackBarStatus.info:
        return Colors.white;
    }
  }
}
