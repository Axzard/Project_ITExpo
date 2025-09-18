import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profil_informatika_model.dart';

class ProfilInformatikaService {
  static const String _key = 'profil_informatika';

  // simpan data
  static Future<void> simpanProfil(ProfilInformatikaModel profil) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(profil.toMap());
    await prefs.setString(_key, jsonStr);
  }

  // ambil data
  static Future<ProfilInformatikaModel?> ambilProfil() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return null;

    final Map<String, dynamic> map = jsonDecode(jsonStr);
    return ProfilInformatikaModel.fromMap(map);
  }

  // hapus data
  static Future<void> hapusProfil() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
