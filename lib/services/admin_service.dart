import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  static const String _usernameKey = 'admin_username';
  static const String _passwordKey = 'admin_password';
  static const String ratingsKey = 'ratings';
  static const String beritaKey = 'berita_acara';


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


  /// Tambahkan rating baru (nama, nilai, komentar)
  static Future<void> addRating(Map<String, dynamic> rating) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ratings = prefs.getStringList(ratingsKey) ?? [];
    ratings.add(jsonEncode(rating));
    await prefs.setStringList(ratingsKey, ratings);
  }

  /// Ambil semua rating
  static Future<List<Map<String, dynamic>>> getRatings() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ratings = prefs.getStringList(ratingsKey) ?? [];
    return ratings.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  /// Tambahkan berita acara
  static Future<void> addBerita(Map<String, dynamic> berita) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> beritaList = prefs.getStringList(beritaKey) ?? [];
    beritaList.add(jsonEncode(berita));
    await prefs.setStringList(beritaKey, beritaList);
  }

  /// Ambil semua berita acara
  static Future<List<Map<String, dynamic>>> getBerita() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> beritaList = prefs.getStringList(beritaKey) ?? [];
    return beritaList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }
}

