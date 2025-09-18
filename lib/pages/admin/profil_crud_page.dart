import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jendela_informatika/models/profil_model.dart';
import 'package:jendela_informatika/services/profil_service.dart';
import 'package:uuid/uuid.dart';

class ProfilCrudPage extends StatefulWidget {
  const ProfilCrudPage({super.key});

  @override
  State<ProfilCrudPage> createState() => _ProfilCrudPageState();
}

class _ProfilCrudPageState extends State<ProfilCrudPage> {
  final ProfilService _service = ProfilService();
  List<ProfilModel> _profilList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _service.ambilSemua();
    setState(() {
      _profilList = data;
    });
  }

  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path; // path lokal file gambar
    }
    return null;
  }

  void _showForm({ProfilModel? profil}) {
  final namaController = TextEditingController(text: profil?.nama ?? '');
  final deskripsiController = TextEditingController(text: profil?.deskripsi ?? '');
  final gelarController = TextEditingController(text: profil?.gelar ?? '');
  final statusController = TextEditingController(text: profil?.status ?? '');
  String fotoProfilPath = profil?.fotoProfil ?? ''; // path foto

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(profil == null ? 'Tambah Profil' : 'Edit Profil'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // preview foto profil
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: fotoProfilPath.isNotEmpty
                        ? FileImage(File(fotoProfilPath))
                        : null,
                    child: fotoProfilPath.isEmpty
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final path = await _pickImage();
                      if (path != null) {
                        setStateDialog(() {
                          fotoProfilPath = path;
                        });
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Pilih Foto Profil'),
                  ),
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                  ),
                  TextField(
                    controller: gelarController,
                    decoration: const InputDecoration(labelText: 'Gelar'),
                  ),
                  TextField(
                    controller: statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                  TextField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final id = profil?.id ?? const Uuid().v4();
                  final newProfil = ProfilModel(
                    id: id,
                    nama: namaController.text,
                    deskripsi: deskripsiController.text,
                    fotoProfil: fotoProfilPath,
                    gelar: gelarController.text,
                    status: statusController.text,
                  );
                  if (profil == null) {
                    await _service.tambahProfil(newProfil);
                  } else {
                    await _service.editProfil(profil.id, newProfil);
                  }
                  Navigator.pop(context);
                  _loadData();
                },
                child: const Text('Simpan'),
              ),
            ],
          );
        },
      );
    },
  );
}


  Future<void> _hapusProfil(String id) async {
    await _service.hapusProfil(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _profilList.length,
        itemBuilder: (context, index) {
          final profil = _profilList[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: profil.fotoProfil.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(profil.fotoProfil),
                    )
                  : const CircleAvatar(child: Icon(Icons.person)),
              title: Text('${profil.nama} (${profil.gelar})'),
              subtitle: Text('${profil.status}\n${profil.deskripsi}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _showForm(profil: profil),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _hapusProfil(profil.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
