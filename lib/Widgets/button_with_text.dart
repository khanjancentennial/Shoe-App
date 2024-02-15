import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonWithText(
    {VoidCallback? onPress,
      String? text,
      double? fontSize,
      FontWeight?fontWeight,
      double? width,
      double? height,
      Color? bgColor,
      Color? textColor}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: bgColor,
            elevation: 0
        ),
        onPressed: onPress,
        child: Text(text ?? "",
            style: TextStyle(
              color: textColor, fontSize: fontSize, fontWeight: fontWeight, fontFamily: GoogleFonts.ubuntu().fontFamily,
            ))),
  );
}