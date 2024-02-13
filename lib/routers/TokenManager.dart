import 'package:shared_preferences/shared_preferences.dart';
//暂时不用
class TokenManager {
  static bool _tokenKey = false; // 修改_tokenKey的类型为bool

  static Future<void> saveToken(bool token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('user_token', token); // 使用setBool()方法来储存bool类型的值
  }

  static Future<bool?> getToken() async { // 修改返回类型为bool?
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('user_token'); // 使用getBool()方法来获取bool类型的值
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token'); // 移除bool类型的值
  }

  // 新增修改_tokenKey方法
  static void modifyTokenKey(bool newTokenValue) {
    _tokenKey = newTokenValue;
  }
}
