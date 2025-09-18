import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profil_model.dart';

class ProfilService {
  static const String _key = 'profil_data';

  Future<void> simpanSemua(List<ProfilModel> profilList) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(
      profilList.map((e) => e.toMap()).toList(),
    );
    await prefs.setString(_key, encoded);
  }

  Future<void> tambahProfil(ProfilModel profil) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList('profil_list') ?? [];
    dataList.add(jsonEncode(profil.toMap()));
    await prefs.setStringList('profil_list', dataList);
  }

  Future<List<ProfilModel>> ambilSemua() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList('profil_list') ?? [];
    return dataList
        .map((item) => ProfilModel.fromMap(jsonDecode(item)))
        .toList();
  }

  Future<void> editProfil(String id, ProfilModel profilBaru) async {
    final list = await ambilSemua();
    final index = list.indexWhere((p) => p.id == id);
    if (index != -1) {
      list[index] = profilBaru;
      await simpanSemua(list);
    }
  }

  Future<void> hapusProfil(String id) async {
    final list = await ambilSemua();
    list.removeWhere((p) => p.id == id);
    await simpanSemua(list);
  }
}
