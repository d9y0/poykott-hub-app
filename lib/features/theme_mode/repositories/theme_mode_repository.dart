import 'package:boycott_hub/features/shared_prefs_storage/repositories/shared_prefs_storage_repository.dart';

class ThemeModeRepository {
  final SharedPrefsStorageRepository sharedPrefsStorageRepository;

  ThemeModeRepository({required this.sharedPrefsStorageRepository});
  Future<void> init() async {}
  int? getThemeMode() {
    return sharedPrefsStorageRepository.getInt("themeMode");
  }

  Future<bool> setThemeMode(int mode) async {
    return await sharedPrefsStorageRepository.setInt("themeMode", mode);
  }
}
