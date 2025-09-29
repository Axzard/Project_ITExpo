import 'package:flutter/material.dart';
import 'package:jendela_informatika/services/admin_service.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  List<Map<String, dynamic>> ratings = [];

  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

  Future<void> _loadRatings() async {
    final data = await AdminService.getRatings();
    setState(() {
      ratings = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Rating')),
      body: ratings.isEmpty
          ? const Center(child: Text('Belum ada rating'))
          : ListView.builder(
              itemCount: ratings.length,
              itemBuilder: (context, index) {
                final r = ratings[index];
                return ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber),
                  title: Text('${r['nama']} - ${r['nilai']} ★'),
                  subtitle: Text(r['komentar'] ?? ''),
                  trailing: Text(r['tanggal'] != null
                      ? DateTime.parse(r['tanggal'])
                          .toLocal()
                          .toString()
                          .substring(0, 16)
                      : ''),
                );
              },
            ),
    );
  }
}
