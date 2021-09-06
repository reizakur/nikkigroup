part of'models.dart';
class BarangKeluarModel {
  BarangKeluarModel.init() {
    this.namaPemesan = 'Coffe Name';
    this.idBarangKeluar = 0;
  }

  // ignore: non_constant_identifier_names
  String nama_barang,
      qty,
      total,
      gambar,
      id,
      namaPemesan,
      tanggalPemesanan;
  int idBarangMasuk, idBarangKeluar;

  BarangKeluarModel.fromjson(Map<String, dynamic> json) {
    this.idBarangMasuk = int.parse(json["idBarangMasuk"]);
    this.idBarangKeluar = int.parse(json["idBarangKeluar"]);
    this.nama_barang = json["nama_barang"];
    this.qty = json["qty"];
    this.total = json["namaPemesan"];
    this.total = json["tanggalPemesanan"];
  }
  static List<BarangKeluarModel> produkkeluarlist = [];
}
