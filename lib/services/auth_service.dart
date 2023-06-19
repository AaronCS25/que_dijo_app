import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'token';
  static const _userIdKey = 'user_id';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: _tokenKey);
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> hasToken() async {
    String token = await getToken();
    return token != '';
  }

  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  static Future<String> getUserId() async {
    const storage = FlutterSecureStorage();
    final userId = await storage.read(key: _userIdKey);
    return userId ?? '';
  }

  static Future<void> deleteUserId() async {
    await _storage.delete(key: _userIdKey);
  }

  static Future<bool> hasUserId() async {
    String userId = await getUserId();
    return userId != '';
  }
}