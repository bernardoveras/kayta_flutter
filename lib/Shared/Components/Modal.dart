import 'package:flutter/material.dart';
import 'package:kayta_flutter/Shared/Theme/Colors.dart';
import '../Extensions/ScreenUtilExtension.dart';
import 'ScaleOnTap.dart';

class Modal extends StatelessWidget {
  final String text;
  final Widget? widget;
  final String cancelText;
  final String? confirmText;
  final Color textConfirmColor;
  final Color? textCancelColor;
  final Color? confirmColor;
  final Color? cancelColor;
  final bool showButtons;
  final bool showConfirmButton;
  final bool showCancelButton;
  final double? height;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final bool confirmLoading;
  final bool cancelLoading;
  const Modal({
    Key? key,
    required this.text,
    this.cancelText = 'Cancelar',
    this.confirmText,
    this.widget,
    this.showButtons = true,
    this.showConfirmButton = true,
    this.showCancelButton = true,
    this.textCancelColor,
    this.textConfirmColor = Colors.white,
    this.cancelColor,
    this.confirmColor,
    this.height,
    this.onConfirm,
    this.onCancel,
    this.confirmLoading = false,
    this.cancelLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200.height,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 10.height,
        bottom: MediaQuery.of(context).padding.bottom,
        left: 24.width,
        right: 24.width,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.radius),
          topRight: Radius.circular(8.radius),
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 2.height,
            width: 40.width,
            decoration: BoxDecoration(
              color: Color(0xFFB1B0B8),
              borderRadius: BorderRadius.circular(50.radius),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget != null) ...{
                widget!,
              } else ...{
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xFF585666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              },
              if (showButtons == true) ...{
                SizedBox(height: 24.height),
                Row(
                  children: [
                    if (showCancelButton) ...{
                      ModalButton(
                        title: cancelText,
                        onTap: onCancel,
                        color: cancelColor,
                        textColor: textCancelColor,
                        loading: cancelLoading,
                      ),
                    },
                    if (confirmText != null && showConfirmButton) ...{
                      SizedBox(width: 16.width),
                      ModalButton(
                        title: confirmText ?? 'Confirmar',
                        color: confirmColor ?? VvsColors.error,
                        textColor: textConfirmColor,
                        onTap: onConfirm,
                        loading: confirmLoading,
                      ),
                    },
                  ],
                ),
              },
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ModalButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color? color;
  Color? borderColor;
  final Color? textColor;
  final bool loading;
  ModalButton({
    Key? key,
    required this.title,
    this.onTap,
    this.color,
    this.borderColor,
    this.textColor,
    this.loading = false,
  }) {
    borderColor = Color(0xFFE3E3E5);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScaleOnTap(
        onTap: onTap,
        child: Container(
          height: 45.height,
          decoration: BoxDecoration(
            color: color ?? Color(0xFFFAFAFC),
            borderRadius: BorderRadius.circular(5.radius),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                    width: 1.width,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: Center(
            child: loading == false
                ? Text(
                    title,
                    style: TextStyle(
                      color: textColor ?? Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  )
                : Container(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5.width,
                    ),
                    height: 20.height,
                    width: 20.width,
                  ),
          ),
        ),
      ),
    );
  }
}
