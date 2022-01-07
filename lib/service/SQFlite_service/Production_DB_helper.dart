part of 'SQFlite_service.dart';

class ProductDBhelper {
  //static var
  static ProductDBhelper _databaseHelper;
  static Database _database;
  ProductDBhelper._createInstance();

  //dynamic var
  final String productTable = 'Product_table';
  final String colProductID = 'Product_ID';
  final String colProductName = 'Product_Name';
  final String colProductValue = 'Product_Value';
  final String colProductIsConsignment = 'Product_IsConsignment';

  //named construc to create instance of databasehelper..method is custom ?

  factory ProductDBhelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = ProductDBhelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'Product.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $productTable($colProductID TEXT, $colProductName TEXT, $colProductValue TEXT, $colProductIsConsignment TEXT)');
  }

  //CRUD OPERATION//

  Future<List<Production>> getProductList() async {
    var productMap = await getProductMap();
    int count = productMap.length;
    List<Production> productList = [];
    for (int i = 0; i < count; i++) {
      productList.add(Production.frommapObject(productMap[i]));
    }
    return productList;
  }

  getProductMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $productTable');
    return result;
  }

  //insert operation
  Future<int> insertProduct(Production product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap());
    //var result_raw = await db.rawInsert('INSERT INTO $productTable($colProductID, $colProductName,$colDescription,$colPriority,$colDate) VALUES(${note.id},${note.title},${note.description},${note.priority},${note.date})');
    return result;
  }

  //delete operation
  Future<int> deleteAllProduct() async {
    var db = await this.database;
    String sql = 'DELETE FROM $productTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}
