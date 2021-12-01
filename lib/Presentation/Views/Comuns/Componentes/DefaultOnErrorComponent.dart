import 'package:flutter/material.dart';

class DefaultOnErrorComponent extends StatelessWidget {
  final String error;
  DefaultOnErrorComponent({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
