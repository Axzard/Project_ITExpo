import 'dart:convert';
import 'package:jendela_informatika/models/dosen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenService {
  static const String _key = 'profil_list'; // gunakan 1 key saja

  /// Simpan semua dosen ke SharedPreferences
  Future<void> simpanSemua(List<DosenModel> profilList) async {
    final prefs = await SharedPreferences.getInstance();
    // ubah semua ke List<String>
    final List<String> encodedList = profilList
        .map((e) => jsonEncode(e.toMap()))
        .toList();
    await prefs.setStringList(_key, encodedList);
  }

  /// Tambah profil dosen baru
  Future<void> tambahProfil(DosenModel profil) async {
    final list = await ambilSemua();
    list.add(profil);
    await simpanSemua(list);
  }

  /// Ambil semua dosen
  Future<List<DosenModel>> ambilSemua() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList = prefs.getStringList(_key) ?? [];
    return dataList
        .map((item) => DosenModel.fromMap(jsonDecode(item)))
        .toList();
  }

  /// Edit profil dosen berdasarkan ID
  Future<void> editProfil(String id, DosenModel profilBaru) async {
    final list = await ambilSemua();
    final index = list.indexWhere((p) => p.id == id);
    if (index != -1) {
      list[index] = profilBaru;
      await simpanSemua(list);
    }
  }

  /// Hapus profil dosen berdasarkan ID
  Future<void> hapusProfil(String id) async {
    final list = await ambilSemua();
    list.removeWhere((p) => p.id == id);
    await simpanSemua(list);
  }
}
