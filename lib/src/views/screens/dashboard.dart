import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goa/src/views/screens/routes_screen/route_listing.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _selectedIndex = 2.obs;
  @override
  Widget build(BuildContext context) {
    TextTheme _theme = Theme.of(context).textTheme;
    return Scaffold(
      body: RouteListingScreen(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          selectedIconTheme:
              const IconThemeData(color: Colors.black87, size: 40),
          unselectedItemColor: Colors.black54,
          currentIndex: _selectedIndex.value,
          onTap: _onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "Shopping Cart"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: "History"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: "Settings"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outlined,
                ),
                label: "Info"),
          ],
        ),
      ),
    );
  }

  void _onItemTap(int index) {
    _selectedIndex.value = index;
  }
}
