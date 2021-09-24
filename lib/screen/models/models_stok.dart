class StokModel {
  StokModel.init() {
    this.nama_barang = 'Stok Name';
    this.id_br_masuk = 0;
  }

  // ignore: non_constant_identifier_names
  late int id_br_masuk;
  late String stok, id_stok_br, tanggal, nama_barang;

  StokModel.fromjson(Map<String, dynamic> json) {
    this.id_br_masuk = int.parse(json["id_br_masuk"]);
    this.id_stok_br = json["id_stok_br"];
    this.stok = json["stok"];
    this.tanggal = json["tanggal"];
    this.nama_barang = json["nama_barang"];
  }
  static List<StokModel> stoklist = [];
}
