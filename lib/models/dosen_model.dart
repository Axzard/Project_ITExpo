class DosenModel {
  final String id;
  final String nama;
  final String deskripsi;
  final String fotoProfil; // URL / path foto profil
  final String gelar;      // contoh: S.Kom
  final String status;     // contoh: Aktif / Nonaktif

  DosenModel({
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

  factory DosenModel.fromMap(Map<String, dynamic> map) {
    return DosenModel(
      id: map['id'],
      nama: map['nama'],
      deskripsi: map['deskripsi'],
      fotoProfil: map['fotoProfil'],
      gelar: map['gelar'],
      status: map['status'],
    );
  }

  String? get keahlian => null;

  get fotoPath => null;
}
