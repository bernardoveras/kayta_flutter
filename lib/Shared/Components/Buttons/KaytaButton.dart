import 'package:flutter/material.dart';
import '../../Extensions/ScreenUtilExtension.dart';
import '../../Theme/Colors.dart';
import '../ScaleOnTap.dart';

class KaytaButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool disabled;
  final bool loading;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final TextStyle? style;
  final Widget? onLoading;

  const KaytaButton({
    Key? key,
    required this.title,
    this.onTap,
    this.disabled = false,
    this.loading = false,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.style,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        height: height ?? 45.height,
        width: width ?? MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: disabled == false ? color ?? VvsColors.primary : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(radius ?? 5.radius),
        ),
        child: Center(
          child: loading == true
              ? onLoading ?? Container(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5.width,
                  ),
                  height: 20.height,
                  width: 20.width,
                )
              : Text(
                  title,
                  style:style ?? TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
