import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utils/constants/colors.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Image.asset('assets/images/main5.PNG'),
          Text("Information", style: theme.displayLarge),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Card(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      color: AppColors.greenBg,
                      child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          child: Text("Help",
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)))),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      color: AppColors.greenBg,
                      child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          child: Text("Contact Us",
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)))),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      color: AppColors.greenBg,
                      child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          child: Text("Terms & Conditions",
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)))),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      color: AppColors.greenBg,
                      child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          child: Text("Privacy Policy",
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
