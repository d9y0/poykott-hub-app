import 'dart:developer';

import 'package:boycott_hub/features/app_prefix/app_prefix_provider.dart';
import 'package:boycott_hub/features/shared_prefs_storage/repositories/shared_prefs_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

final sharedPrefsStorageRepository = Provider<SharedPrefsStorageRepository>(
  (ref) {
    return SharedPrefsStorageRepository(
      ref.watch(prefProvider),
      prefix: ref.watch(appPrefix),
    );
  },
  dependencies: [appPrefix],
);

class SharedPrefsStorageProviderManage {
  static Future<Override> overrideSharedPrefsStorage() async {
    final pref = await SharedPreferences.getInstance();

    return prefProvider.overrideWith((ref) => pref);
  }
}
