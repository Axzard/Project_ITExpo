import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/profil_informatika_model.dart';
import 'package:jendela_informatika/services/profil_informatika_service.dart';

class ProfilInformatikaPage extends StatefulWidget {
  const ProfilInformatikaPage({super.key});

  @override
  State<ProfilInformatikaPage> createState() => _ProfilInformatikaPageState();
}

class _ProfilInformatikaPageState extends State<ProfilInformatikaPage> {
  ProfilInformatikaModel? _profil;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Informatika',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: _profil == null
          ? const Center(
              child: Text(
                'Belum ada data Profil Informatika',
                style: TextStyle(fontSize: 16),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto Profil
                  _profil!.imagePath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_profil!.imagePath),
                            width: double.infinity,
                            height: 350,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.image, size: 60),
                        ),
                  const SizedBox(height: 16),

                  // Visi
                  const Text(
                    'Visi:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _profil!.visi,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Misi
                  const Text(
                    'Misi:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _profil!.misi,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
