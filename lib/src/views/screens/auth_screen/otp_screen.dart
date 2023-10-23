import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/auth_controller.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OtpScreeen extends StatefulWidget {
  const OtpScreeen({super.key});

  @override
  State<OtpScreeen> createState() => _OtpScreeenState();
}

class _OtpScreeenState extends State<OtpScreeen> {
  String number = Get.arguments;
  final param = Get.parameters;
  final authController = Get.find<AuthController>();
  final enteredOtp = "".obs;

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
            Pinput(
              obscureText: true,
              errorBuilder: (errorText, pin) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(errorText.toString(),
                      style: theme.bodyMedium?.copyWith(color: Colors.red)),
                ));
              },
              length: 6,
              showCursor: true,
              onChanged: (value) {
                enteredOtp.value = value;
              },
              onCompleted: (value) async {
                enteredOtp.value = value;
                await authController.verfiyOtp(
                    number: number,
                    otp: value,
                    forgot: param.values.isNotEmpty);
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            ),
            SizedBox(height: 23.h),
            CustomButtonNew(
                text: 'Verify',
                height: 6.h,
                onTap: () async {
                  await authController.verfiyOtp(
                      number: number,
                      otp: enteredOtp.value,
                      forgot: param.values.isNotEmpty);
                },
                margin: EdgeInsets.symmetric(horizontal: 6.w)),
            TextButton(
              onPressed: () async {
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
