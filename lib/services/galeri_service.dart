import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/galeri_model.dart';

class GaleriService {
  static const String key = 'galeri_list';

  static Future<List<GaleriModel>> loadGaleri() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null) {
      final List decoded = json.decode(data);
      return decoded.map((e) => GaleriModel.fromMap(e)).toList();
    }
    return [];
  }

  static Future<void> saveGaleri(List<GaleriModel> galeriList) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        json.encode(galeriList.map((e) => e.toMap()).toList());
    await prefs.setString(key, encoded);
  }
}
