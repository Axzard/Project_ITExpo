import 'dart:convert';
import 'package:jendela_informatika/models/dosen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DosenService {
  static const String _key = 'profil_data';

  Future<void> simpanSemua(List<DosenModel> profilList) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(
      profilList.map((e) => e.toMap()).toList(),
    );
    await prefs.setString(_key, encoded);
  }

  Future<void> tambahProfil(DosenModel profil) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList('profil_list') ?? [];
    dataList.add(jsonEncode(profil.toMap()));
    await prefs.setStringList('profil_list', dataList);
  }

  Future<List<DosenModel>> ambilSemua() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList('profil_list') ?? [];
    return dataList
        .map((item) => DosenModel.fromMap(jsonDecode(item)))
        .toList();
  }

  Future<void> editProfil(String id, DosenModel profilBaru) async {
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
