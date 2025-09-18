import 'package:flutter/material.dart';
import 'package:jendela_informatika/pages/landing_page.dart';

class HomeClientPage extends StatelessWidget {
  final String nama;
  const HomeClientPage({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Profil Informatika',
        'icon': Icons.school,
        'iconColor': Colors.blue,
        'iconSize': 40.0,
        'bgColor': Colors.blue.withOpacity(0.05),
        'onTap': () {},
      },
      {
        'title': 'Galeri',
        'icon': Icons.photo_library,
        'iconColor': Colors.green,
        'iconSize': 45.0,
        'bgColor': Colors.green.withOpacity(0.05),
        'onTap': () {},
      },
      {
        'title': 'Daftar Dosen & Keahlian',
        'icon': Icons.people,
        'iconColor': Colors.orange,
        'iconSize': 42.0,
        'bgColor': Colors.orange.withOpacity(0.05),
        'onTap': () {},
      },
      {
        'title': 'Portofolio Mahasiswa',
        'icon': Icons.work,
        'iconColor': Colors.purple,
        'iconSize': 40.0,
        'bgColor': Colors.purple.withOpacity(0.05),
        'onTap': () {},
      },
      {
        'title': 'Beri Rating Aplikasi',
        'icon': Icons.star_rate,
        'iconColor': Colors.amber,
        'iconSize': 48.0,
        'bgColor': Colors.amber.withOpacity(0.05),
        'onTap': () {},
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'iconColor': Colors.red,
        'iconSize': 40.0,
        'bgColor': Colors.red.withOpacity(0.05),
        'onTap': () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandingPage()));
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 10, 109, 189),
        title: Text(
          "Halo, $nama 👋",
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Selamat datang di Pameran Informatika.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
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
                      color: item['bgColor'] ?? Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: (item['iconColor'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'],
                          size: item['iconSize'] ?? 40.0,
                          color: item['iconColor'] ?? Colors.blue,
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
    );
  }
}
