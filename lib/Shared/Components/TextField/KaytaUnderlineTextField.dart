import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Theme/Colors.dart';
import '../../Extensions/ScreenUtilExtension.dart';

class KaytaUnderlineTextField extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final bool autofocus;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const KaytaUnderlineTextField({
    Key? key,
    required this.title,
    this.titleStyle,
    this.textStyle,
    this.autofocus = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 1,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: VvsColors.blueGrey,
              ),
        ),
        SizedBox(height: 10.height),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          autofocus: autofocus,
          maxLines: maxLines,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          decoration: InputDecoration.collapsed(hintText: ''),
          style: textStyle ??
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: VvsColors.blueGrey,
              ),
          cursorColor: VvsColors.primary,
        ),
      ],
    );
  }

  static Widget config({
    required String title,
    void Function(String)? onChanged,
    TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String)? onFieldSubmitted,
    int? maxLines,
  }) {
    return GestureDetector(
      onTap: () {
        focusNode?.requestFocus();
      },
      child: Container(
        height: 300.height,
        width: double.infinity,
        color: Colors.transparent,
        child: KaytaUnderlineTextField(
          title: title,
          focusNode: focusNode,
          onChanged: onChanged,
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: onFieldSubmitted,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
