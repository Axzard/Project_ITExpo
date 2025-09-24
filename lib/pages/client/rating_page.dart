import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0; // rating bintang
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rating = prefs.getDouble('app_rating') ?? 0;
      _commentController.text = prefs.getString('app_comment') ?? '';
    });
  }

  Future<void> _saveRating() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('app_rating', _rating);
    await prefs.setString('app_comment', _commentController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rating berhasil disimpan')),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Berikan Rating Aplikasi',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 20),

            // BINTANG
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 20),

            // KOMENTAR
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

            // SIMPAN BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveRating,
                icon: const Icon(Icons.save, color: Colors.white),
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
