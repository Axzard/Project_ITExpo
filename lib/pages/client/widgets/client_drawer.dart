import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jendela_informatika/pages/landing_page.dart';



class ClientDrawer extends StatelessWidget {
  const ClientDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 10, 109, 189),
            ),
            accountName: const Text('Menu Client'),
            accountEmail: const Text(''), 
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue, size: 40),
            ),
          ),

          
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.user, color: Colors.blue),
            title: const Text('Profil'),
            onTap: () {
            },
          ),

          
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.signOutAlt, 
              color: Colors.red
              ),
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
