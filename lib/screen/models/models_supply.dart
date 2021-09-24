class SupplyModel {
  SupplyModel.init() {
    this.nama_perusahaan = 'Coffe Name';
    this.no_hp = 0;
  }

  // ignore: non_constant_identifier_names
  late String id_supply, nama_perusahaan, alamat, tanggal;
  late int no_hp;

  SupplyModel.fromjson(Map<String, dynamic> json) {
    this.id_supply = json["id_supply"];
    this.nama_perusahaan = json["nama_perusahaan"];
    this.alamat = json["alamat"];
    this.no_hp = int.parse(json["no_hp"]);
    this.tanggal = json["tanggal"];
  }
  static List<SupplyModel> supplylist = [];
}
