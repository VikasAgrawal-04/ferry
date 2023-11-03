import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
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
      startClock();
      startBlinking();
      await Future.delayed(const Duration(milliseconds: 600));
      await routeController.getYourPasses();
    });
    super.initState();
  }

  void startClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      initialDateTime.value = DateTime.now();
    });
  }

  void startBlinking() {
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      animationValue.value = animationValue.value == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          children: [
            Text('Your Passes', style: theme.displayMedium),
            Obx(() => Text(Helpers.formatTimeDate(initialDateTime.value),
                style: theme.bodySmall))
          ],
        ),
        leading: IconButton(
            onPressed: () async {
              await routeController.downloadPasses();
            },
            icon: const Icon(Icons.refresh)),
        actions: [
          Obx(() => AnimatedOpacity(
                opacity: animationValue.value,
                duration: const Duration(milliseconds: 400),
                child: AnimatedContainer(
                  margin: EdgeInsets.only(right: 4.w),
                  duration: const Duration(milliseconds: 400),
                  width: 10.w,
                  height: 2.5.h,
                  decoration: BoxDecoration(
                    color: AppColors.greenBg,
                    shape: BoxShape.circle,
                  ),
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Obx(() => SizedBox(
                height: 70.h,
                child: routeController.onlyYourPasses.isEmpty
                    ? Center(
                        child: Text(
                          "You Do Not Have Any Passes. \n Please Buy!",
                          style: theme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 58.h,
                            width: 100.w,
                            child: Obx(
                              () => WhiteBoxCard(
                                  margin: EdgeInsets.only(
                                      top: 0.8.h, left: 4.w, right: 4.w),
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          routeController
                                              .onlyYourPasses[
                                                  _selectedPass.value]
                                              .routename,
                                          style: theme.displayLarge,
                                          textAlign: TextAlign.center),
                                    ),
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          height: 32.h,
                                          child: Helpers.imgFromBase64(
                                              routeController
                                                  .onlyYourPasses[
                                                      _selectedPass.value]
                                                  .routeimg),
                                        ),
                                        Positioned(
                                            left: 5.w,
                                            top: -2.5.h,
                                            child: Container(
                                              height: 10.h,
                                              width: 20.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 0.5.h),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ]),
                                              child: SvgPicture.asset(
                                                routeController
                                                            .onlyYourPasses[
                                                                _selectedPass
                                                                    .value]
                                                            .vehicletype ==
                                                        '2'
                                                    ? 'assets/images/2 wheeler white-02.svg'
                                                    : routeController
                                                                .onlyYourPasses[
                                                                    _selectedPass
                                                                        .value]
                                                                .vehicletype ==
                                                            '4'
                                                        ? 'assets/images/four wheeler white.svg'
                                                        : routeController
                                                                    .onlyYourPasses[
                                                                        _selectedPass
                                                                            .value]
                                                                    .vehicletype ==
                                                                '6'
                                                            ? 'assets/images/medium white.svg'
                                                            : 'assets/images/heavy veh-white.svg',
                                                color: Colors.black,
                                              ),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                      child: SfBarcodeGenerator(
                                          symbology: Code128A(module: 2),
                                          showValue: true,
                                          value: routeController
                                              .onlyYourPasses[
                                                  _selectedPass.value]
                                              .passcode),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Valid Till : ${Helpers.formattedDate(routeController.onlyYourPasses[_selectedPass.value].validTillDate)}",
                                        style: theme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                            child: ListView.builder(
                                itemCount:
                                    routeController.onlyYourPasses.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 4.w),
                                itemBuilder: (context, index) {
                                  final data =
                                      routeController.onlyYourPasses[index];
                                  return InkWell(
                                    onTap: () {
                                      _selectedPass.value = index;
                                    },
                                    splashColor: Colors.transparent,
                                    child: Obx(
                                      () => Container(
                                        margin: EdgeInsets.only(left: 2.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                            color: _selectedPass.value == index
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
                                        child: Column(
                                          children: [
                                            Text(data.routename,
                                                style: theme.bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 19.sp,
                                                        color: _selectedPass
                                                                    .value ==
                                                                index
                                                            ? AppColors
                                                                .textWhite
                                                            : AppColors
                                                                .txtPrimary),
                                                textAlign: TextAlign.center),
                                            SizedBox(
                                              height: 4.5.h,
                                              width: 14.w,
                                              child: SvgPicture.asset(
                                                routeController
                                                            .onlyYourPasses[
                                                                index]
                                                            .vehicletype ==
                                                        '2'
                                                    ? 'assets/images/2 wheeler white-02.svg'
                                                    : routeController
                                                                .onlyYourPasses[
                                                                   index]
                                                                .vehicletype ==
                                                            '4'
                                                        ? 'assets/images/four wheeler white.svg'
                                                        : routeController
                                                                    .onlyYourPasses[
                                                                        index]
                                                                    .vehicletype ==
                                                                '6'
                                                            ? 'assets/images/medium white.svg'
                                                            : 'assets/images/heavy veh-white.svg',
                                                color:
                                                    _selectedPass.value == index
                                                        ? AppColors.textWhite
                                                        : AppColors.txtPrimary,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
              )),
          Divider(indent: 5.w, endIndent: 5.w),
          Row(
            children: [
              Expanded(
                child: CustomButtonNew(
                  height: 5.5.h,
                  onTap: () {
                    Get.toNamed(AppRoutes.routeListing);
                  },
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  color: AppColors.greenBg,
                  text: 'Buy Passes!',
                ),
              ),
              Expanded(
                  child: CustomButtonNew(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 5.5.h,
                color: AppColors.greenBg,
                text: 'Paper Passes!',
                onTap: () {
                  Get.toNamed(AppRoutes.paperPass);
                },
              ))
            ],
          )
        ],
      ),
    );
  }
}
