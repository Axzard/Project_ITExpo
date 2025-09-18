import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jendela_informatika/models/profil_informatika_model.dart';

class ProfilInformatikaCard extends StatelessWidget {
  final ProfilInformatikaModel profil;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProfilInformatikaCard({
    super.key,
    required this.profil,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8), 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(
            width: double.infinity,
            height: 350,
            child: profil.imagePath.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.file(
                      File(profil.imagePath),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                        child: Icon(Icons.image,
                            size: 60, color: Colors.grey)),
                  ),
          ),

          
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visi:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                Text(
                  profil.visi,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Misi:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                Text(
                  profil.misi,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),

                
                Row(
                  children: [
                    TextButton(
                      onPressed: onEdit,
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: onDelete,
                      child: const Text(
                        'Hapus',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
