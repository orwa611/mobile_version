import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_version/widgets/primary_button.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRefresh;
  const ErrorWidget({super.key, required this.message, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(message),
          onRefresh != null
              ? PrimaryButton(onPressed: onRefresh, title: 'refresh')
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
