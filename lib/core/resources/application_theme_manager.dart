import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptops/core/resources/theme_color.dart';

class ApplicationThemeManager {
  static final ThemeData themeData = ThemeData(
    primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.transparent,

    //   appBarTheme: const AppBarTheme(
    //     backgroundColor: AppColors.primaryColor,
    //     elevation: 0,
    //     centerTitle: true,
    //
    //     shape:  RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         bottomRight:Radius.circular(28) ,
    //         bottomLeft: Radius.circular(28)
    //       )
    //     ),
    //
    //     // backgroundColor: Colors.transparent,
    //     titleTextStyle: TextStyle(
    //       fontSize: 22,
    //       fontWeight: FontWeight.bold,
    //       color: Colors.white
    //
    //     ),
    //     iconTheme: IconThemeData(
    //       color: Colors.white,
    //       size: 35,
    //     )
    //
    // ),

    // ==========================================================
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: AppColors.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(
        color: AppColors.whiteColor,
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
      displaySmall: GoogleFonts.poppins(
        color: AppColors.blackColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    // ==========================================================
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: const IconThemeData(
        size: 30,
        color: AppColors.primaryColor),
      unselectedIconTheme: IconThemeData(

        color: Colors.grey[600]
      ),
      showUnselectedLabels: false,

    ),
    //==========================================================
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: const BoxConstraints(
        maxHeight: 100,
        maxWidth: 100,
        minHeight: 73,
        minWidth: 73
      ),
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: const BorderSide(
          color: AppColors.whiteColor,
          width: 5,
        )
      )

    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape:RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.whiteColor
        ),
        borderRadius: BorderRadius.circular(25),
      )
    ),
    iconTheme: const IconThemeData(
      color: AppColors.blackColor
    ),
  );
}

