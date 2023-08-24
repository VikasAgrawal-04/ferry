import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/route_controller.dart';
import 'package:goa/src/views/widgets/card/white_box_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TransferPass extends StatefulWidget {
  const TransferPass({super.key});

  @override
  State<TransferPass> createState() => _TransferPassState();
}

class _TransferPassState extends State<TransferPass> {
  final routeController = Get.find<RouteController>();
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
            Align(
              alignment: Alignment.center,
              child: Text(
                "Transfer Pass",
                style: theme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IMPORTANT !! \n\n ONCE YOUR TRANSFER YOU WILL NOT BE ABLE TO USE THIS  PASS ON THIS DEVICE.",
                    textAlign: TextAlign.center,
                    style: theme.bodyMedium
                        ?.copyWith(color: Colors.redAccent, height: 0.12.h),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Available Passes ",
                    style: theme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600),
                  ),
                  ListView.builder(
                      itemCount: routeController.yourPasses.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 2.h, top: 1.5.h),
                      itemBuilder: (context, index) {
                        final data = routeController.yourPasses[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.2.h),
                          child: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: 'Are You Sure?',
                                  middleText: 'You Want To Transfer Pass?',
                                  textConfirm: 'Yes',
                                  textCancel: 'No',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () async {
                                    await routeController.transferPass(
                                        passCode: data.passcode);
                                  });
                            },
                            splashColor: Colors.transparent,
                            child: WhiteBoxCard(
                                children: [Text("${data.passname} ")]),
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
