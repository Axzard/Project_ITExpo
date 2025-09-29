class GaleriModel {
  String id; // ID unik untuk setiap postingan
  String imagePath;
  String title;
  String description;
  String date;
  int likes;
  int comments; // jumlah komentar
  List<String> commentList; // daftar komentar sebenarnya

  GaleriModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    this.likes = 0,
    this.comments = 0,
    List<String>? commentList,
  }) : commentList = commentList ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'date': date,
      'likes': likes,
      'comments': comments,
      'commentList': commentList,
    };
  }

  factory GaleriModel.fromMap(Map<String, dynamic> map) {
    return GaleriModel(
      id: map['id'] ?? '', // jika kosong bisa diisi uuid
      imagePath: map['imagePath'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      likes: map['likes'] ?? 0,
      comments: map['comments'] ?? 0,
      commentList:
          (map['commentList'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
