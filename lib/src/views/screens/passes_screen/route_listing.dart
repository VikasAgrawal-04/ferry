import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:goa/src/controllers/api_controller/route_controller.dart';
import 'package:goa/src/views/widgets/textfield/custom_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../services/routing_services/routes.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../models/routes/routes_info_model.dart';

class RouteListingScreen extends StatefulWidget {
  const RouteListingScreen({super.key});

  @override
  State<RouteListingScreen> createState() => _RouteListingScreenState();
}

class _RouteListingScreenState extends State<RouteListingScreen> {
  final searchController = TextEditingController();
  final routeController = Get.find<RouteController>();
  final filteredList = <RouteDatum>[].obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await routeController.fetchRoutes();
      if (routeController.routesName.isNotEmpty) {
        filteredList.addAll(routeController.routesName);
      }
    });
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList.clear();
      filteredList.addAll(routeController.routesName);
    } else {
      filteredList.clear();
      for (var item in routeController.routesName) {
        if (item.routename.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(item);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 12.5.h),
        child: AppBar(
          toolbarHeight: 4.h,
          centerTitle: true,
          title: Text('Buy Pass', style: theme.displayMedium),
          flexibleSpace: Padding(
            padding:
                EdgeInsets.only(top: 10.h, left: 4.w, right: 4.w, bottom: 1.h),
            child: CustomTextFieldNew(
                control: searchController,
                onChanged: (value) {
                  filterList(value);
                },
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
            itemCount: filteredList.length,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
            itemBuilder: (context, index) {
              final data = filteredList[index];
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  EasyLoading.show();
                  Get.toNamed(AppRoutes.vehicleListing, arguments: data);
                },
                child: Card(
                  color: AppColors.greenBg,
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                      child: Text(data.routename,
                          textAlign: TextAlign.center,
                          style: theme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white))),
                ),
              );
            }),
      ),
   
    );
  }
}
