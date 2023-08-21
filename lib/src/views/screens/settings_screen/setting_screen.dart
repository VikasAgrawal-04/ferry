import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/routing_services/routes.dart';
import '../../../core/utils/constants/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 5.h),
            Image.asset('assets/images/main1.PNG'),
            Text("SETTINGS", style: theme.displayLarge),
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
                            child: Text("Change Password",
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
                            child: Text("Transfer Pass",
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
                            child: Text("Import Pass",
                                textAlign: TextAlign.center,
                                style: theme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)))),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.clear();
                      Get.toNamed(AppRoutes.login);
                    },
                    child: Card(
                        margin: EdgeInsets.only(bottom: 1.5.h),
                        color: AppColors.greenBg,
                        child: Container(
                            width: 100.w,
                            margin: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 4.w),
                            child: Text("Log Out",
                                textAlign: TextAlign.center,
                                style: theme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)))),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}