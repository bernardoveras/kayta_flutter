import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../TextField/SearchTextField.dart';
import '../../Extensions/ScreenUtilExtension.dart';

class BaseSearchAppBar extends PreferredSize {
  BaseSearchAppBar({
    String title = '',
    Widget? titleWidget,
    IconData returnIcon = Icons.arrow_back,
    double? returnIconSize,
    Color returnIconColor = Colors.white,
    List<Widget>? actions,
    bool readOnlyTextField = false,
    TextEditingController? textFieldController,
    required void Function()? onReturn,
    void Function(String)? onChangedSearchText,
    void Function(String)? onSubmitSearch,
    required BuildContext context,
    FocusNode? focusNode,
    double elevation = 0,
  })  : assert(title.isEmpty || titleWidget == null),
        super(
          preferredSize: Size.fromHeight(125.height),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: AppBar(
              toolbarHeight: 125.height,
              elevation: elevation,
              titleSpacing: 24.height,
              leading: SizedBox(),
              leadingWidth: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: IconButton(
                            onPressed: () => onReturn?.call(),
                            icon: Icon(returnIcon, size: returnIconSize ?? 24.height),
                            color: returnIconColor,
                            padding: EdgeInsets.only(right: 10.width),
                            constraints: const BoxConstraints(),
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                        titleWidget ??
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                        if (actions != null) ...{
                          Positioned(
                            right: 0,
                            child: Row(
                              children: actions,
                            ),
                          )
                        },
                      ],
                    ),
                  ),
                  SizedBox(height: 20.height),
                  SearchTextField(
                    onChanged: onChangedSearchText,
                    submit: onSubmitSearch,
                    readOnly: readOnlyTextField,
                    controller: textFieldController,
                    focusNode: focusNode,
                  ),
                ],
              ),
            ),
          ),
        );
}
