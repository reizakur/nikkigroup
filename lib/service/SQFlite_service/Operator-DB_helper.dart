part of 'SQFlite_service.dart';

class OperatorDBHelper {
  //static var
  static OperatorDBHelper _databaseHelper;
  static Database _database;
  OperatorDBHelper._createInstance();

  //dynamic var
  String operatorTable = 'Operator_table';
  String colOperatorID = 'Operator_ID';
  String colOperatorName = 'Operator_Name';
  //named construc to create instance of databasehelper..method is custom ?

  factory OperatorDBHelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = OperatorDBHelper._createInstance();
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
    String path = directory.path + 'Operator.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $operatorTable($colOperatorID TEXT, $colOperatorName TEXT)');
  }

  //CRUD OPERATION//

  Future<List<Operator>> getLocatorList() async {
    var locatorMap = await getLocatorMap();
    int count = locatorMap.length;
    List<Operator> locatorList = [];
    for (int i = 0; i < count; i++) {
      locatorList.add(Operator.frommapObject(locatorMap[i]));
    }
    return locatorList;
  }

  getLocatorMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $operatorTable');
    return result;
  }

  //insert operation
  Future<int> insertLocator(Operator locator) async {
    Database db = await this.database;
    var result = await db.insert(operatorTable, locator.toMap());
    //var result_raw = await db.rawInsert('INSERT INTO $operatorTable($colLocatorID, $colLocatorName,$colDescription,$colPriority,$colDate) VALUES(${note.id},${note.title},${note.description},${note.priority},${note.date})');
    return result;
  }

  //delete operation
  Future<int> deleteAllLocator() async {
    var db = await this.database;
    String sql = 'DELETE FROM $operatorTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}
