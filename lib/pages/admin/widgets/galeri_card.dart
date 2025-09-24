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
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            title: Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(item.date,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Hapus')),
              ],
            ),
          ),

          // Image
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.file(
              File(item.imagePath),
              fit: BoxFit.cover,
            ),
          ),

          // Description
          if (item.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                item.description,
                style: const TextStyle(fontSize: 14),
              ),
            ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.favorite,
                  label: '${item.likes}',
                  color: item.likes > 0 ? Colors.red : Colors.grey,
                  onTap: onLike,
                ),
                _buildActionButton(
                  icon: Icons.comment,
                  label: '${item.comments}',
                  color: Colors.grey,
                  onTap: onComment,
                ),
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Bagikan',
                  color: Colors.grey,
                  onTap: onShare,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey.shade800)),
          ],
        ),
      ),
    );
  }
}
