class ProdukModel {
  ProdukModel.init() {
    this.nama_br = 'Coffe Name';
    this.qty = 0;
  }

  // ignore: non_constant_identifier_names
  late String id_br_masuk, nama_br, harga, total;
  late int qty;

  ProdukModel.fromjson(Map<String, dynamic> json) {
    this.id_br_masuk = json["id_br_masuk"];
    this.nama_br = json["nama_br"];
    this.harga = json["harga"];
    this.qty = int.parse(json["qty"]);
    this.total = json["total"];
  }
  static List<ProdukModel> produklist = [];
}
