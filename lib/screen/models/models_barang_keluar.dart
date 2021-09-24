class BarangKeluarModel {
  BarangKeluarModel.init() {
    this.nama_pemesan = 'Nama Pemesanan';
    this.qty = 0;
  }

  // ignore: non_constant_identifier_names

  late int qty;
  late String nama_barang,
      id_br_keluar,
      id_br_masuk,
      total,
      gambar,
      id,
      nama_pemesan,
      tanggal_pemesanan;

  BarangKeluarModel.fromjson(Map<String, dynamic> json) {
    this.id_br_keluar = json["id_br_keluar"];
    this.nama_barang = json["nama_barang"];
    this.qty = int.parse(json["qty"]);
    this.total = json["total"];
    this.gambar = json["gambar"];
    this.id = json["id"];
    this.nama_pemesan = json["nama_pemesan"];
    this.tanggal_pemesanan = json["tanggal_pemesanan"];
  }
  static List<BarangKeluarModel> produkkeluarlist = [];
}
