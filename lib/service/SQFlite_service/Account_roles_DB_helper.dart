part of 'SQFlite_service.dart';

class AccountRolesDBHelper {
  //static var
  static AccountRolesDBHelper _databaseHelper;
  static  Database _database;
  AccountRolesDBHelper._createInstance();

  //dynamic var
  String accountRoleTable = 'AccountRoles_table';
  String colRoleID = 'Role_ID';
  String colRoleName = 'Role_Name';
  //named construc to create instance of databasehelper..method is custom ?

  factory AccountRolesDBHelper() {
    // ignore: unnecessary_null_comparison
     if (_databaseHelper == null) {
       _databaseHelper = AccountRolesDBHelper._createInstance();
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
    String path = directory.path + 'AccountRoles.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newver) async {
    await db.execute(
        'CREATE TABLE $accountRoleTable($colRoleID TEXT, $colRoleName TEXT)');
  }

  //CRUD OPERATION//

  Future<List<AccountRoles>> getAccountRoleList() async {
    var accountRolesMap = await getAccountRoleMap();
    int count = accountRolesMap.length;
    List<AccountRoles> accountRoleList = [];
    for (int i = 0; i < count; i++) {
      accountRoleList.add(AccountRoles.frommapObject(accountRolesMap[i]));
    }
    return accountRoleList;
  }

  getAccountRoleMap() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $accountRoleTable');
    return result;
  }

  //insert operation
  Future<int> insertAccountRole(AccountRoles accountRole) async {
    Database db = await this.database;
    var result = await db.insert(accountRoleTable, accountRole.toMap());
    //var result_raw = await db.rawInsert('INSERT INTO $accountRoleTable($colRoleID, $colRoleName,$colDescription,$colPriority,$colDate) VALUES(${note.id},${note.title},${note.description},${note.priority},${note.date})');
    return result;
  }

  //delete operation
  Future<int> deleteAllAccountRoles() async {
    var db = await this.database;
    String sql = 'DELETE FROM $accountRoleTable';
    var result = await db.rawDelete(sql);
    return result;
  }
}

