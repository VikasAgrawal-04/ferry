import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  final String routeName = Get.arguments;
  final routeController = Get.find<RouteController>();
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(routeName, style: theme.displayMedium)),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(routeController.passes.length, (index) {
              final data = routeController.passes[index];
              final img = routeController.passesImg[index];
              return pass(
                  name: data.passname,
                  img: img,
                  onTap: () async {
                    await routeController.createPass(passId: data.passid);
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
