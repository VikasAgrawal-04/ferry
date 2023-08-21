import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  final String routeName = Get.arguments;
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(title: Text(routeName, style: theme.displayMedium)));
  }
}
