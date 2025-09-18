import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  static const String _usernameKey = 'admin_username';
  static const String _passwordKey = 'admin_password';

  /// Simpan default username & password admin jika belum ada
  static Future<void> saveDefaultAdmin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(_usernameKey) || !prefs.containsKey(_passwordKey)) {
      await prefs.setString(_usernameKey, 'admin'); // default username
      await prefs.setString(_passwordKey, '1234');  // default password
    }
  }

  /// Ambil username & password admin
  static Future<Map<String, String>> getAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(_usernameKey) ?? 'admin';
    String password = prefs.getString(_passwordKey) ?? '1234';

    return {
      'username': username,
      'password': password,
    };
  }

  /// Update username & password admin jika mau diganti
  static Future<void> updateAdmin(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
  }
}
