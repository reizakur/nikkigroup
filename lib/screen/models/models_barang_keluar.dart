class BarangKeluarModel {
  BarangKeluarModel.init() {
    this.nama_pemesan = 'Coffe Name';
    this.id_br_keluar = 0;
  }

  // ignore: non_constant_identifier_names
  late String nama_barang,
      qty,
      total,
      gambar,
      id,
      nama_pemesan,
      tanggal_pemesanan;
  late int id_br_masuk, id_br_keluar;

  BarangKeluarModel.fromjson(Map<String, dynamic> json) {
    this.id_br_masuk = int.parse(json["id_br_masuk"]);
    this.id_br_keluar = int.parse(json["id_br_keluar"]);
    this.nama_barang = json["nama_barang"];
    this.qty = json["qty"];
    this.total = json["nama_pemesan"];
    this.total = json["tanggal_pemesanan"];
  }
  static List<BarangKeluarModel> produkkeluarlist = [];
}
