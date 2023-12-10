//ThemeModeRepository
//ThemeService

import 'package:boycott_hub/features/shared_prefs_storage/shared_prefs_storage_providers.dart';
import 'package:boycott_hub/features/theme_mode/repositories/theme_mode_repository.dart';
import 'package:boycott_hub/features/theme_mode/services/theme_mode_service.dart';
import 'package:boycott_hub/features/theme_mode/states/theme_mode_notifier.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeRepository = Provider<ThemeModeRepository>(
  (ref) => ThemeModeRepository(sharedPrefsStorageRepository: ref.watch(sharedPrefsStorageRepository)),
  dependencies: [sharedPrefsStorageRepository],
);
final themeModeService = Provider<ThemeModeService>(
  (ref) => ThemeModeService(themeModeRepository: ref.watch(themeModeRepository)),
  dependencies: [themeModeRepository],
);

final themeModeNotifier = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) {
    final themeModeService0 = ref.watch(themeModeService);
    return ThemeModeNotifier(themeModeService: themeModeService0, currentThemeMode: themeModeService0.getThemeMode());
  },
  dependencies: [themeModeService],
);
