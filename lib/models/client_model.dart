class ClientModel {
  final String nama;
  final String pekerjaan;
  final int umur;
  final String alamat;

  ClientModel({
    required this.nama,
    required this.pekerjaan,
    required this.umur,
    required this.alamat,
  });

  // convert ke Map untuk disimpan di SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'pekerjaan': pekerjaan,
      'umur': umur,
      'alamat': alamat,
    };
  }

  // dari Map ke ClientModel
  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      nama: map['nama'],
      pekerjaan: map['pekerjaan'],
      umur: map['umur'],
      alamat: map['alamat'],
    );
  }

}
