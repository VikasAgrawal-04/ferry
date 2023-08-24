import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/route_controller.dart';
import 'package:goa/src/core/utils/constants/colors.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:goa/src/views/widgets/card/white_box_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../core/utils/helpers/helpers.dart';

class YourPassScreen extends StatefulWidget {
  const YourPassScreen({super.key});

  @override
  State<YourPassScreen> createState() => _YourPassScreenState();
}

class _YourPassScreenState extends State<YourPassScreen> {
  final routeController = Get.find<RouteController>();
  final RxInt _selectedPass = 0.obs;
  RxDouble animationValue = 1.0.obs;
  Rx<DateTime> initialDateTime = DateTime.now().obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await routeController.getYourPasses();
      startClock();
      startBlinking();
    });
    super.initState();
  }

  void startClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      initialDateTime.value = DateTime.now();
    });
  }

  void startBlinking() {
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      animationValue.value = animationValue.value == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Your Passes', style: theme.displayMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => SizedBox(
                  height: 70.h,
                  child: routeController.yourPasses.isEmpty
                      ? Center(
                          child: Text(
                            "You Do Not Have Any Passes. \n Please Buy!",
                            style: theme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 62.h,
                                  child: Obx(
                                    () => WhiteBoxCard(
                                        margin: EdgeInsets.only(
                                            top: 1.h, left: 4.w, right: 4.w),
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                routeController
                                                    .yourPasses[
                                                        _selectedPass.value]
                                                    .routename,
                                                style: theme.bodyMedium,
                                                textAlign: TextAlign.center),
                                          ),
                                          SizedBox(
                                            height: 37.h,
                                            child: Helpers.imgFromBase64(
                                                routeController
                                                    .yourPasses[
                                                        _selectedPass.value]
                                                    .routeimg),
                                          ),
                                          SizedBox(
                                            height: 11.h,
                                            child: SfBarcodeGenerator(
                                                symbology: Code128A(module: 2),
                                                showValue: true,
                                                value: routeController
                                                    .yourPasses[
                                                        _selectedPass.value]
                                                    .passcode),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Valid Till : ${Helpers.formattedDate(routeController.yourPasses[_selectedPass.value].validTillDate)}",
                                              style: theme.bodyMedium,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              Helpers.formatTimeDate(
                                                  initialDateTime.value),
                                              style: theme.bodySmall,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Positioned(
                                  top: 2.h,
                                  right: 4.h,
                                  child: AnimatedOpacity(
                                    opacity: animationValue.value,
                                    duration: const Duration(milliseconds: 400),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      width: 4.w,
                                      height: 1.5.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.greenBg,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                              child: ListView.builder(
                                  itemCount: routeController.yourPasses.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.5.h, horizontal: 4.w),
                                  itemBuilder: (context, index) {
                                    final data =
                                        routeController.yourPasses[index];
                                    return InkWell(
                                      onTap: () {
                                        _selectedPass.value = index;
                                      },
                                      splashColor: Colors.transparent,
                                      child: Obx(
                                        () => Container(
                                          margin: EdgeInsets.only(left: 2.w),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 0.5.h),
                                          decoration: BoxDecoration(
                                              color:
                                                  _selectedPass.value == index
                                                      ? AppColors.greenBg
                                                      : Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]),
                                          child: Text(data.routename,
                                              style: theme.bodyMedium?.copyWith(
                                                  color: _selectedPass.value ==
                                                          index
                                                      ? AppColors.textWhite
                                                      : AppColors.txtPrimary),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                )),
            Divider(indent: 5.w, endIndent: 5.w),
            Center(
              child: CustomButtonNew(
                height: 5.5.h,
                onTap: () {
                  Get.toNamed(AppRoutes.routeListing);
                },
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                color: AppColors.greenBg,
                text: 'Buy Passes!',
              ),
            )
          ],
        ),
      ),
    );
  }
}
