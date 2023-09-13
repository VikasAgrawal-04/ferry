import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../controllers/api_controller/auth_controller.dart';
import '../../../widgets/textfield/custom_text_field.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({super.key});

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Image.asset("assets/images/23.PNG"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password",
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
                      SizedBox(height: 4.h),
                      CustomButtonNew(
                        text: 'Send OTP',
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        height: 5.5.h,
                        borderRadius: 20,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final result = await authController.resendOtp(
                                number: phoneController.text);
                            if (result) {
                              Get.toNamed(AppRoutes.otp,
                                  arguments: phoneController.text,
                                  parameters: {'forgot': "true"});
                            }
                          }
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
