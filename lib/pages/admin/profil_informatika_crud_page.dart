import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jendela_informatika/models/profil_informatika_model.dart';
import 'package:jendela_informatika/services/profil_informatika_service.dart';
import 'widgets/profil_informatika_card.dart';

class ProfilInformatikaCrudPage extends StatefulWidget {
  const ProfilInformatikaCrudPage({super.key});

  @override
  State<ProfilInformatikaCrudPage> createState() =>
      _ProfilInformatikaCrudPageState();
}

class _ProfilInformatikaCrudPageState extends State<ProfilInformatikaCrudPage> {
  ProfilInformatikaModel? _profil; // hanya satu data

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await ProfilInformatikaService.ambilProfil();
    setState(() {
      _profil = data;
    });
  }

  Future<void> _hapusProfil() async {
    await ProfilInformatikaService.hapusProfil();
    setState(() {
      _profil = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data profil dihapus')),
    );
  }

  void _showForm({ProfilInformatikaModel? profil}) {
  final visiController = TextEditingController(text: profil?.visi ?? '');
  final misiController = TextEditingController(text: profil?.misi ?? '');
  String fotoPath = profil?.imagePath ?? '';

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
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setStateDialog(() {
                          fotoPath = pickedFile.path;
                        });
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 250,
                      child: fotoPath.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(fotoPath),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Icon(Icons.add_a_photo, size: 50),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: visiController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Visi'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: misiController,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'Misi'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal',
                    style: TextStyle(color: Colors.blue)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  final newProfil = ProfilInformatikaModel(
                    imagePath: fotoPath,
                    visi: visiController.text,
                    misi: misiController.text,
                  );
                  await ProfilInformatikaService.simpanProfil(newProfil);
                  Navigator.pop(context);
                  _loadData();
                },
                child: const Text('Simpan',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: _profil == null
            ? const Center(
                child: Text(
                  'Belum ada data Profil Informatika',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ProfilInformatikaCard(
                profil: _profil!,
                onEdit: () => _showForm(profil: _profil),
                onDelete: _hapusProfil,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(profil: _profil),
        backgroundColor: Colors.blue,
        child: Icon(_profil == null ? Icons.add : Icons.edit, color: Colors.white),
      ),
    );
  }
}
