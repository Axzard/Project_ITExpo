import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jendela_informatika/services/client_service.dart';
import 'package:jendela_informatika/models/client_model.dart';

class AdminBeritaAcaraPage extends StatefulWidget {
  const AdminBeritaAcaraPage({super.key});

  @override
  State<AdminBeritaAcaraPage> createState() => _AdminBeritaAcaraPageState();
}

class _AdminBeritaAcaraPageState extends State<AdminBeritaAcaraPage> {
  List<ClientModel> clients = [];

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    final data = await ClientService.getClients();
    setState(() {
      clients = data;
    });
  }

  Future<void> _deleteClient(int index) async {
    // konfirmasi sebelum hapus
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text('Yakin ingin menghapus berita acara ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
        ],
      ),
    );

    if (confirm == true) {
      await ClientService.deleteClientAt(index);
      _loadClients();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Berita Acara')),
      body: clients.isEmpty
          ? const Center(child: Text('Belum ada data berita acara'))
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final c = clients[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(c.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pekerjaan: ${c.pekerjaan}'),
                        Text('Umur: ${c.umur}'),
                        Text('Alamat: ${c.alamat}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const FaIcon(FontAwesomeIcons.trash, color: Colors.red),
                      onPressed: () => _deleteClient(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
