import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final RouteDatum data = Get.arguments;
  final routeController = Get.find<RouteController>();
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Text('Buy Pass : ${data.routename}', style: theme.displayMedium),
          Text("Select Vehicle Type",
              textAlign: TextAlign.center, style: theme.bodySmall)
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: vehicle(
                        name: '4 Wheeler',
                        img: 'assets/images/4_wheeler.PNG',
                        onTap: () async {
                          await api(routeId: data.routeid, vehicleType: "4");
                        }),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: vehicle(
                        name: '2 Wheeler',
                        img: 'assets/images/2_wheeler.PNG',
                        onTap: () async {
                          await api(routeId: data.routeid, vehicleType: "2");
                        }),
                  )
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: vehicle(
                        name: 'Medium Vehicle',
                        img: 'assets/images/Medium.PNG',
                        onTap: () async {
                          await api(routeId: data.routeid, vehicleType: "6");
                        }),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: vehicle(
                        name: 'Heavy Vehicle',
                        img: 'assets/images/heavy.PNG',
                        onTap: () async {
                          await api(routeId: data.routeid, vehicleType: "8");
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> api({required int routeId, required String vehicleType}) async {
    bool result = await routeController.getRoutePasses(
        routeId: routeId, vehicleType: vehicleType);
    if (result) {
      final type = vehicleType == '6'
          ? 'Medium'
          : vehicleType == '8'
              ? 'Heavy'
              : "$vehicleType Wheeler";
      Get.toNamed(AppRoutes.passDetails,
          arguments: "${data.routename} : $type");
    }
  }

  Widget vehicle(
      {required String name, required String img, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
              height: 20.h,
              child: Image.asset(
                img,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              ),
            ),
            SizedBox(height: 1.h),
            Text(name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
