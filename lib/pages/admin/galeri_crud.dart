import 'package:flutter/material.dart';
import 'package:jendela_informatika/pages/admin/widgets/galeri_card.dart';
import 'package:jendela_informatika/pages/admin/widgets/galeri_form.dart';
import '../../../models/galeri_model.dart';
import '../../../services/galeri_service.dart';


class GaleriCrudPage extends StatefulWidget {
  const GaleriCrudPage({super.key});

  @override
  State<GaleriCrudPage> createState() => _GaleriCrudPageState();
}

class _GaleriCrudPageState extends State<GaleriCrudPage> {
  List<GaleriModel> galeriList = [];

  @override
  void initState() {
    super.initState();
    _loadGaleri();
  }

  Future<void> _loadGaleri() async {
    galeriList = await GaleriService.loadGaleri();
    setState(() {});
  }

  Future<void> _saveGaleri() async {
    await GaleriService.saveGaleri(galeriList);
  }

  Future<void> _addGaleri() async {
    final newItem = await showGaleriForm(context);
    if (newItem != null) {
      galeriList.add(newItem);
      await _saveGaleri();
      setState(() {});
    }
  }

  Future<void> _editGaleri(int index) async {
    final editedItem =
        await showGaleriForm(context, existing: galeriList[index]);
    if (editedItem != null) {
      galeriList[index] = editedItem;
      await _saveGaleri();
      setState(() {});
    }
  }

  void _deleteGaleri(int index) async {
    galeriList.removeAt(index);
    await _saveGaleri();
    setState(() {});
  }

  void _toggleLike(int index) async {
    galeriList[index].likes++;
    await _saveGaleri();
    setState(() {});
  }

  void _addComment(int index) async {
    // nanti buat pop-up komentar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fitur komentar belum dibuat.")));
  }

  void _share(int index) {
    // nanti integrasi share_plus
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fitur bagikan belum dibuat.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: galeriList.isEmpty
          ? const Center(child: Text("Belum ada galeri"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: galeriList.length,
              itemBuilder: (context, index) {
                final item = galeriList[index];
                return GaleriCard(
                  item: item,
                  onLike: () => _toggleLike(index),
                  onComment: () => _addComment(index),
                  onShare: () => _share(index),
                  onEdit: () => _editGaleri(index),
                  onDelete: () => _deleteGaleri(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGaleri,
        child: const Icon(Icons.add),
      ),
    );
  }
}
