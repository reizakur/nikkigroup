part of 'SQFlite_service.dart';

class LocatorXOperatorDBHelper {
  //static var
  static LocatorXOperatorDBHelper _databaseHelper;
  static Database _database;
  LocatorXOperatorDBHelper._createInstance();

  //dynamic var
  String locatorXOperatorTable = 'LocatorXOperator_table';

  String colCBpartnerName = "c_bpartner_name";
  String colCBpartnerId = "c_bpartner_id";
  String colMLocatorId = "m_locator_id";
  String colName = "name";
  String colAdClientId = "ad_client_id";
  String colAdRoleId = "ad_role_id";

  factory LocatorXOperatorDBHelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = LocatorXOperatorDBHelper._createInstance();
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
    String path = directory.path + 'LocatorXOperator.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $locatorXOperatorTable($colCBpartnerName TEXT, $colCBpartnerId TEXT,$colMLocatorId TEXT,$colName TEXT,$colAdClientId TEXT,$colAdRoleId TEXT)');
  }

  //CRUD OPERATION//
  Future<List<LocatorXOperator>> getGeneralData() async {
    var generalMap = await getGeneralMap();
    int count = generalMap.length;
    List<LocatorXOperator> locatorXoperatorList = [];
    for (int i = 0; i < count; i++) {
      locatorXoperatorList.add(LocatorXOperator.frommapObject(generalMap[i]));
    }
    return locatorXoperatorList;
  }

  getGeneralMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $locatorXOperatorTable');
    return result;
  }

  Future<List<Locator>> getLocatorList() async {
    var locatorMap = await getLocatorMap();
    int count = locatorMap.length;
    List<Locator> locatorList = [];
    for (int i = 0; i < count; i++) {
      locatorList.add(Locator.fromMapConvert(locatorMap[i]));
    }
    return locatorList;
  }

  getLocatorMap() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT DISTINCT $colMLocatorId,$colName FROM $locatorXOperatorTable');
    return result;
  }

  Future<List<Operator>> getOperatorList() async {
    var operatorMap = await getOperatorMap();
    int count = operatorMap.length;
    List<Operator> operatorList = [];
    for (int i = 0; i < count; i++) {
      operatorList.add(Operator.fromMapConvert(operatorMap[i]));
    }
    return operatorList;
  }

  getOperatorMap() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT DISTINCT $colCBpartnerId,$colCBpartnerName FROM $locatorXOperatorTable ');
    return result;
  }

  //insert operation
  Future<int> insertNewData(LocatorXOperator newData) async {
    Database db = await this.database;
    var result = await db.insert(locatorXOperatorTable, newData.toMap());
    return result;
  }

  //delete operation
  Future<int> deleteAllData() async {
    var db = await this.database;
    String sql = 'DELETE FROM $locatorXOperatorTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}
