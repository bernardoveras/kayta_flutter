import 'package:flutter/material.dart';

abstract class INotificationService {
  Future<void> show({
    String? title,
    String? message,
    Widget? titleWidget,
    Widget? messageWidget,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 5),
    Widget? icon,
    void Function()? onTap,
  });
}
