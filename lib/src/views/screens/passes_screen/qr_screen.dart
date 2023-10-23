import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/payment_controller.dart/paytm_payment_controller.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final paytmController = Get.find<PaytmController>();
  final String qrImg = Get.arguments;
  final Map<String, dynamic> data = Get.parameters;
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      bottomNavigationBar: CustomButtonNew(
        height: 5.5.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
        onTap: () async {
          await paytmController.verifyTransaction(data['id']);
        },
        text: 'Check Payment Status',
        color: Colors.blue,
      ),
      appBar: AppBar(
        title: Text(
          'Download or Scan QR',
          style: theme.displayMedium,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Helpers.downloadQrImage(qrImg);
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: Column(
          children: [
            Text(
              'Pay With Any UPI App',
              style: theme.displayMedium,
            ),
            Text(
              '₹ ${data['amount']}',
              style: theme.displayLarge,
            ),
            SizedBox(height: 10.h),
            Helpers.imgFromBase64(qrImg),
          ],
        ),
      ),
    );
  }
}
