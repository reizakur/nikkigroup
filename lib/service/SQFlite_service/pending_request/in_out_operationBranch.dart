part of '../SQFlite_service.dart';

class PendingInOutBranchDbHelper {
  //static var
  static PendingInOutBranchDbHelper _databaseHelper;
  static Database _database;
  PendingInOutBranchDbHelper._createInstance();

  //Main Table Name
  String inOutTable = 'Pending_in_out_branch_table';
  //id row
  static String colID = 'id_request'; //primary key , generated using UUID
  static String colSubmitTime = 'time_submit'; //time submit on flutter
  static String colStatus = 'status'; //whether pending,error or successfully
  static String colActionType = 'action_type'; //whether it's in or out
  static String colRoleType =
      'role_type'; //whether it's production , warehouse etc..

  //Idempiere Access
  static String colUserName = 'username';
  static String colUserID = 'userID';
  static String colPass = 'password';
  static String colRoleID = 'role_id';
  //Database Info
  static String colLocatorDBversion = 'locator_db_version';
  //standard attribute
  static String colProductRegistration =
      'product_registration'; //RFID OR BARCODE

  static String colLocatorID = 'locator_id';
  static String colLocatorName = 'locator_name';
  static String colImagePath = 'image_path';

  factory PendingInOutBranchDbHelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = PendingInOutBranchDbHelper._createInstance();
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
    String path = directory.path + 'In_Out_Branch.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $inOutTable($colID TEXT PRIMARY KEY,$colSubmitTime TEXT,$colStatus TEXT,$colActionType TEXT,$colRoleType TEXT,$colUserName TEXT,$colUserID TEXT,$colPass TEXT,$colRoleID TEXT,$colLocatorDBversion TEXT,$colProductRegistration TEXT,$colLocatorID TEXT,$colLocatorName TEXT,$colImagePath TEXT)');
  }

  //CRUD OPERATION//

  Future<List<PendingInOutBranch>> getPendingInOutBranchList() async {
    var map = await getPendingInOutMap();
    int count = map.length;
    List<PendingInOutBranch> accountRoleList = [];
    for (int i = 0; i < count; i++) {
      accountRoleList.add(PendingInOutBranch.frommapObject(map[i]));
    }
    return accountRoleList;
  }

  getPendingInOutMap() async {
    Database db = await this.database;
    var result = await db
        .rawQuery('SELECT * FROM $inOutTable ORDER BY $colSubmitTime ASC');
    return result;
  }

  //insert operation
  Future<int> insertData(PendingInOutBranch pendingInOutBranch) async {
    Database db = await this.database;
    var result = await db.insert(inOutTable, pendingInOutBranch.toMap());

    return result;
  }

  Future<void> updateStatus(
      {@required String id, @required String status}) async {
    Database db = await this.database;
    await db.execute(
        "UPDATE $inOutTable SET $colStatus='$status' WHERE $colID='$id'");
  }

  //delete operation
  Future<int> deleteAllPendingInOutBranch() async {
    var db = await this.database;
    String sql = 'DELETE FROM $inOutTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}