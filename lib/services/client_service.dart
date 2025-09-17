import 'dart:convert';
import 'package:jendela_informatika/models/client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ClientService {
  static const String _clientKey = 'client_data';

  // Simpan data client
  static Future<void> saveClient(ClientModel client) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonClient = jsonEncode(client.toMap());
    await prefs.setString(_clientKey, jsonClient);
  }

  // Ambil data client
  static Future<ClientModel?> getClient() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonClient = prefs.getString(_clientKey);
    if (jsonClient != null) {
      Map<String, dynamic> map = jsonDecode(jsonClient);
      return ClientModel.fromMap(map);
    }
    return null;
  }

  // Hapus data client
  static Future<void> clearClient() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_clientKey);
  }
}
