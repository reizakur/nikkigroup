part of 'models.dart';

class Operator {
  Operator();

  String operatorName;
  String operatorID;

  Operator.create({@required String text, @required String id}) {
    this.operatorName = text;
    this.operatorID = id;
  }
  static Future<void> clearAll() async {
    Operator.listofdata = [];
    await databaseHelper.deleteAllLocator();
    return;
  }

  String get getOperatorName => operatorName;
  String get getOperatorID => operatorID;

  static List<Operator> listofdata = [];
  // //SQFlite Operations
  static Future<void> updateDatabase() async {
    var temp = Operator.listofdata;
    Operator.listofdata = [];
    await databaseHelper.deleteAllLocator();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertLocator(temp[i]);
    }
    Operator.listofdata = await databaseHelper.getLocatorList();
    PrintDebug.printDialog(
        id: idempiereLocatorService,
        msg: 'Operator DB Updates ! Total :${Operator.listofdata.length}');

    return;
  }

  static OperatorDBHelper databaseHelper = OperatorDBHelper();
  Operator.frommapObject(Map<String, dynamic> mapfromdb) {
    this.operatorID = mapfromdb['Operator_ID'];
    this.operatorName = mapfromdb['Operator_Name'];
  }
  Operator.fromMapConvert(Map<String, dynamic> mapfromdb) {
    this.operatorID = mapfromdb['c_bpartner_id'];
    this.operatorName = mapfromdb['c_bpartner_name'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Operator_ID'] = this.operatorID;
    map['Operator_Name'] = this.operatorName;
    return map;
  }
}
