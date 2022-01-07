part of 'SQFlite_service.dart';

class ControlRejectDBHelper {
  //static var
  static ControlRejectDBHelper _databaseHelper;
  static Database _database;
  ControlRejectDBHelper._createInstance();

  //dynamic var
  String rejectTable = 'Reject_table';
  String colRejectID = 'Reject_ID';
  String colRejectName = 'Reject_Name';
  //named construc to create instance of databasehelper..method is custom ?

  factory ControlRejectDBHelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = ControlRejectDBHelper._createInstance();
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
    String path = directory.path + 'ControlReject.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $rejectTable($colRejectID TEXT, $colRejectName TEXT)');
  }

  //CRUD OPERATION//

  Future<List<ControlReject>> getControlRejectList() async {
    var rejectMap = await getControlRejectMap();
    int count = rejectMap.length;
    List<ControlReject> rejectList = [];
    for (int i = 0; i < count; i++) {
      rejectList.add(ControlReject.frommapObject(rejectMap[i]));
    }
    return rejectList;
  }

  getControlRejectMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $rejectTable');
    return result;
  }

  //insert operation
  Future<int> insertControlReject(ControlReject reject) async {
    Database db = await this.database;
    var result = await db.insert(rejectTable, reject.toMap());
    //var result_raw = await db.rawInsert('INSERT INTO $locatorTable($colLocatorID, $colLocatorName,$colDescription,$colPriority,$colDate) VALUES(${note.id},${note.title},${note.description},${note.priority},${note.date})');
    return result;
  }

  //delete operation
  Future<int> deleteAllControlReject() async {
    var db = await this.database;
    String sql = 'DELETE FROM $rejectTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}
