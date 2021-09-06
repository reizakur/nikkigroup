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
    const noData ='No Data';
    this.idBarangMasuk = json["id_br_masuk"];
    this.nama_br = json["nama_br"];
    this.qty = int.parse(json["stok"]);
    this.harga = noData;
    this.total = noData;
  }
  static List<StokModel> stoklist = [];
}