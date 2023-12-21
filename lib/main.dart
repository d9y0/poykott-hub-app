import 'dart:developer';

import 'package:boycott_hub/app/boycott_all_in_one.dart';

import 'package:boycott_hub/features/app_prefix/app_prefix_provider.dart';
import 'package:boycott_hub/features/config/presentation/config_providers.dart';
import 'package:boycott_hub/features/connectivity/connectivity_providers.dart';
import 'package:boycott_hub/features/path_provider/path_provider.dart';

import 'package:boycott_hub/features/shared_prefs_storage/shared_prefs_storage_providers.dart';

import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;*/
//configFutureProvider
  final List<Override> overrides = [
    appPrefix.overrideWith((ref) => ''),
    await SharedPrefsStorageProviderManage.overrideSharedPrefsStorage(),
    ...(await ConnectivityProviders.overrideConnectivityProviders()),
    PathProvider.tempDirProvider.overrideWith(await PathProvider.tempDirProviderRefFn()),
  ];

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return ProviderScope(
          overrides: overrides,
          child: const BoycottAllInOne(),
        );
      },
    ),
  );
}
