import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../Extensions/ScreenUtilExtension.dart';

class KaytaBottomSheet extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool disabled;
  final bool loading;

  const KaytaBottomSheet({Key? key, required this.title, this.onTap, this.disabled = false, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        color: disabled == false ? VvsColors.primary : Colors.grey.shade400,
        height: 50.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: loading == true
              ? Container(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5.width,
                  ),
                  height: 20.height,
                  width: 20.width,
                )
              : Text(
                  title,
                  style: TextStyle(
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
