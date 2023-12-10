import 'package:boycott_hub/features/theme_mode/services/theme_mode_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/*final _currentThemeState = FutureProvider<ThemeMode>((ref) async {
  final getIt = ref.watch(mainGetItProvider);
  return await getIt.get<ThemeModeService>().getThemeMode();
});*/

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final ThemeModeService themeModeService;
  ThemeMode currentThemeMode;

  ThemeModeNotifier({required this.themeModeService, required this.currentThemeMode}) : super(currentThemeMode) {
    getCurrentTheme();
  }

  Future<bool> setDark() async {
    if (state != ThemeMode.dark) {
      state = ThemeMode.dark;
    }

    return await themeModeService.setThemeMode(ThemeMode.dark);
  }

  Future<bool> setLight() async {
    if (state != ThemeMode.light) {
      state = ThemeMode.light;
    }

    return await themeModeService.setThemeMode(ThemeMode.light);
  }

  Future<bool> setSystem() async {
    if (state != ThemeMode.system) {
      state = ThemeMode.system;
    }

    return await themeModeService.setThemeMode(ThemeMode.system);
  }

  void getCurrentTheme() async {
    final theme = themeModeService.getThemeMode();
    state = theme;
  }
}
