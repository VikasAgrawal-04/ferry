// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:new_version_plus/new_version_plus.dart';

Future<void> checkForUpdate(BuildContext context) async {
  final newVersion = NewVersionPlus(
      androidId: 'com.codanto.goaferryapp', androidPlayStoreCountry: "es_ES");

  final status = await newVersion.getVersionStatus();
  if (status != null) {
    if (status.canUpdate) {
      final difference =
          Helpers.subtractVersion(status.storeVersion, status.localVersion);

      final majorUpdate = Helpers.isVersionGreater(difference, '0.1.0');
      if (majorUpdate) {
        return newVersion.showUpdateDialog(
          dialogText: 'Good News! A new version of Ferry is available. ',
          context: context,
          launchModeVersion: LaunchModeVersion.external,
          versionStatus: status,
          allowDismissal: false,
        );
      } else {
        return newVersion.showUpdateDialog(
          dialogText: 'Good News! A new version of Ferry is available. ',
          context: context,
          launchModeVersion: LaunchModeVersion.external,
          versionStatus: status,
          allowDismissal: true,
        );
      }
    }
  }
}
