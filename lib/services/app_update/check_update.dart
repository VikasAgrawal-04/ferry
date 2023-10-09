// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';

Future<void> checkForUpdate(BuildContext context) async {
  final newVersion = NewVersionPlus(
      androidId: 'com.example.ferry', androidPlayStoreCountry: "es_ES");

  final status = await newVersion.getVersionStatus();
  if (status != null) {
    if (status.canUpdate) {
      return newVersion.showUpdateDialog(
        context: context,
        launchModeVersion: LaunchModeVersion.external,
        versionStatus: status,
        allowDismissal: false,
      );
    }
  }
}
