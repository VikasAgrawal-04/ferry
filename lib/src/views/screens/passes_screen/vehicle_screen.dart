import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/services/routing_services/routes.dart';
import 'package:goa/src/controllers/route_controller.dart';
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
        title: Text('Buy Pass : ${data.routename}', style: theme.displayMedium),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vehicle(
                  name: '4 Wheeler',
                  img: 'assets/images/4_wheeler.PNG',
                  onTap: () async {
                    await api(routeId: data.routeid, vehicleType: "4");
                  }),
              SizedBox(height: 4.h),
              vehicle(
                  name: '2 Wheeler',
                  img: 'assets/images/2_wheeler.PNG',
                  onTap: () async {
                    await api(routeId: data.routeid, vehicleType: "2");
                  })
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
      Get.toNamed(AppRoutes.passDetails,
          arguments: "${data.routename} : $vehicleType Wheeler");
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
            Image.asset(img),
            SizedBox(height: 1.h),
            Text(name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
