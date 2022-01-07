part of 'models.dart';

class AccountRoles {
  String roleName = 'default';
  String adRoleID = 'default';
  static List<AccountRoles> listofdata;

  AccountRoles();
  static Future<void> clearall() async {
    AccountRoles.listofdata = [];
    await databaseHelper.deleteAllAccountRoles();
    return;
  }

  static Future<void> updateDatabase() async {
    var temp = AccountRoles.listofdata;
    await AccountRoles.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertAccountRole(temp[i]);
    }
    AccountRoles.listofdata = await databaseHelper.getAccountRoleList();
    PrintDebug.printDialog(
        id: idempiereAccountService,
        msg: 'Role DB Updates ! Total :${AccountRoles.listofdata.length}');
    return;
  }

  void displayInformation() {
    PrintDebug.printDialog(
        id: idempiereAccountService, msg: 'Role ID   :${this.adRoleID}');
    PrintDebug.printDialog(
        id: idempiereAccountService, msg: 'Role Name :${this.roleName}');
  }

  static void displayAllRoles() {
    for (int i = 0; i < AccountRoles.listofdata.length; i++) {
      PrintDebug.printDialog(
          id: idempiereAccountService,
          msg:
              'Role Name :${listofdata[i].roleName} with ID :${listofdata[i].adRoleID}');
    }
  }

  //SQFlite Operations
  static AccountRolesDBHelper databaseHelper = AccountRolesDBHelper();
  AccountRoles.frommapObject(Map<String, dynamic> mapfromdb) {
    this.adRoleID = mapfromdb['Role_ID'];
    this.roleName = mapfromdb['Role_Name'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Role_ID'] = this.adRoleID;
    map['Role_Name'] = this.roleName;
    return map;
  }
}

