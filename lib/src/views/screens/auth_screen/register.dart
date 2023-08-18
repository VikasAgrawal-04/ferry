import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/auth_controller.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/textfield/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.find<AuthController>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final _formKey = GlobalKey<FormState>();
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
            SizedBox(height: 4.h),
            SvgPicture.asset(
              "assets/images/svg/main7_adobe_express.svg",
              height: 50.h,
              width: 100.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register New User",
                        style: theme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextFieldNew(
                          control: nameController,
                          hint: "Enter Your Name",
                          isRequired: true,
                          keyboardType: TextInputType.name,
                          isNumber: false,
                          style: theme.bodySmall,
                          type: 'normal',
                          textInputAction: TextInputAction.next),
                      SizedBox(height: 1.h),
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
                        focusNode: _focusNode1,
                        keyboardType: TextInputType.text,
                        isNumber: false,
                        style: theme.bodySmall,
                        onEditingComplete: () {
                          _focusNode1.unfocus();
                          FocusScope.of(context).requestFocus(_focusNode2);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 1.h),
                      CustomTextFieldNew(
                        control: confirmPasswordController,
                        type: "password",
                        focusNode: _focusNode2,
                        hint: "Enter Confirm Password",
                        isRequired: true,
                        keyboardType: TextInputType.text,
                        isNumber: false,
                        style: theme.bodySmall,
                        onEditingComplete: () async {
                          await api();
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 2.h),
                      CustomButtonNew(
                        text: 'Register',
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
                              Get.back();
                            },
                            child: Text("Already an user? | Sign In",
                                style: theme.titleSmall)),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> api() async {
    if (_formKey.currentState!.validate()) {
      if ((passwordController.text == confirmPasswordController.text)) {
        EasyLoading.show();
        await authController.register(
            number: phoneController.text,
            password: passwordController.text,
            name: nameController.text);
        EasyLoading.dismiss();
        Get.back();
      } else {
        EasyLoading.showError('Passwords do not match. Please try again.');
      }
      return true;
    } else {
      return false;
    }
  }
}
