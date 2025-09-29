import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jendela_informatika/services/admin_service.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0; // rating bintang
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

  Widget _buildStar(int index) {
    if (index < _rating) {
      return IconButton(
        icon: const Icon(Icons.star, color: Colors.amber, size: 36),
        onPressed: () {
          setState(() {
            _rating = index + 1.0;
          });
        },
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.star_border, color: Colors.grey, size: 36),
        onPressed: () {
          setState(() {
            _rating = index + 1.0;
          });
        },
      );
    }
  }

  Future<void> _saveRating() async {
    if (_namaController.text.isEmpty || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi nama dan pilih rating')),
      );
      return;
    }

    await AdminService.addRating({
      'nama': _namaController.text,
      'nilai': _rating,
      'komentar': _commentController.text,
      'tanggal': DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rating berhasil disimpan')),
    );

    // reset
    setState(() {
      _rating = 0;
      _namaController.clear();
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Anda',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Komentar (opsional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveRating,
                icon: const FaIcon(FontAwesomeIcons.save, color: Colors.white),
                label: const Text('Simpan Rating',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A6DBD),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
