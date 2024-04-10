import 'package:flutter/material.dart';

Widget buttonWithProgressIndicator(
    {VoidCallback? onPress,
      Widget? widget,
      double? fontSize,
      FontWeight?fontWeight,
      double? width,
      double? height,
      Color? bgColor,
      Color? textColor}) {
  return SizedBox(
    width: width,
    height: height,
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.0),

      ),
        child: widget
    ),
  );
}