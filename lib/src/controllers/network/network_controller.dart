import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class NetworkController extends GetxController {
  final _connectionStatus = Rx<ConnectivityResult>(ConnectivityResult.none);
  final localDirectory = Directory('').obs;

  Stream<ConnectivityResult> get connectionStatusStream =>
      _connectionStatus.stream;

  @override
  void onInit() {
    super.onInit();
    fetchLocal();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus.value = result;
    });
  }

  Future<void> fetchLocal() async {
    localDirectory.value = await getApplicationDocumentsDirectory();
  }

  ConnectivityResult get connectionStatus => _connectionStatus.value;
  bool get isOnline => _connectionStatus.value != ConnectivityResult.none;
}
