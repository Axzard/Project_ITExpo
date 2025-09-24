import 'package:flutter/material.dart';
import 'package:jendela_informatika/pages/landing_page.dart';
// import halaman profil jika sudah ada
// import 'package:jendela_informatika/pages/client/profile_page.dart';

class ClientDrawer extends StatelessWidget {
  const ClientDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // HEADER
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 10, 109, 189),
            ),
            accountName: const Text('Menu Client'),
            accountEmail: const Text(''), // Bisa isi email user
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue, size: 40),
            ),
          ),

          // MENU PROFIL
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Profil'),
            onTap: () {
              // Navigasi ke halaman profil client
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),

          // LOGOUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
