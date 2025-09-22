import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/galeri_model.dart';

class GaleriCard extends StatelessWidget {
  final GaleriModel item;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GaleriCard({
    super.key,
    required this.item,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(item.title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text(item.date, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(item.imagePath),
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(item.description),
            const SizedBox(height: 5),
            // tombol aksi
            Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: onLike,
                        icon: Icon(Icons.favorite,
                            color: item.likes > 0
                                ? Colors.red
                                : Colors.grey)),
                    Text('${item.likes} Hearts'),
                    IconButton(
                        onPressed: onComment,
                        icon: const Icon(Icons.comment)),
                    Text('${item.comments} Comments'),
                    IconButton(
                        onPressed: onShare,
                        icon: const Icon(Icons.share)),
                    const Text('Bagikan'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit, color: Colors.blue)),
                    IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete, color: Colors.red)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
