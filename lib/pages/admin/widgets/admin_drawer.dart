import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jendela_informatika/pages/admin/berita_page.dart';
import 'package:jendela_informatika/pages/admin/login_page.dart';
import 'package:jendela_informatika/pages/client/rating_page.dart';
import 'package:jendela_informatika/services/admin_service.dart';
import 'package:jendela_informatika/services/client_service.dart';


class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  Future<int> _getRatingCount() async {
    final ratings = await AdminService.getRatings();
    return ratings.length;
  }

  Future<int> _getBeritaCount() async {
    final clients = await ClientService.getClients();
    return clients.length;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 10, 109, 189),
            ),
            child: Text(
              'Menu Admin',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          FutureBuilder<int>(
            future: _getBeritaCount(),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return ListTile(
                leading: const FaIcon(FontAwesomeIcons.newspaper, color: Colors.blue),
                title: const Text('Berita Acara'),
                trailing: count > 0
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$count',
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminBeritaAcaraPage()),
                  );
                },
              );
            },
          ),
          FutureBuilder<int>(
            future: _getRatingCount(),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return ListTile(
                leading: const FaIcon(FontAwesomeIcons.star, color: Colors.amber),
                title: const Text('Rating'),
                trailing: count > 0
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$count',
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RatingPage()),
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.red,
            ),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminLoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
