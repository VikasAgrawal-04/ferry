import 'package:flutter/material.dart';
import 'package:goa/src/core/utils/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ApplicationTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldPrimary,
    fontFamily: 'Saira',
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
      titleSpacing: 0,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: AppColors.appBarIcon, size: 3.h),
    ),
    textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 20.sp,
            color: AppColors.txtPrimary,
            fontWeight: FontWeight.w700),
        displayMedium: TextStyle(
            fontSize: 18.sp,
            color: AppColors.txtPrimary,
            fontWeight: FontWeight.w700),
        displaySmall: TextStyle(
            fontSize: 16.sp,
            color: AppColors.txtPrimary,
            fontWeight: FontWeight.w700),
        titleLarge: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSubtitle,
            fontWeight: FontWeight.w300),
        titleMedium: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSubtitle,
            fontWeight: FontWeight.w300),
        titleSmall: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSubtitle,
            fontWeight: FontWeight.w300),
        bodyLarge: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.txtPrimary),
        bodyMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.txtPrimary),
        bodySmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.txtPrimary),
        labelLarge: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textWhite),
        labelMedium: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textWhite),
        labelSmall: TextStyle(
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textWhite)),
  );
}
