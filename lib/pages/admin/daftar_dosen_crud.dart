import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jendela_informatika/models/dosen_model.dart';
import 'package:jendela_informatika/pages/admin/widgets/dosen_card.dart';
import 'package:jendela_informatika/services/dosen_service.dart';
import 'package:uuid/uuid.dart';

class DaftarDosenCrudPage extends StatefulWidget {
  const DaftarDosenCrudPage({super.key});

  @override
  State<DaftarDosenCrudPage> createState() => _DaftarDosenCrudPageState();
}

class _DaftarDosenCrudPageState extends State<DaftarDosenCrudPage> {
  final DosenService _service = DosenService();
  List<DosenModel> _profilList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _service.ambilSemua();
    setState(() {
      _profilList = data.cast<DosenModel>();
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

  void _showForm({DosenModel? profil}) {
    final namaController = TextEditingController(text: profil?.nama ?? '');
    final deskripsiController = TextEditingController(
      text: profil?.deskripsi ?? '',
    );
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
                    final newProfil = DosenModel(
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
                      await _service.editProfil(profil.id, newProfil );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          children: List.generate(_profilList.length, (index) {
            final profil = _profilList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: DosenCard(
                profil: profil,
                onEdit: () => _showForm(profil: profil),
                onDelete: () => _hapusProfil(profil.id),
                DosenModel: profil,
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
