part of 'models.dart';

class LocatorXOperator {
  String cBpartnerName = "No Data";
  String cBpartnerId = "No Data";
  String mLocatorId = "No Data";
  String name = "No Data";
  String adClientId = "No Data";
  String adRoleId = "No Data";
  static List<LocatorXOperator> listofdata;

  void showInfo() {
    print("cbpartner name : ${this.cBpartnerName}");
    print("cbpartner id :${this.cBpartnerId}");
    print("locator id : ${this.mLocatorId}");
    print("locator name : ${this.name}");
    print("client id : ${this.adClientId}");
    print("role id : ${this.adRoleId}");
  }

  LocatorXOperator();
  static Future<void> clearAll() async {
    LocatorXOperator.listofdata = [];
    await databaseHelper.deleteAllData();
    return;
  }

  static Future<void> updateDatabase() async {
    var temp = LocatorXOperator.listofdata;
    LocatorXOperator.listofdata = [];
    await databaseHelper.deleteAllData();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertNewData(temp[i]);
    }
    LocatorXOperator.listofdata = await databaseHelper.getGeneralData();
    Locator.listofdata = await databaseHelper.getLocatorList();
    Operator.listofdata = await databaseHelper.getOperatorList();
    PrintDebug.printDialog(
        id: idempiereLocatorXOperatorService,
        msg: 'Locator DB Updates ! Total :${Locator.listofdata.length}');
    PrintDebug.printDialog(
        id: idempiereLocatorXOperatorService,
        msg: 'Operator DB Updates ! Total :${Operator.listofdata.length}');
    PrintDebug.printDialog(
        id: idempiereLocatorXOperatorService,
        msg:
            'LocXop DB Updates ! Total :${LocatorXOperator.listofdata.length}');

    return;
  }

  static void displayAllLocator() {
    for (int i = 0; i < Locator.listofdata.length; i++) {
      PrintDebug.printDialog(
          id: idempiereLocatorXOperatorService,
          msg:
              'Locator Name :${listofdata[i].name} with ID :${listofdata[i].mLocatorId}');
    }
  }

  //SQFlite Operations
  static LocatorXOperatorDBHelper databaseHelper = LocatorXOperatorDBHelper();
  LocatorXOperator.frommapObject(Map<String, dynamic> mapfromdb) {
    this.cBpartnerName = mapfromdb['c_bpartner_name'];
    this.cBpartnerId = mapfromdb['c_bpartner_id'];
    this.mLocatorId = mapfromdb['m_locator_id'];
    this.name = mapfromdb['name'];
    this.adClientId = mapfromdb['ad_client_id'];
    this.adRoleId = mapfromdb['ad_role_id'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['c_bpartner_name'] = this.cBpartnerName;
    map['c_bpartner_id'] = this.cBpartnerId;
    map['m_locator_id'] = this.mLocatorId;
    map['name'] = this.name;
    map['ad_client_id'] = this.adClientId;
    map['ad_role_id'] = this.adRoleId;

    return map;
  }
}
