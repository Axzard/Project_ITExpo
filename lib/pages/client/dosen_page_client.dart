import 'dart:io'; // penting untuk FileImage
import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/dosen_model.dart';
import 'package:jendela_informatika/services/dosen_service.dart';

class DosenClientPage extends StatefulWidget {
  const DosenClientPage({super.key});

  @override
  State<DosenClientPage> createState() => _DosenClientPageState();
}

class _DosenClientPageState extends State<DosenClientPage> {
  List<DosenModel> _dosenList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDosen();
  }

  Future<void> _loadDosen() async {
    final dosen = await DosenService.loadDosen(); // ambil data dosen
    setState(() {
      _dosenList = dosen;
      _isLoading = false;
    });
  }

  /// Fungsi helper untuk menentukan image provider
  ImageProvider? _getImageProvider(DosenModel dosen) {
    if (dosen.fotoProfil.isNotEmpty && dosen.fotoProfil.startsWith('http')) {
      // URL online
      return NetworkImage(dosen.fotoProfil);
    } else if (dosen.fotoProfil.isNotEmpty &&
        dosen.fotoProfil.startsWith('file://')) {
      // path lokal dengan prefix file://
      final filePath = dosen.fotoProfil.replaceFirst('file://', '');
      if (File(filePath).existsSync()) {
        return FileImage(File(filePath));
      }
    } else if (dosen.fotoProfil.isNotEmpty &&
        File(dosen.fotoProfil).existsSync()) {
      // path lokal biasa
      return FileImage(File(dosen.fotoProfil));
    } else if (dosen.fotoPath != null &&
        dosen.fotoPath.toString().isNotEmpty &&
        File(dosen.fotoPath).existsSync()) {
      // fallback jika pakai fotoPath
      return FileImage(File(dosen.fotoPath));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDosen,
              child: _dosenList.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 100),
                        Center(child: Text("Belum ada data dosen")),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _dosenList.length,
                      itemBuilder: (context, index) {
                        final dosen = _dosenList[index];
                        final avatarImage = _getImageProvider(dosen);

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: avatarImage,
                              child: avatarImage == null
                                  ? const Icon(Icons.person,
                                      color: Colors.grey)
                                  : null,
                            ),
                            title: Text(
                              "${dosen.nama}, ${dosen.gelar}",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dosen.deskripsi,
                                    style: const TextStyle(fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(
                                  "Status: ${dosen.status}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dosen.status == "Aktif"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
