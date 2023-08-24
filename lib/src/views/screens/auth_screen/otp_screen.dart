import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/auth_controller.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:goa/src/views/widgets/textfield/custom_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OtpScreeen extends StatefulWidget {
  const OtpScreeen({super.key});

  @override
  State<OtpScreeen> createState() => _OtpScreeenState();
}

class _OtpScreeenState extends State<OtpScreeen> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  String number = Get.arguments;
  final param = Get.parameters;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Image.asset('assets/images/main6.PNG'),
            SizedBox(height: 5.h),
            Text("Confirm OTP", style: theme.displayMedium),
            SizedBox(height: 1.h),
            Wrap(
              spacing: 2.w,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 12.w,
                  child: CustomTextFieldNew(
                      enabledBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      textAlign: TextAlign.center,
                      singleInput: true,
                      isRequired: false,
                      keyboardType: TextInputType.number,
                      control: _controllers[index],
                      focusNode: _focusNodes[index],
                      isNumber: true,
                      onChanged: (value) {
                        if (value.length == 1 && index != 5) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                      textInputAction: index == 5
                          ? TextInputAction.done
                          : TextInputAction.none),
                );
              }),
            ),
            SizedBox(height: 23.h),
            CustomButtonNew(
                text: 'Verify',
                height: 6.h,
                onTap: () async {
                  final otp = _controllers.fold('',
                      (previousValue, element) => previousValue + element.text);
                  await authController.verfiyOtp(
                      number: number,
                      otp: otp,
                      forgot: param.values.isNotEmpty);
                },
                margin: EdgeInsets.symmetric(horizontal: 6.w)),
            TextButton(
              onPressed: () async {
                _controllers.map((e) => e.clear());
                await authController.resendOtp(number: number);
              },
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              ),
              child: Text(
                "Didn't received OTP?\n Resend OTP.",
                style: theme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
