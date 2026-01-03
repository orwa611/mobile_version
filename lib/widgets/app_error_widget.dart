import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_version/widgets/primary_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRefresh;
  const AppErrorWidget({super.key, required this.message, this.onRefresh});

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
