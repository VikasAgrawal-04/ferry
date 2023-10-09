import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/api_controller/route_controller.dart';

class ScanPaperPass extends StatefulWidget {
  const ScanPaperPass({super.key});

  @override
  State<ScanPaperPass> createState() => _PaperScanPaperPass();
}

class _PaperScanPaperPass extends State<ScanPaperPass> {
  final routeController = Get.find<RouteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AiBarcodeScanner(
        canPop: false,
        controller: MobileScannerController(detectionTimeoutMs: 1000),
        onScan: (String value) async {
          await routeController.checkPaperPass(paperPass: value);
          Get.back();
        },
      )),
    );
  }
}
