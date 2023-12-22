import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Return/Refund', style: context.textTheme.displayMedium),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Column(
          children: [
            Text(
                'All sales are final and no refund will be issued. The return of the of the purchased goods are not allowed through the app directly. In case of disputes of such cases you can contact us via Email or Phone number.',
                style: context.textTheme.bodyMedium),
            SizedBox(height: 2.h),
            const Spacer(),
            Text('Email: admin-river.goa@nic.in',
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 1.h),
            Text('Phone: 0832 2410790', style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
