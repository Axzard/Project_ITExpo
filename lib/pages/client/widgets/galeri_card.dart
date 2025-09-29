import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool liked = false; // status like user ini
  List<String> commentsList = []; // daftar komentar user
  final TextEditingController _commentController = TextEditingController();

  // key SharedPreferences
  String get likeKey => 'liked_posts';
  String get commentKey => 'comments_${widget.item.imagePath}';

  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
    _loadComments();
  }

  /// Muat status like dari SharedPreferences
  Future<void> _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(likeKey) ?? [];
    setState(() {
      liked = likedPosts.contains(widget.item.imagePath);
    });
  }

  /// Simpan status like ke SharedPreferences
  Future<void> _saveLikeStatus(bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = prefs.getStringList(likeKey) ?? [];
    if (isLiked) {
      if (!likedPosts.contains(widget.item.imagePath)) {
        likedPosts.add(widget.item.imagePath);
      }
    } else {
      likedPosts.remove(widget.item.imagePath);
    }
    await prefs.setStringList(likeKey, likedPosts);
  }

  /// Muat komentar dari SharedPreferences
  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final savedComments = prefs.getStringList(commentKey) ?? [];
    setState(() {
      commentsList = savedComments;
    });
  }

  /// Simpan komentar ke SharedPreferences
  Future<void> _saveComments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(commentKey, commentsList);
  }

  void _addComment(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      commentsList.add(text);
      widget.item.comments++; // counter komentar di GaleriModel
    });
    _saveComments();
    _commentController.clear();
  }

  /// toggle like / unlike
  void _toggleLike() async {
    setState(() {
      if (liked) {
        liked = false;
        if (widget.item.likes > 0) {
          widget.item.likes--;
        }
      } else {
        liked = true;
        widget.item.likes++;
      }
    });
    await _saveLikeStatus(liked);
    if (widget.onLike != null) widget.onLike!();
  }

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
                    // Tombol Like (toggle)
                    IconButton(
                      icon: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? Colors.red : Colors.grey,
                        size: 22,
                      ),
                      onPressed: _toggleLike,
                    ),
                    Text('${item.likes}'),
                    const SizedBox(width: 16),
                    // Tombol Komentar
                    IconButton(
                      icon: const Icon(Icons.comment, size: 22),
                      onPressed: () {
                        if (widget.onComment != null) widget.onComment!();
                        _showCommentSheet(context);
                      },
                    ),
                    Text('${item.comments}'),
                    const Spacer(),
                    // Tombol Share
                    IconButton(
                      icon: const Icon(Icons.share, size: 22),
                      onPressed: () {
                        Share.share(
                            'Lihat foto ${item.title} di aplikasi Jendela Informatika!');
                      },
                    ),
                  ],
                ),
                // Tampilkan komentar terakhir
                if (commentsList.isNotEmpty) ...[
                  const Divider(),
                  const Text('Komentar Terbaru:',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  for (var c in commentsList.take(3))
                    Text('- $c', style: const TextStyle(fontSize: 13)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // bottom sheet komentar
  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Daftar Komentar',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(commentsList[index]),
                      );
                    },
                  ),
                ),
                const Divider(),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: 'Tulis komentar Anda...',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _addComment(_commentController.text);
                  },
                  child: const Text('Kirim Komentar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
