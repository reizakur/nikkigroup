part of '../SQFlite_service.dart';

class PendingProductQCDBhelper {
  //static var
  static PendingProductQCDBhelper _databaseHelper;
  static Database _database;
  PendingProductQCDBhelper._createInstance();

  //Main Table Name
  String productPendingTable = 'Pending_productQC_table';
  //id row
  static String colID = 'id_request';
  static String colSubmitTime = 'time_submit';
  static String colStatus = 'status';
  static String colActionType = 'action_type';
  //Idempiere Access
  static String colUserName = 'username';
  static String colUserID = 'userID';
  static String colPass = 'password';
  static String colRoleID = 'role_id';
  //Database Info
  static String colLocatorDBversion = 'locator_db_version';
  static String colProductDBversion = 'product_db_version';
  //standard attribute
  static String colProductID = 'product_id';
  static String colProductName = 'product_name';
  static String colProductValue = 'product_value';
  static String colProductIsConsignment = 'product_isConsignment';
  static String colProductStatus = 'product_status'; //Reject or Accept
  static String colProductRegistration =
      'product_registration'; //RFID OR BARCODE
  //
  Production a = Production();

  static String colLocatorID = 'locator_id';
  static String colLocatorName = 'locator_name';
  static String colOperatorID = 'operator_id';
  static String colOperatorName = 'operator_name';
  static String colRejectID = 'reject_id';
  static String colRejectName = 'reject_name';
  static String colImagePath = 'image_pic_path';

  factory PendingProductQCDBhelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = PendingProductQCDBhelper._createInstance();
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
    String path = directory.path + 'Pending_ProductQC.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $productPendingTable($colID TEXT PRIMARY KEY,$colSubmitTime TEXT,$colActionType TEXT,$colStatus TEXT,$colUserID TEXT,$colUserName TEXT,$colPass TEXT,$colRoleID TEXT,$colLocatorDBversion TEXT,$colProductDBversion TEXT,$colProductID TEXT,$colProductName TEXT,$colProductValue TEXT,$colProductIsConsignment TEXT,$colProductStatus TEXT,$colProductRegistration TEXT,$colLocatorID TEXT,$colLocatorName TEXT,$colOperatorID TEXT,$colOperatorName TEXT,$colRejectName TEXT,$colRejectID TEXT,$colImagePath TEXT)');
  }

  //CRUD OPERATION//

  Future<List<PendingProductQC>> getPendingProductQCList() async {
    var pendingProductMap = await getPendingProductQCmap();
    int count = pendingProductMap.length;
    List<PendingProductQC> accountRoleList = [];
    for (int i = 0; i < count; i++) {
      accountRoleList.add(PendingProductQC.frommapObject(pendingProductMap[i]));
    }
    return accountRoleList;
  }

  getPendingProductQCmap() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $productPendingTable ORDER BY $colSubmitTime ASC');
    return result;
  }

  //insert operation
  Future<int> insertAccountRole(PendingProductQC pendingProductQC) async {
    Database db = await this.database;
    var result = await db.insert(productPendingTable, pendingProductQC.toMap());

    return result;
  }

  Future<void> updateStatus(
      {@required String id, @required String status}) async {
    Database db = await this.database;
    await db.execute(
        "UPDATE $productPendingTable SET $colStatus='$status' WHERE $colID='$id'");
  }

  //delete operation
  Future<int> deleteAllPendingProductQC() async {
    var db = await this.database;
    String sql = 'DELETE FROM $productPendingTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}
