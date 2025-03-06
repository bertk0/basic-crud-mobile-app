class Model {
  int? id;
  String? tanggal_penjualan;
  String? nama_alatmusik;
  int? harga_alatmusik;
  int? quantity;
  int? total_harga;
  String? jenis_alatmusik;

  Model({
    required this.id,
    required this.tanggal_penjualan,
    required this.nama_alatmusik,
    required this.harga_alatmusik,
    required this.quantity,
    required this.total_harga,
    required this.jenis_alatmusik,
  });

  Model.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tanggal_penjualan = json['tanggal_penjualan'];
    nama_alatmusik = json["nama_alatmusik"];
    harga_alatmusik = json["harga_alatmusik"];
    quantity = json['quantity'];
    total_harga = json['total_harga'];
    jenis_alatmusik = json['jenis_alatmusik'];
  }

}
