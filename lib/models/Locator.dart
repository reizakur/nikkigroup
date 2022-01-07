part of 'models.dart';

class Locator {
  String locatorName = 'default';
  String locatorID = 'default';
  static List<Locator> listofdata;

  Locator();
  static Future<void> clearAll() async {
    Locator.listofdata = [];
    await databaseHelper.deleteAllLocator();
    return;
  }

  static Future<void> updateDatabase() async {
    var temp = Locator.listofdata;
    Locator.listofdata = [];
    await databaseHelper.deleteAllLocator();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertLocator(temp[i]);
    }
    Locator.listofdata = await databaseHelper.getLocatorList();
    PrintDebug.printDialog(
        id: idempiereLocatorService,
        msg: 'Locator DB Updates ! Total :${Locator.listofdata.length}');

    return;
  }

  void displayInformation() {
    PrintDebug.printDialog(
        id: idempiereLocatorService, msg: 'Locator ID   :${this.locatorID}');
    PrintDebug.printDialog(
        id: idempiereLocatorService, msg: 'Locator Name :${this.locatorName}');
  }

  static void displayAllLocator() {
    for (int i = 0; i < Locator.listofdata.length; i++) {
      PrintDebug.printDialog(
          id: idempiereLocatorService,
          msg:
              'Locator Name :${listofdata[i].locatorName} with ID :${listofdata[i].locatorID}');
    }
  }

  //SQFlite Operations
  static LocatorDBHelper databaseHelper = LocatorDBHelper();
  Locator.frommapObject(Map<String, dynamic> mapfromdb) {
    this.locatorID = mapfromdb['Locator_ID'];
    this.locatorName = mapfromdb['Locator_Name'];
  }
  Locator.fromMapConvert(Map<String, dynamic> mapfromdb) {
    this.locatorID = mapfromdb['m_locator_id'];
    this.locatorName = mapfromdb['name'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Locator_ID'] = this.locatorID;
    map['Locator_Name'] = this.locatorName;
    return map;
  }
}
