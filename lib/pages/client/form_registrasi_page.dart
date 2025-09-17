import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/client_model.dart';
import 'package:jendela_informatika/services/client_service.dart';
import 'home_client_page.dart';

class FormRegistrasiPage extends StatefulWidget {
  const FormRegistrasiPage({super.key});

  @override
  State<FormRegistrasiPage> createState() => _FormRegistrasiPageState();
}

class _FormRegistrasiPageState extends State<FormRegistrasiPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  String? _pekerjaan;
  final List<String> _listPekerjaan = [
    'Mahasiswa',
    'PNS',
    'Wiraswasta',
    'Pegawai Swasta',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Form Registrasi",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _pekerjaan,
                decoration: const InputDecoration(
                  labelText: 'Pekerjaan',
                  border: OutlineInputBorder(),
                ),
                items: _listPekerjaan.map((String pekerjaan) {
                  return DropdownMenuItem<String>(
                    value: pekerjaan,
                    child: Text(pekerjaan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _pekerjaan = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pekerjaan wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _umurController,
                decoration: const InputDecoration(
                  labelText: 'Umur',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Umur wajib diisi';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ClientModel client = ClientModel(
                      nama: _namaController.text,
                      pekerjaan: _pekerjaan!,
                      umur: int.parse(_umurController.text),
                      alamat: _alamatController.text,
                    );

                    // Simpan ke SharedPreferences
                    await ClientService.saveClient(client);

                    // Navigasi ke HomeClientPage dengan nama client
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeClientPage(nama: client.nama),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Registrasi',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Skip registrasi langsung ke HomeClientPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeClientPage(nama: ''),
                    ),
                  );
                },
                child: const Text(
                  'Lewati Registrasi',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
