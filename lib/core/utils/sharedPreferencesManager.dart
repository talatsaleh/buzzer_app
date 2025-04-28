
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();
  SharedPreferences? _preferences;

  SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save String
  Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Get String
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Save Boolean
  Future<void> saveBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Get Boolean
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Save Integer
  Future<void> saveInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Get Integer
  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // Save Double
  Future<void> saveDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  // Get Double
  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  // Save List of Strings
  Future<void> saveStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  // Get List of Strings
  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  // Remove Key
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear All
  Future<void> clear() async {
    await _preferences?.clear();
  }
}
