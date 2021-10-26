import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle boldtextsyle(double size, {Color? color, bool? shadow}) {
  return GoogleFonts.oxygen(
    fontSize: size,
    color: (color == null)
        ? ((Get.theme == ThemeData.dark()) ? Colors.white : Colors.black)
        : color,
    shadows: (shadow != null)
        ? [
            const Shadow(
              blurRadius: 2.5,
              color: Colors.grey,
            )
          ]
        : null,
    fontWeight: FontWeight.bold,
  );
}

TextStyle normaltextsyle(double size, {Color? color}) {
  return GoogleFonts.oxygen(
    fontSize: size,
    color: (color == null)
        ? ((Get.theme == ThemeData.dark()) ? Colors.white : Colors.black)
        : color,
  );
}

TextStyle mediumtextsyle(double size, {Color? color}) {
  return GoogleFonts.oxygen(
    fontSize: size,
    color: (color == null)
        ? ((Get.theme == ThemeData.dark()) ? Colors.white : Colors.black)
        : color,
    fontWeight: FontWeight.w500,
  );
}
