class GaleriModel {
  String imagePath;
  String title;
  String description;
  String date;
  int likes;
  int comments;

  GaleriModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    this.likes = 0,
    this.comments = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'date': date,
      'likes': likes,
      'comments': comments,
    };
  }

  factory GaleriModel.fromMap(Map<String, dynamic> map) {
    return GaleriModel(
      imagePath: map['imagePath'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      likes: map['likes'] ?? 0,
      comments: map['comments'] ?? 0,
    );
  }
}
