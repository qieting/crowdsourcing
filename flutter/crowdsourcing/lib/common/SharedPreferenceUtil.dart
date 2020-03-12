import 'package:shared_preferences/shared_preferences.dart';


/// desc：本地储存
class SharedPreferenceUtil {
  static const String KEY_Theme = "account";

  // 异步保存
  static Future save(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  // 异步读取
  static Future<String> get(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}

