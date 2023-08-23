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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await routeController.getYourPasses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Your Passes', style: theme.displayMedium),
      ),
      body: Column(
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
                                              .yourPasses[_selectedPass.value]
                                              .routename,
                                          style: theme.bodyMedium,
                                          textAlign: TextAlign.center),
                                    ),
                                    Helpers.imgFromBase64(routeController
                                        .yourPasses[_selectedPass.value]
                                        .routeImg),
                                    SizedBox(
                                      height: 12.h,
                                      child: SfBarcodeGenerator(
                                          symbology: Codabar(),
                                          value: routeController
                                              .yourPasses[_selectedPass.value]
                                              .passcode),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "Valid Till : ${Helpers.formattedDate(routeController.yourPasses[_selectedPass.value].validTillDate)}"),
                                    )
                                  ]),
                            ),
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
                                        child: Text(data.routename,
                                            style: theme.bodyMedium?.copyWith(
                                                color:
                                                    _selectedPass.value == index
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
    );
  }
}
