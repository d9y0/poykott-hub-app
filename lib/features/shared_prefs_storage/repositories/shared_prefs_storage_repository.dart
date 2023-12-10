import 'package:shared_preferences/shared_preferences.dart';

class UnsuportedType {
  final List<String> suportedList;

  UnsuportedType(this.suportedList);
}

abstract class SharedPrefsStorageRepositoryImplementation {
  final String prefix;

  SharedPrefsStorageRepositoryImplementation({this.prefix = ''});
  Future<bool> remove(String key);
  String? getString(String key);
  bool? getBool(String key);
  int? getInt(String key);
  double? getDouble(String key);
  List<String>? getStringList(String key);
  Future<bool> setString(String key, String value);
  Future<bool> setBool(String key, bool value);
  Future<bool> setInt(String key, int value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setStringList(String key, List<String> value);
  Future<void> clear();

  bool has(String key);
}

class SharedPrefsStorageRepository implements SharedPrefsStorageRepositoryImplementation {
  final String prefix;
  final SharedPreferences pref;
  SharedPrefsStorageRepository(this.pref, {this.prefix = ''});

  //Future<SharedPreferences> get _pref => GetIt.I.getAsync<SharedPreferences>();

  String fixKey(String key) {
    return "${prefix}_${key}";
  }

  @override
  Future<void> clear() async {
    pref.clear();
  }

  @override
  String? getString(String key) {
    final key0 = fixKey(key);

    return pref.getString(key0);
  }

  @override
  bool? getBool(String key) {
    final key0 = fixKey(key);

    return pref.getBool(key0);
  }

  @override
  int? getInt(String key) {
    final key0 = fixKey(key);

    return pref.getInt(key0);
  }

  @override
  double? getDouble(String key) {
    final key0 = fixKey(key);

    return pref.getDouble(key0);
  }

  @override
  List<String>? getStringList(String key) {
    final key0 = fixKey(key);

    return pref.getStringList(key0);
  }

  @override
  bool has(String key) {
    final key0 = fixKey(key);

    return pref.containsKey(key0);
  }

  @override
  Future<bool> remove(String key) async {
    final key0 = fixKey(key);

    return pref.remove(key0);
  }

  @override
  Future<bool> setString(String key, String value) async {
    final key0 = fixKey(key);

    return pref.setString(key0, value);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    final key0 = fixKey(key);

    return pref.setBool(key0, value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    final key0 = fixKey(key);

    return pref.setInt(key0, value);
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    final key0 = fixKey(key);

    return pref.setDouble(key0, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    final key0 = fixKey(key);

    return pref.setStringList(key0, value);
  }
}
