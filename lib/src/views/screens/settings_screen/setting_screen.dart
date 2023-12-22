import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/payment_controller.dart/paytm_payment_controller.dart';
import 'package:goa/src/core/utils/helpers/database_helpers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/routing_services/routes.dart';
import '../../../core/utils/constants/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final general = Get.find<PaytmController>();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              SizedBox(
                  height: 40.h,
                  child: Image.asset(
                    'assets/images/main1.PNG',
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                  )),
              Text("SETTINGS", style: theme.displayLarge),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.changeInPass);
                      },
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
                      onTap: () {
                        Get.toNamed(AppRoutes.transferPass);
                      },
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
                      onTap: () {
                        Get.toNamed(AppRoutes.importPass);
                      },
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
                        DatabaseHelper.instance.deleteEverything();
                        Get.offAllNamed(AppRoutes.login);
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
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Delete Account',
                            middleText:
                                'Are you sure you want to delete your account?',
                            onCancel: () {
                              Get.back();
                            },
                            onConfirm: () async {
                              await general.deleteAccount();
                            });
                      },
                      child: Card(
                        margin: EdgeInsets.only(bottom: 1.5.h),
                        color: AppColors.greenBg,
                        child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          child: Text(
                            "Delete Account",
                            textAlign: TextAlign.center,
                            style: theme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      endIndent: 6.w,
                      indent: 6.w,
                    ),
                    Center(
                      child: Text('By River Navigation Department',
                          style: theme.displaySmall),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
