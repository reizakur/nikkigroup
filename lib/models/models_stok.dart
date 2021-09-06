part of'models.dart';
class StokModel {
  StokModel.init() {
    this.nama_br = 'Coffe Name';
    this.qty = 0;
  }

  // ignore: non_constant_identifier_names
  String idBarangMasuk, nama_br, harga, total;
  int qty;

  StokModel.fromjson(Map<String, dynamic> json) {
    this.idBarangMasuk = json["idBarangMasuk"];
    this.nama_br = json["nama_br"];
    this.harga = json["harga"];
    this.qty = int.parse(json["qty"]);
    this.total = json["total"];
  }
  static List<StokModel> stoklist = [];
}