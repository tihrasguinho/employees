import 'package:flutter/material.dart';

class SnackBars {
  const SnackBars._();

  static final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static Widget builder(BuildContext context, Widget? child) {
    return Scaffold(key: _key, body: child);
  }

  static void show(
    String message, {
    Duration duration = const Duration(seconds: 5),
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onDismiss,
    VoidCallback? onAction,
    SnackBarAction? action,
    bool showCloseIcon = true,
    double width = 512.0,
  }) {
    final context = _key.currentContext;

    if (context == null) return;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        action: action,
        dismissDirection: DismissDirection.down,
        showCloseIcon: showCloseIcon,
        behavior: SnackBarBehavior.floating,
        closeIconColor: textColor,
        width: width,
      ),
    );
  }

  static void remove() {
    final context = _key.currentContext;

    if (context == null) return;

    return ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  static void success(
    String message, {
    Duration duration = const Duration(seconds: 5),

    VoidCallback? onDismiss,
    VoidCallback? onAction,
    SnackBarAction? action,
    bool showCloseIcon = true,
  }) {
    return show(
      message,
      duration: duration,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      onDismiss: onDismiss,
      onAction: onAction,
      action: action,
      showCloseIcon: showCloseIcon,
    );
  }

  static void error(
    String message, {
    Duration duration = const Duration(seconds: 5),
    VoidCallback? onDismiss,
    VoidCallback? onAction,
    SnackBarAction? action,
    bool showCloseIcon = true,
  }) {
    return show(
      message,
      duration: duration,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      onDismiss: onDismiss,
      onAction: onAction,
      action: action,
      showCloseIcon: showCloseIcon,
    );
  }
}
