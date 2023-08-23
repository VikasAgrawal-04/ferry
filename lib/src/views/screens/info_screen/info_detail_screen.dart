import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:goa/src/models/info/app_info_model.dart';

class InfoDetailScreen extends StatefulWidget {
  const InfoDetailScreen({super.key});

  @override
  State<InfoDetailScreen> createState() => _InfoDetailScreenState();
}

class _InfoDetailScreenState extends State<InfoDetailScreen> {
  final AppInfoDatum data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Html(data: data.description));
  }
}
