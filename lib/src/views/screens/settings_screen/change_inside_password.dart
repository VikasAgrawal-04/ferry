import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/auth_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/button/custom_button.dart';
import '../../widgets/textfield/custom_text_field.dart';

class ChangeInsidePass extends StatefulWidget {
  const ChangeInsidePass({super.key});

  @override
  State<ChangeInsidePass> createState() => _ChangeInsidePassState();
}

class _ChangeInsidePassState extends State<ChangeInsidePass> {
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final oldPassController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

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
            Image.asset("assets/images/main7.PNG"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Password",
                      style: theme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 0.5.h),
                    CustomTextFieldNew(
                      control: oldPassController,
                      type: "password",
                      hint: "Enter Old Password",
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
                      control: passwordController,
                      type: "password",
                      hint: "Enter Password",
                      isRequired: true,
                      focusNode: _focusNode2,
                      keyboardType: TextInputType.text,
                      isNumber: false,
                      style: theme.bodySmall,
                      onEditingComplete: () {
                        _focusNode2.unfocus();
                        FocusScope.of(context).requestFocus(_focusNode3);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 1.h),
                    CustomTextFieldNew(
                      control: confirmPasswordController,
                      type: "password",
                      focusNode: _focusNode3,
                      hint: "Enter Confirm Password",
                      isRequired: true,
                      keyboardType: TextInputType.text,
                      isNumber: false,
                      style: theme.bodySmall,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 2.h),
                    CustomButtonNew(
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      text: 'Submit',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if ((passwordController.text ==
                              confirmPasswordController.text)) {
                            await authController.changePassword(
                                oldPass: oldPassController.text,
                                newPass: passwordController.text);
                          } else {
                            EasyLoading.showError(
                                'Passwords do not match. Please try again.');
                          }
                        }
                      },
                      height: 5.5.h,
                      borderRadius: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
