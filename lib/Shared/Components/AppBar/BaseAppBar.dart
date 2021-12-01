import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Extensions/ScreenUtilExtension.dart';

class BaseAppBar extends PreferredSize {
  BaseAppBar({
    required String title,
    Widget? description,
    bool showReturnButton = true,
    IconData returnIcon = Icons.arrow_back,
    double? returnIconSize,
    Color returnIconColor = Colors.white,
    List<Widget>? actions,
    void Function()? onReturn, 
    double elevation = 0,
  }) : super(
          preferredSize: Size.fromHeight(125.height),
          child: AppBar(
            toolbarHeight: 125.height,
            elevation: elevation,
            titleSpacing: 24.height,
            leading: SizedBox(),
            leadingWidth: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25.height,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      if (showReturnButton == true) ...{
                        IconButton(
                          onPressed: () => onReturn?.call(),
                          icon: Icon(returnIcon, size: returnIconSize ?? 24.height),
                          color: returnIconColor,
                          padding: EdgeInsets.only(right: 10.width),
                          constraints: const BoxConstraints(),
                        ),
                      },
                      if (description != null) ...{
                        description,
                      },
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (actions != null) ...{
                      Row(children: actions),
                    }
                  ],
                ),
              ],
            ),
          ),
        );
}
