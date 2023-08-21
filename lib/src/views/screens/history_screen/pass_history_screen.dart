import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PassHistoryScreen extends StatelessWidget {
  const PassHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Image.asset('assets/images/main4.PNG'),
          Text("Purchase History", style: theme.displayLarge),
          Divider(indent: 5.h, endIndent: 5.h)
        ],
      ),
    );
  }
}
