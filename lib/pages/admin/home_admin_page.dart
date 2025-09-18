import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jendela_informatika/pages/admin/login_page.dart';
import 'package:jendela_informatika/pages/admin/profil_crud_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// tambahkan import ini
import 'package:jendela_informatika/models/client_model.dart';
import 'package:jendela_informatika/services/client_service.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;

  // nilai default
  int jumlahBerita = 0; // diambil dari jumlah client
  int jumlahPortofolio = 12;
  int jumlahDosen = 8;
  int jumlahGaleri = 15;
  double ratingRata = 4.5;

  List<ClientModel> _clients = [];

  List<Widget> get _pages => [
        _buildHomePage(),
        const ProfilCrudPage(),
        _buildGaleriPage(),
        _buildDosenPage(),
        _buildPortofolioPage(),
      ];

  String _adminName = '';

  @override
  void initState() {
    super.initState();
    _loadAdminName();
    _loadClients(); // tambahkan ini
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
        jumlahBerita = _clients.length; // update jumlah berita acara
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 10, 109, 189),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.red,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminLoginPage()),
                );
              },
            ),
          ],
        ),
      ),
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
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
                _buildDashboardCard(
                  title: 'Berita Acara',
                  value: '$jumlahBerita',
                  icon: Icons.article,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _buildDashboardCard(
                  title: 'Portofolio',
                  value: '$jumlahPortofolio',
                  icon: Icons.work,
                  color: Colors.purple,
                ),
                const SizedBox(width: 12),
                _buildDashboardCard(
                  title: 'Dosen',
                  value: '$jumlahDosen',
                  icon: Icons.people,
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                _buildDashboardCard(
                  title: 'Galeri',
                  value: '$jumlahGaleri',
                  icon: Icons.photo_library,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                _buildDashboardCard(
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
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('Galeri $index')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGaleriPage() {
    return const Center(child: Text('Kelola Galeri'));
  }

  Widget _buildDosenPage() {
    return const Center(child: Text('Kelola Daftar Dosen'));
  }

  Widget _buildPortofolioPage() {
    return const Center(child: Text('Kelola Portofolio Mahasiswa'));
  }

  Widget _buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 160,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
