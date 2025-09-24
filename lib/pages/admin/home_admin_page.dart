import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/galeri_model.dart';
import 'package:jendela_informatika/pages/admin/daftar_dosen_crud.dart';
import 'package:jendela_informatika/pages/admin/galeri_crud.dart';
import 'package:jendela_informatika/pages/admin/profil_informatika_crud_page.dart';
import 'package:jendela_informatika/pages/admin/widgets/admin_drawer.dart';
import 'package:jendela_informatika/services/galeri_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jendela_informatika/models/client_model.dart';
import 'package:jendela_informatika/services/client_service.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;
  int jumlahBerita = 0;
  int jumlahPortofolio = 12;
  int jumlahDosen = 8;
  int jumlahGaleri = 15;
  double ratingRata = 4.5;

  List<ClientModel> _clients = [];
  List<GaleriModel> _galeriList = [];

  List<Widget> get _pages => [
        _buildHomePage(),
        const ProfilInformatikaCrudPage(),
        const GaleriCrudPage(),
        const DaftarDosenCrudPage(),
        _buildPortofolioPage(),
      ];

  String _adminName = '';

  @override
  void initState() {
    super.initState();
    _loadAdminName();
    _loadClients();
    _loadGaleriList();
  }

  Future<void> _loadGaleriList() async {
    final list = await GaleriService.loadGaleri();
    if (mounted) {
      setState(() {
        _galeriList = list;
        jumlahGaleri = list.length;
      });
    }
  }

  Future<void> _loadAdminName() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('admin_name');
    if (name != null && mounted) {
      setState(() {
        _adminName = name;
      });
    }
  }

  Future<void> _loadClients() async {
    List<ClientModel> loadedClients = await ClientService.getClients();
    if (mounted) {
      setState(() {
        _clients = loadedClients;
        jumlahBerita = _clients.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Halo $_adminName',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0A6DBD),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A6DBD),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) await _loadGaleriList();
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Galeri'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Dosen'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Portofolio'),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
  return RefreshIndicator(
    onRefresh: () async {
      await _loadGaleriList();
    },
    child: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _galeriList.length,
      itemBuilder: (context, index) {
        final item = _galeriList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.file(
                  File(item.imagePath),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.favorite,
                            color: Colors.red.shade300, size: 18),
                        const SizedBox(width: 4),
                        Text('${item.likes}'),
                        const SizedBox(width: 16),
                        Icon(Icons.comment, color: Colors.grey.shade600, size: 18),
                        const SizedBox(width: 4),
                        Text('${item.comments}'),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.share, size: 20),
                          onPressed: () {
                            // aksi share
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

  Widget _buildPortofolioPage() {
    return const Center(
      child: Text(
        'Kelola Portofolio Mahasiswa',
        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
      ),
    );
  }
}
