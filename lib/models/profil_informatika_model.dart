class ProfilInformatikaModel {
  final String imagePath; // path gambar prodi
  final String visi;
  final String misi;

  ProfilInformatikaModel({
    required this.imagePath,
    required this.visi,
    required this.misi,
  });

  // convert ke Map untuk SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'visi': visi,
      'misi': misi,
    };
  }

  // fromMap
  factory ProfilInformatikaModel.fromMap(Map<String, dynamic> map) {
    return ProfilInformatikaModel(
      imagePath: map['imagePath'] ?? '',
      visi: map['visi'] ?? '',
      misi: map['misi'] ?? '',
    );
  }
}
