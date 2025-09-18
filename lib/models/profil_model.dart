class ProfilModel {
  final String id;
  final String nama;
  final String deskripsi;
  final String fotoProfil; // URL / path foto profil
  final String gelar;      // contoh: S.Kom
  final String status;     // contoh: Aktif / Nonaktif

  ProfilModel({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.fotoProfil,
    required this.gelar,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'fotoProfil': fotoProfil,
      'gelar': gelar,
      'status': status,
    };
  }

  factory ProfilModel.fromMap(Map<String, dynamic> map) {
    return ProfilModel(
      id: map['id'],
      nama: map['nama'],
      deskripsi: map['deskripsi'],
      fotoProfil: map['fotoProfil'],
      gelar: map['gelar'],
      status: map['status'],
    );
  }
}
