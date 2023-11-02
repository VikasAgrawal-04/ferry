import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:goa/src/controllers/payment_controller.dart/paytm_payment_controller.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  final String routeName = Get.arguments;
  final routeController = Get.find<RouteController>();
  final paytmController = Get.find<PaytmController>();
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Text(routeName, style: theme.displayMedium),
          Text("Select Pass",
              textAlign: TextAlign.center, style: theme.bodySmall)
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(routeController.passes.length, (index) {
              final data = routeController.passes[index];
              final img = routeController.passes[index].passimg;
              return pass(
                  name: data.passname,
                  img: img,
                  onTap: () async {
                    await paytmController.generateChecksum(
                        passId: data.passid,
                        amount: double.parse(data.cost).toInt());
                  });
            }),
          ),
        ),
      ),
    );
  }

  Widget pass(
      {required String name, required String img, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ]),
        padding: EdgeInsets.all(.5.h),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
              child: Helpers.imgFromBase64(img),
            ),
            SizedBox(height: 1.h),
            Text(name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
