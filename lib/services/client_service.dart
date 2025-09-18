// lib/services/client_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jendela_informatika/models/client_model.dart';

class ClientService {
  static const String _clientsKey = 'clients';

  /// Simpan satu client baru
  static Future<void> saveClient(ClientModel client) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> clientList = prefs.getStringList(_clientsKey) ?? [];

    String clientJson = jsonEncode(client.toMap());
    clientList.add(clientJson);

    await prefs.setStringList(_clientsKey, clientList);
  }

  /// Ambil semua client
  static Future<List<ClientModel>> getClients() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> clientList = prefs.getStringList(_clientsKey) ?? [];

    return clientList.map((e) {
      Map<String, dynamic> map = jsonDecode(e);
      return ClientModel.fromMap(map);
    }).toList();
  }

  /// Hapus semua client (opsional)
  static Future<void> clearClients() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_clientsKey);
  }
}
