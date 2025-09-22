import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/galeri_model.dart';

Future<GaleriModel?> showGaleriForm(BuildContext context,
    {GaleriModel? existing}) async {
  final titleController = TextEditingController(text: existing?.title ?? '');
  final descController = TextEditingController(text: existing?.description ?? '');
  File? imageFile = existing != null ? File(existing.imagePath) : null;

  return showDialog<GaleriModel>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(existing == null ? "Tambah Galeri" : "Edit Galeri"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picked = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (picked != null) {
                        setState(() {
                          imageFile = File(picked.path);
                        });
                      }
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: imageFile != null
                          ? Image.file(imageFile!, fit: BoxFit.cover)
                          : const Icon(Icons.add_a_photo, size: 50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "Judul", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                        labelText: "Keterangan",
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal")),
              ElevatedButton(
                  onPressed: () {
                    if (imageFile == null ||
                        titleController.text.isEmpty ||
                        descController.text.isEmpty) return;

                    final newItem = GaleriModel(
                      imagePath: imageFile!.path,
                      title: titleController.text,
                      description: descController.text,
                      date: DateTime.now().toString().substring(0, 10),
                      likes: existing?.likes ?? 0,
                      comments: existing?.comments ?? 0,
                    );
                    Navigator.pop(context, newItem);
                  },
                  child: const Text("Simpan")),
            ],
          );
        },
      );
    },
  );
}
