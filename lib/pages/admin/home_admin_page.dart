import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/galeri_model.dart';
import 'package:jendela_informatika/pages/admin/daftar_dosen_crud.dart';
import 'package:jendela_informatika/pages/admin/galeri_crud.dart';
import 'package:jendela_informatika/pages/admin/profil_informatika_crud_page.dart';
import 'package:jendela_informatika/pages/admin/widgets/admin_drawer.dart';
import 'package:jendela_informatika/pages/admin/widgets/dashboard_card.dart';
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
    ProfilInformatikaCrudPage(),
    GaleriCrudPage(),
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
        jumlahGaleri = list.length; // supaya dashboard card juga update
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
        backgroundColor: const Color.fromARGB(255, 10, 109, 189),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 10, 109, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            await _loadGaleriList();
          }
        },

        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Profil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Galeri',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Dosen'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Portofolio'),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overview",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DashboardCard(
                  title: 'Berita Acara',
                  value: '$jumlahBerita',
                  icon: Icons.article,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                DashboardCard(
                  title: 'Portofolio',
                  value: '$jumlahPortofolio',
                  icon: Icons.work,
                  color: Colors.purple,
                ),
                const SizedBox(width: 12),
                DashboardCard(
                  title: 'Dosen',
                  value: '$jumlahDosen',
                  icon: Icons.people,
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                DashboardCard(
                  title: 'Galeri',
                  value: '$jumlahGaleri',
                  icon: Icons.photo_library,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                DashboardCard(
                  title: 'Rating',
                  value: '$ratingRata ⭐',
                  icon: Icons.star,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Galeri Informatika",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _galeriList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = _galeriList[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: Image.file(
                          File(item.imagePath),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        item.date,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPortofolioPage() {
    return const Center(child: Text('Kelola Portofolio Mahasiswa'));
  }
}
