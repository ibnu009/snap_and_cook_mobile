import 'package:shared_preferences/shared_preferences.dart';

class Session {
  
  static Future<bool> set(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }
  static Future<String?> get(String key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }
  static Future<bool> remove(String key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}