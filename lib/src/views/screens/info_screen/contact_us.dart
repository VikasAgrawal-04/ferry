import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/api_controller/general_controller.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Image.asset(
                  "assets/images/4.PNG",
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
                ),
                Center(
                  child: Text(
                    "Contact Us",
                    style:
                        theme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 1.h),
                contact(
                    "assets/images/call.svg",
                    Text(
                      generalController.contactInfo.first.mobile,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                contact(
                    "assets/images/email.svg",
                    Text(
                      generalController.contactInfo.first.email,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                contact(
                    "assets/images/facebook.svg",
                    Text(
                      generalController.contactInfo.first.facebook,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                contact(
                    "assets/images/phone.svg",
                    Text(
                      generalController.contactInfo.first.landline,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                contact(
                    "assets/images/twitter.svg",
                    Text(
                      generalController.contactInfo.first.twitter,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                contact(
                    "assets/images/web.svg",
                    Text(
                      generalController.contactInfo.first.website,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                contact(
                    "assets/images/instagram.svg",
                    Text(
                      generalController.contactInfo.first.instagram,
                      style: theme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ),
        ));
  }

  Widget contact(String asset, Text title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.4.h),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            height: 4.h,
          ),
          SizedBox(width: 16.w),
          Expanded(child: title)
        ],
      ),
    );
  }
}
