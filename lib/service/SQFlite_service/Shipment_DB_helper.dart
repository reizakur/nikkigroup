part of 'SQFlite_service.dart';

class ShipmentDBHelper {
  //static var
  static ShipmentDBHelper _databaseHelper;
  static Database _database;
  ShipmentDBHelper._createInstance();

  //dynamic var
  String shipmentTable = 'Shipment_table';
  String colSPID = 'Shipment_ID';
  String colSPOptional = 'Shipment_Optional';
  String colSPContent = 'Shipment_Content';
  String colStatus = 'Shipment_Status';
  String colSPProductionID = 'Shipment_Production_ID';
  String colSPProductionOptional = 'Shipment_Production_Optional';
  String colSPProductionContent = 'Shipment_Production_Content';
  String colSubmitTime = 'Shipment_Production_colSubmitTime';
  //named construc to create instance of databasehelper..method is custom ?

  factory ShipmentDBHelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = ShipmentDBHelper._createInstance();
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
    String path = directory.path + 'Shipment.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $shipmentTable($colSPID TEXT, $colSPOptional TEXT,$colSPContent TEXT,$colSPProductionID TEXT,$colSPProductionOptional TEXT,$colSPProductionContent TEXT,$colSubmitTime TEXT,$colStatus TEXT)');
  }

  //CRUD OPERATION//
  Future<List<Shipment>> getShipmentListDinstic() async {
    var shipmentMap = await getShipmentMapDinstic();
    int count = shipmentMap.length;
    List<Shipment> shipmentList = [];
    for (int i = 0; i < count; i++) {
      shipmentList.add(Shipment.frommapObject(shipmentMap[i]));
    }
    return shipmentList;
  }

  getShipmentMapDinstic() async {
    Database db = await this.database;
    var result = await db
        .rawQuery('SELECT * FROM $shipmentTable group by $colSPContent');
    return result;
  }

  Future<List<Shipment>> getShipmentList() async {
    var shipmentMap = await getShipmentMap();
    int count = shipmentMap.length;
    List<Shipment> shipmentList = [];
    for (int i = 0; i < count; i++) {
      shipmentList.add(Shipment.frommapObject(shipmentMap[i]));
    }
    return shipmentList;
  }

  getShipmentMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $shipmentTable');
    return result;
  }

  //insert operation
  Future<int> insertShipment(Shipment shipment) async {
    Database db = await this.database;
    var result = await db.insert(shipmentTable, shipment.toMap());
    //var result_raw = await db.rawInsert('INSERT INTO $locatorTable($colLocatorID, $colLocatorName,$colDescription,$colPriority,$colDate) VALUES(${note.id},${note.title},${note.description},${note.priority},${note.date})');
    return result;
  }

  Future<void> updateStatus(
      {@required String id, @required String status}) async {
    Database db = await this.database;
    await db.execute(
        "UPDATE $shipmentTable SET $colStatus='$status' WHERE $colSPID='$id'");
  }

  //delete operation
  Future<int> deleteAllShipment() async {
    var db = await this.database;
    String sql = 'DELETE FROM $shipmentTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}
