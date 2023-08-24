import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/textfield/custom_text_field.dart';

class NewPassScreen extends StatefulWidget {
  const NewPassScreen({super.key});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authController = Get.find<AuthController>();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final phone = Get.arguments();

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
            Image.asset("assets/images/20.PNG"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create New Password",
                        style: theme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 0.5.h),
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
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 2.h),
                      CustomButtonNew(
                        text: 'Submit',
                        onTap: () async {},
                        height: 5.5.h,
                        borderRadius: 20,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
