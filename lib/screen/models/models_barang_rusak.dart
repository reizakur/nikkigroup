class RusakModel {
  RusakModel.init() {
    this.nama_barang = 'Coffe Name';
    this.qty = 0;
  }

  // ignore: non_constant_identifier_names
  late String id_barang_rusak, nama_barang, gambar, harga, total;
  late int qty;

  RusakModel.fromjson(Map<String, dynamic> json) {
    this.id_barang_rusak = json["id_barang_rusak"];
    this.nama_barang = json["nama_barang"];
    this.harga = json["harga"];
    this.gambar = json["gambar"];
    this.qty = json["qty"] == '' ? 0 : int.parse(json["qty"]);
    this.total = json["total"];
  }
  static List<RusakModel> rusaklist = [];
}
