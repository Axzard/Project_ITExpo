import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:jendela_informatika/models/galeri_model.dart';

class GaleriCard extends StatefulWidget {
  final GaleriModel item;
  final VoidCallback? onLike;
  final VoidCallback? onComment;

  const GaleriCard({
    super.key,
    required this.item,
    this.onLike,
    this.onComment,
  });

  @override
  State<GaleriCard> createState() => _GaleriCardState();
}

class _GaleriCardState extends State<GaleriCard> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.file(
              File(item.imagePath),
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? Colors.red : Colors.grey,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          liked = !liked;
                          if (liked) {
                            item.likes++;
                          } else {
                            item.likes--;
                          }
                        });
                        if (widget.onLike != null) widget.onLike!();
                      },
                    ),
                    Text('${item.likes}'),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.comment, size: 22),
                      onPressed: () {
                        if (widget.onComment != null) widget.onComment!();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur komentar coming soon'),
                          ),
                        );
                      },
                    ),
                    Text('${item.comments}'),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.share, size: 22),
                      onPressed: () {
                        Share.share(
                            'Lihat foto ${item.title} di aplikasi Jendela Informatika!');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
