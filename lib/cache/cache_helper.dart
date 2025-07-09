import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  /// Initialize shared preferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save data with dynamic type
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }
    return false;
  }

  /// Get saved data
  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);

  }

  static String? getString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  /// Remove specific key
  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  /// Clear all data
  static Future<bool> clearAllData() async {
    return await _sharedPreferences.clear();
  }

  /// Check if a key exists
  static bool containsKey({required String key}) {
    return _sharedPreferences.containsKey(key);
  }
}
