import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color.fromARGB(255, 1, 9, 100);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color black = Colors.black;
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[500] : Colors.grey[800],
    ),
  );
}

TextStyle get HeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get TitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[800],
    ),
  );
}
