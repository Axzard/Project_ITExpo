import 'package:flutter/material.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dashboard (dummy)
    int jumlahBerita = 5; // opsional
    int jumlahPortofolio = 12;
    int jumlahDosen = 8;
    int jumlahGaleri = 15;
    double ratingRata = 4.5;

    // Menu CRUD
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Kelola Profil Informatika',
        'icon': Icons.school,
        'color': Colors.blue,
        'onTap': () {},
      },
      {
        'title': 'Kelola Galeri',
        'icon': Icons.photo_library,
        'color': Colors.green,
        'onTap': () {},
      },
      {
        'title': 'Kelola Daftar Dosen',
        'icon': Icons.people,
        'color': Colors.orange,
        'onTap': () {},
      },
      {
        'title': 'Kelola Portofolio Mahasiswa',
        'icon': Icons.work,
        'color': Colors.purple,
        'onTap': () {},
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'color': Colors.red,
        'onTap': () {
          Navigator.pop(context);
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard Admin',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 109, 189),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Dashboard Overview
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildDashboardCard(
                        title: 'Berita Acara',
                        value: '$jumlahBerita',
                        icon: Icons.article,
                        color: Colors.blue,
                      ),
                      _buildDashboardCard(
                        title: 'Portofolio',
                        value: '$jumlahPortofolio',
                        icon: Icons.work,
                        color: Colors.purple,
                      ),
                      _buildDashboardCard(
                        title: 'Dosen',
                        value: '$jumlahDosen',
                        icon: Icons.people,
                        color: Colors.orange,
                      ),
                      _buildDashboardCard(
                        title: 'Galeri',
                        value: '$jumlahGaleri',
                        icon: Icons.photo_library,
                        color: Colors.green,
                      ),
                      _buildDashboardCard(
                        title: 'Rating',
                        value: '$ratingRata ⭐',
                        icon: Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 🔹 Menu CRUD
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return InkWell(
                    onTap: item['onTap'],
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: item['color'].withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item['icon'],
                            size: 40,
                            color: item['color'],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Dashboard Card
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
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
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
