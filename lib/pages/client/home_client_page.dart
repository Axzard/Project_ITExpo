import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/galeri_model.dart';
import 'package:jendela_informatika/pages/client/dosen_page_client.dart';
import 'package:jendela_informatika/pages/client/rating_page.dart';
import 'package:jendela_informatika/pages/client/widgets/client_drawer.dart';
import 'package:jendela_informatika/pages/client/widgets/galeri_card.dart';
import 'package:jendela_informatika/services/galeri_service.dart';
import 'package:jendela_informatika/pages/client/profil_informatika_page.dart';

class HomeClientPage extends StatefulWidget {
  final String nama;
  const HomeClientPage({super.key, required this.nama});

  @override
  State<HomeClientPage> createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  int _selectedIndex = 0;
  List<GaleriModel> _galeriList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final galeri = await GaleriService.loadGaleri();
    setState(() {
      _galeriList = galeri;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
  return RefreshIndicator(
    onRefresh: _loadData,
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Galeri Informatika",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins')),
        const SizedBox(height: 8),
        if (_galeriList.isEmpty)
          const Text("Belum ada galeri")
        else
          ..._galeriList.map((item) {
            return GaleriCard(
              item: item,
              onLike: () {
                // Simpan like ke backend atau SharedPreferences jika perlu
              },
              onComment: () {
                // Aksi buka komentar
              },
            );
          }).toList(),
      ],
    ),
  );
}

  Widget _buildProfilPage() {
    return const ProfilInformatikaPage();
  }






  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomePage(),
      _buildProfilPage(),
      DosenClientPage(),
      RatingPage()
    ];

    return Scaffold(
      drawer: const ClientDrawer(),
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
          'Halo ${widget.nama}',
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
      // Drawer tetap sama
      
      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 10, 109, 189),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Dosen"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Rating"),
        ],
      ),
    );
  }
}
