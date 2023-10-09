import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/api_controller/route_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../widgets/textfield/custom_text_field.dart';

class PaperPassScreen extends StatefulWidget {
  const PaperPassScreen({super.key});

  @override
  State<PaperPassScreen> createState() => _PaperPassScreenState();
}

class _PaperPassScreenState extends State<PaperPassScreen> {
  final transferCode = TextEditingController();
  final routeController = Get.find<RouteController>();
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Image.asset("assets/images/main5.PNG"),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Scan Paper Pass",
                      style: theme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 1.0.h),
                  Text("Enter Paper Code To Import Pass",
                      style: theme.bodyMedium),
                  SizedBox(height: 1.h),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: CustomTextFieldNew(
                          control: transferCode,
                          hint: 'Enter Paper Code',
                          focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          isRequired: true,
                          keyboardType: TextInputType.text,
                          isNumber: false,
                          textInputAction: TextInputAction.done)),
                  SizedBox(height: 5.h),
                  CustomButtonNew(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    text: "Verify & Import",
                    onTap: () async {
                      await routeController.checkPaperPass(
                          paperPass: transferCode.text);
                    },
                    height: 5.5.h,
                  ),
                  SizedBox(height: 5.h),
                  Text("OR",
                      style: theme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  Divider(
                    endIndent: 20.w,
                    indent: 20.w,
                  ),
                  CustomButtonNew(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    text: "Scan Barcode",
                    color: AppColors.greenBg,
                    onTap: () async {
                      await Get.toNamed(AppRoutes.scanPaperPass);
                    },
                    height: 5.5.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
