part of 'SQFlite_service.dart';

class LocatorDBHelper {
  //static var
  static LocatorDBHelper _databaseHelper;
  static  Database _database;
  LocatorDBHelper._createInstance();

  //dynamic var
  String locatorTable = 'Locator_table';
  String colLocatorID = 'Locator_ID';
  String colLocatorName = 'Locator_Name';
  //named construc to create instance of databasehelper..method is custom ?

  factory LocatorDBHelper() {
    // ignore: unnecessary_null_comparison
     if (_databaseHelper == null) {
       _databaseHelper = LocatorDBHelper._createInstance();
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
    String path = directory.path + 'Locator.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $locatorTable($colLocatorID TEXT, $colLocatorName TEXT)');
  }

  //CRUD OPERATION//

  Future<List<Locator>> getLocatorList() async {
    var locatorMap = await getLocatorMap();
    int count = locatorMap.length;
    List<Locator> locatorList = [];
    for (int i = 0; i < count; i++) {
      locatorList.add(Locator.frommapObject(locatorMap[i]));
    }
    return locatorList;
  }

  getLocatorMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $locatorTable');
    return result;
  }

  //insert operation
  Future<int> insertLocator(Locator locator) async {
    Database db = await this.database;
    var result = await db.insert(locatorTable, locator.toMap());
    //var result_raw = await db.rawInsert('INSERT INTO $locatorTable($colLocatorID, $colLocatorName,$colDescription,$colPriority,$colDate) VALUES(${note.id},${note.title},${note.description},${note.priority},${note.date})');
    return result;
  }

  //delete operation
  Future<int> deleteAllLocator() async {
    var db = await this.database;
    String sql = 'DELETE FROM $locatorTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}

