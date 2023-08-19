import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/route_controller.dart';
import 'package:goa/src/views/widgets/textfield/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class RouteListingScreen extends StatefulWidget {
  const RouteListingScreen({super.key});

  @override
  State<RouteListingScreen> createState() => _RouteListingScreenState();
}

class _RouteListingScreenState extends State<RouteListingScreen> {
  final searchController = TextEditingController();
  final routeController = Get.find<RouteController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await routeController.fetchRoutes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _theme = Theme.of(context).textTheme;
    final controller = Get.find<RouteController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 12.5.h),
        child: AppBar(
          toolbarHeight: 4.h,
          centerTitle: true,
          title: Text('Buy Pass', style: _theme.displayMedium),
          flexibleSpace: Padding(
            padding:
                EdgeInsets.only(top: 10.h, left: 4.w, right: 4.w, bottom: 1.h),
            child: CustomTextFieldNew(
                control: searchController,
                isRequired: false,
                icon: Icons.search,
                hint: 'Search',
                keyboardType: TextInputType.text,
                isNumber: false,
                textInputAction: TextInputAction.search),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.routesName.length,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
            itemBuilder: (context, index) {
              final data = controller.routesName[index];
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {},
                child: Card(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                      child: Text(data.routename, textAlign: TextAlign.center)),
                ),
              );
            }),
      ),
    );
  }
}
