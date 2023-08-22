import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/route_controller.dart';
import 'package:goa/src/core/utils/constants/colors.dart';
import 'package:goa/src/views/widgets/button/custom_button.dart';
import 'package:goa/src/views/widgets/card/white_box_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class YourPassScreen extends StatefulWidget {
  const YourPassScreen({super.key});

  @override
  State<YourPassScreen> createState() => _YourPassScreenState();
}

class _YourPassScreenState extends State<YourPassScreen> {
  final routeController = Get.find<RouteController>();

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
                    : ListView.builder(
                        itemCount: routeController.yourPasses.length,
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 4.w),
                        itemBuilder: (context, index) {
                          return WhiteBoxCard(children: []);
                        }),
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
