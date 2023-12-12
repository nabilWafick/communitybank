import 'package:flutter/material.dart';
import 'package:communitybank/utils/colors/colors.util.dart';

class CBThemeData {
  static final lightTheme = ThemeData(
    // primarySwatch: Colors.blue,
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all(true),
    ),
    unselectedWidgetColor: CBColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CBColors.primaryColor,
      primary: CBColors.primaryColor,
      secondary: CBColors.primaryColor,
      surface: CBColors.primaryColor,
      primaryContainer: CBColors.primaryColor,
      brightness: Brightness.light,
    ),
    primaryColor: CBColors.primaryColor,
    fontFamily: 'Poppins',
    cardTheme: CardTheme(
      elevation: .0,
      margin: const EdgeInsets.all(.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: CBColors.secondaryColor,
      ),
      bodyMedium: TextStyle(
        color: CBColors.secondaryColor,
      ),
      bodySmall: TextStyle(
        color: CBColors.secondaryColor,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: CBColors.backgroundColor,
      foregroundColor: CBColors.secondaryColor,
      toolbarHeight: 110.0,
      elevation: .7,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: CBColors.tertiaryColor,
      ),
      actionsIconTheme: IconThemeData(
        color: CBColors.secondaryColor,
        // color: CBColors.primaryColor
      ),
      titleTextStyle: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color: CBColors.secondaryColor,
        overflow: TextOverflow.clip,
      ),
    ),
    scaffoldBackgroundColor: CBColors.backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: .0,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        textStyle: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        foregroundColor: Colors.white,
        backgroundColor: CBColors.primaryColor,
        minimumSize: const Size(double.maxFinite, 45.0),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: .0,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        textStyle: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        foregroundColor: CBColors.primaryColor,
        backgroundColor: CBColors.backgroundColor,
        minimumSize: const Size(50.0, 45.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      labelStyle: const TextStyle(
        color: CBColors.secondaryColor,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      hintStyle: const TextStyle(
        color: CBColors.secondaryColor,
        fontSize: 12.0,
        fontFamily: 'Poppins',
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: CBColors.tertiaryColor, width: .5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: CBColors.primaryColor, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: CBColors.tertiaryColor, width: .5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.red, width: .5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: CBColors.secondaryColor,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll(
          CBColors.backgroundColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: CBColors.secondaryColor,
          fontSize: 12.0,
          fontFamily: 'Poppins',
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: CBColors.primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:
              const BorderSide(color: CBColors.tertiaryColor, width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:
              const BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.red, width: .5),
        ),
      ),
    ),
  );
  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all(true),
    ),
    unselectedWidgetColor: CBColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: CBColors.primaryColor,
        primary: CBColors.primaryColor,
        secondary: CBColors.primaryColor,
        background: CBColors.primaryColor,
        surface: CBColors.primaryColor,
        primaryContainer: CBColors.primaryColor,
        brightness: Brightness.dark),
    primaryColor: CBColors.primaryColor,
    fontFamily: 'Poppins',
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(.0),
      color: const Color(0xff1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1E1E1E),
      foregroundColor: Colors.white,
      toolbarHeight: 110.0,
      elevation: 2.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(
          //  color: CBColors.secondaryColor87,
          color: Colors.white),
      titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          color: Colors.white,
          overflow: TextOverflow.clip),
    ),
    scaffoldBackgroundColor: const Color(0xff1E1E1E),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        elevation: .0,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        textStyle: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        foregroundColor: Colors.white,
        backgroundColor: CBColors.primaryColor,
        minimumSize: const Size(50.0, 45.0),
      ),
    ),
    /* outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
            side: const BorderSide(width: .0, color: CBColors.primaryColor)),
        // elevation: 2.0,
        // backgroundColor: backgroundColor,
        minimumSize: const Size(50.0, 45.0),
      ),Color(0xff9BA39F)
    ),*/
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      labelStyle: const TextStyle(
          color: Color(0xff9BA39F),
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins'),
      hintStyle: const TextStyle(
          color: Color(0xff9BA39F), fontSize: 12.0, fontFamily: 'Poppins'),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Color(0xff9BA39F), width: .50),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: CBColors.primaryColor, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Color(0xff9BA39F), width: .5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.red, width: .5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      // menuStyle: MenuStyle(),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
            color: Color(0xff9BA39F), fontSize: 12.0, fontFamily: 'Poppins'),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xff9BA39F), width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:
              const BorderSide(color: CBColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.red, width: .5),
        ),
      ),
    ),
  );
}
