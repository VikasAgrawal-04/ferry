import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/auth_controller.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:goa/src/views/widgets/textfield/custom_text_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthController>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    _checkPermission();
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        final result1 = await Permission.manageExternalStorage.request();
        if (result == PermissionStatus.granted &&
            result1 == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Image.asset("assets/images/main7.PNG"),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log In",
                          style: theme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 0.5.h),
                        CustomTextFieldNew(
                            control: phoneController,
                            hint: "Enter Phone Number",
                            isRequired: true,
                            keyboardType: TextInputType.phone,
                            isNumber: true,
                            style: theme.bodySmall,
                            type: 'phone',
                            textInputAction: TextInputAction.next),
                        SizedBox(height: 1.h),
                        CustomTextFieldNew(
                          control: passwordController,
                          type: "password",
                          hint: "Enter Password",
                          isRequired: true,
                          keyboardType: TextInputType.text,
                          isNumber: false,
                          style: theme.bodySmall,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () async {
                            await api();
                          },
                        ),
                        SizedBox(height: 1.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent),
                              ),
                              child: Text("Forgot Password?",
                                  style: theme.titleSmall)),
                        ),
                        SizedBox(height: 2.h),
                        CustomButtonNew(
                          text: 'Log In',
                          onTap: () async {
                            await api();
                          },
                          height: 5.5.h,
                          borderRadius: 20,
                        ),
                        SizedBox(height: .1.h),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent),
                              ),
                              onPressed: () {
                                Get.toNamed(AppRoutes.register);
                              },
                              child: Text("New User? | Sign Up",
                                  style: theme.titleSmall)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 8.5.h,
              left: 0,
              right: 0,
              child: Text(
                "GOA\n ferry app",
                style: theme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> api() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      final result = await authController.login(
          number: phoneController.text, password: passwordController.text);
      EasyLoading.dismiss();
      Get.offAndToNamed(AppRoutes.dashboard);
      return result;
    } else {
      return false;
    }
  }
}