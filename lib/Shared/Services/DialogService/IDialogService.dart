import 'package:flutter/material.dart';

abstract class IDialogService {
  Future<void> show({
    required String text,
    String? confirmText,
    String? cancelText,
    void Function()? onCancel,
    void Function()? onConfirm,
    bool showCancelButton = false,
    bool showConfirmButton = true,
    bool showButtons = true,
    Color? confirmColor,
    Color? cancelColor,
    Color textConfirmColor = Colors.white,
    Color? textCancelColor,
    double? height,
    Widget? widget,
    bool confirmLoading = false,
    bool cancelLoading = false,
  });

  Future<void> showLoading({bool barrierDismissible = false});
}
