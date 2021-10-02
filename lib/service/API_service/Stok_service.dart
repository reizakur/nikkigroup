part of'API_service.dart';

class APIStockService {
  static UserData userData = UserData();

  Future<int> tambahStok({
    required String newStok,
    required String idBarang,
    required String oldStock,
  }) async {
    try {
      final responseku = await http.post(Uri.parse(BaseUrl.tambah_stok), body: {
        "id_barang": idBarang,
        "new_stock": newStok,
        "old_stock":oldStock,
      });
      var data = jsonDecode(responseku.body);
      if (data['result'] == '1') {        
        return 0;
      } else {
        return 1; //invalid
      }
    } on Exception {
      return 3; //something went wrong
    }
  }
  
}
