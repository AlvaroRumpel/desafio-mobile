import 'package:flutter/material.dart';

import '../../../components/components.dart';

mixin MessageMixin {
  void showSuccess(BuildContext context, String message, {int seconds = 5}) {
    _showSnackbar(
      context,
      message,
      type: _MessageType.success,
      seconds: seconds,
    );
  }

  void showError(BuildContext context, String message, {int seconds = 5}) {
    _showSnackbar(
      context,
      message,
      type: _MessageType.error,
      seconds: seconds,
    );
  }

  void showInfo(BuildContext context, String message, {int seconds = 5}) {
    _showSnackbar(
      context,
      message,
      type: _MessageType.info,
      seconds: seconds,
    );
  }

  void _showSnackbar(
    BuildContext context,
    String message, {
    int seconds = 5,
    required _MessageType type,
  }) {
    final backgroundColor = switch (type) {
      _MessageType.success => Colors.green,
      _MessageType.info => Colors.yellow,
      _MessageType.error => Colors.red,
    };

    final fontColor = switch (type) {
      _MessageType.success => Colors.white,
      _MessageType.info => Colors.white,
      _MessageType.error => Colors.white,
    };

    final icon = switch (type) {
      _MessageType.success => Icons.check_circle_outline,
      _MessageType.info => Icons.info_outline_rounded,
      _MessageType.error => Icons.warning_amber_rounded,
    };

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: fontColor),
          const CustomSpace.sp2(),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: fontColor),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: seconds),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

enum _MessageType {
  success,
  info,
  error,
}
