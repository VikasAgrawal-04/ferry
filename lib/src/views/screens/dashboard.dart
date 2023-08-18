import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/core/utils/constants/colors.dart';
import 'package:goa/src/views/screens/routes_screen/route_listing.dart';
import 'package:sizer/sizer.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _selectedIndex = 2.obs;
  final List<String> labels = [
    "Shopping Cart",
    "History",
    "Home",
    "Settings",
    "Info"
  ];
  final List<IconData> icons = [
    Icons.shopping_cart,
    Icons.history,
    Icons.home,
    Icons.settings,
    Icons.info_outlined,
  ];
  @override
  Widget build(BuildContext context) {
    TextTheme _theme = Theme.of(context).textTheme;
    return Scaffold(
      body: RouteListingScreen(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue,
            iconSize: 30,
            selectedIconTheme: const IconThemeData(color: Colors.black87),
            unselectedItemColor: Colors.black54,
            currentIndex: _selectedIndex.value,
            onTap: _onItemTap,
            items: List.generate(labels.length, (index) {
              final label = labels[index];
              final icon = icons[index];
              return BottomNavigationBarItem(
                label: label,
                icon: Container(
                  padding: EdgeInsets.all(1.h),
                  decoration: index == _selectedIndex.value
                      ? BoxDecoration(
                          color: AppColors.btnYellow,
                          borderRadius: BorderRadius.circular(100),
                        )
                      : null,
                  child: Icon(
                    icon,
                    color: index == _selectedIndex.value
                        ? Colors.white
                        : AppColors.appBarIcon,
                  ),
                ),
              );
            })),
      ),
    );
  }

  void _onItemTap(int index) {
    _selectedIndex.value = index;
  }
}
