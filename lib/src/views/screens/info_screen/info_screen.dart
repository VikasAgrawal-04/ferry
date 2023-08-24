import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/general_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utils/constants/colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final generalController = Get.find<GeneralController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await api();
      await generalController.getContactInfo();
    });
    super.initState();
  }

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
                  onTap: () {
                    Get.toNamed(AppRoutes.infoDetails,
                        arguments: generalController.appInfo.last);
                  },
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
                  onTap: () {
                    Get.toNamed(AppRoutes.contactUs);
                  },
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
                  onTap: () {
                    Get.toNamed(AppRoutes.infoDetails,
                        arguments: generalController.appInfo[2]);
                  },
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
                  onTap: () {
                    Get.toNamed(AppRoutes.infoDetails,
                        arguments: generalController.appInfo[1]);
                  },
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

  Future<bool> api() async {
    final result = await generalController.getAppInfo();
    return result;
  }
}
