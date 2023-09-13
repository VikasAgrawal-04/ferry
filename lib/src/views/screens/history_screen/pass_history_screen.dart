import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utils/helpers/helpers.dart';

class PassHistoryScreen extends StatefulWidget {
  const PassHistoryScreen({super.key});

  @override
  State<PassHistoryScreen> createState() => _PassHistoryScreenState();
}

class _PassHistoryScreenState extends State<PassHistoryScreen> {
  final routeController = Get.find<RouteController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await routeController.purchaseHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          SizedBox(
              height: 40.h,
              child: Image.asset(
                'assets/images/main4.PNG',
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              )),
          Text("Purchase History", style: theme.displayLarge),
          Divider(indent: 5.h, endIndent: 5.h),
          Obx(() => SizedBox(
            height: 37.h,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: routeController.passesHistory.length,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemBuilder: (context, index) {
                  final data = routeController.passesHistory[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(Helpers.formattedDate(data.buyDate),
                              style: theme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.routename,
                                    style: theme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600)),
                                Text("${data.vehicleType} Wheeler",
                                    style: theme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600)),
                                Text(
                                    data.passDays == 30
                                        ? "Monthly Pass"
                                        : "Weekly Pass",
                                    style: theme.bodyMedium),
                                Text("Rs ${data.cost}", style: theme.bodyMedium)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
