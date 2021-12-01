import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Theme/Colors.dart';
import '../../Extensions/ScreenUtilExtension.dart';

class SearchTextField extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String)? submit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final FocusNode? focusNode;

  const SearchTextField({
    Key? key,
    this.onChanged,
    this.submit,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly = false,
    this.controller,
    this.focusNode,
  }) : super(key: key);
  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool showCloseButton = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();

    controller.addListener(() => setState(() => showCloseButton = controller.text.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.height,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          fillColor: VvsColors.primaryDark,
          filled: true,
          border: border,
          errorBorder: border,
          enabledBorder: border,
          focusedBorder: border,
          disabledBorder: border,
          focusedErrorBorder: border,
          contentPadding: EdgeInsets.only(bottom: 0, left: 0, right: 24, top: 0),
          suffixIcon: AnimatedOpacity(
            opacity: showCloseButton ? 1 : 0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInToLinear,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 20.height),
              onPressed: () {
                controller.clear();
                widget.onChanged?.call(controller.text);
              },
            ),
          ),
          prefixIcon: Icon(Icons.search, color: Colors.white, size: 20.height),
        ),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Colors.white),
        cursorColor: Colors.white,
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.submit,
      ),
    );
  }

  InputBorder get border => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5.radius),
      );
}
