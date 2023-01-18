import 'package:shared_preferences/shared_preferences.dart';

import '../models/base_model.dart';

class AppPreference extends BaseModel {
  static SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static set(String key, dynamic value) async {
    if (value is String) {
      await prefs!.setString(key, value);
    } else if (value is int) {
      await prefs!.setInt(key, value);
    } else if (value is bool) {
      await prefs!.setBool(key, value);
    } else if (value is double) {
      await prefs!.setDouble(key, value);
    }
  }

 static setCoinName(String key, dynamic value) async {
    if (value is String) {
      await prefs!.setString(key, value);
    }
  }

  static getString(String key) {
    return prefs?.getString(key);
  }

  static getInt(String key) {
    return prefs!.getInt(key) ?? 0;
  }

  static getDouble(String key) {
    return prefs!.getDouble(key);
  }


  static getBool(String key) {
    return prefs!.getBool(key) ?? false;
  }

  static remove(String key) {
    prefs!.remove(key);
  }

  static clear() async {
    await prefs!.clear();
  }
}
