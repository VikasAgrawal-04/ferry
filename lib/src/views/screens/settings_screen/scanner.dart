import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/api_controller/route_controller.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final routeController = Get.find<RouteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AiBarcodeScanner(
        canPop: false,
        controller: MobileScannerController(detectionTimeoutMs: 1000),
        onScan: (String value) async {
          await routeController.importPass(transferCode: value);
          Get.back();
        },
      )),
    );
  }
}
