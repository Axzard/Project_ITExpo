import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/dosen_model.dart';

class DosenCard extends StatelessWidget {
  final DosenModel profil;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DosenCard({
    Key? key,
    required this.profil,
    required this.onEdit,
    required this.onDelete, 
    required DosenModel DosenModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 50 / 40,
            child: profil.fotoProfil.isNotEmpty
                ? (profil.fotoProfil.startsWith('http')
                      ? Image.network(profil.fotoProfil, fit: BoxFit.cover)
                      : Image.file(File(profil.fotoProfil), fit: BoxFit.cover))
                : Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.person, size: 60, color: Colors.grey),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profil.nama,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  '${profil.gelar} • ${profil.status}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Text(
                  profil.deskripsi,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
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
