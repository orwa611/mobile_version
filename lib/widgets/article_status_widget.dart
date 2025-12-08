import 'package:flutter/material.dart';

class ArticleStatusWidget extends StatelessWidget {
  final StatusBar status;
  const ArticleStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return status == StatusBar.unknown
        ? SizedBox.shrink()
        : Chip(
          label: Text(
            status.label,
            style: TextStyle(color: status.getTextColor()),
          ),
          backgroundColor: status.getBackgroundColor(),
        );
  }
}

enum StatusBar {
  approved,
  rejected,
  pending,
  unknown;

  String get label {
    switch (this) {
      case StatusBar.approved:
        return 'Approved';
      case StatusBar.rejected:
        return 'Rejected';
      case StatusBar.pending:
        return 'Pending';
      case StatusBar.unknown:
        return '';
    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case StatusBar.approved:
        return Colors.green;
      case StatusBar.rejected:
        return Colors.red;
      case StatusBar.pending:
        return const Color.fromARGB(255, 105, 106, 106);
      case StatusBar.unknown:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Color getTextColor() {
    switch (this) {
      case StatusBar.approved:
        return Colors.white;
      case StatusBar.rejected:
        return Colors.white;
      case StatusBar.pending:
        return Colors.white;
      case StatusBar.unknown:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
