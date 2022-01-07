part of 'models.dart';

class ControlReject {
  String rejectName = 'default';
  String rejectID = 'default';
  static List<ControlReject> listofdata;

  ControlReject();
  static Future<void> clearAll() async {
    ControlReject.listofdata = [];
    await databaseHelper.deleteAllControlReject();
    return;
  }

  static Future<void> updateDatabase() async {
    var temp = ControlReject.listofdata;
    ControlReject.listofdata = [];
    await databaseHelper.deleteAllControlReject();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertControlReject(temp[i]);
    }
    ControlReject.listofdata = await databaseHelper.getControlRejectList();
    PrintDebug.printDialog(
        id: idempiereControlRejectService,
        msg:
            'ControlReject DB Updates ! Total :${ControlReject.listofdata.length}');

    return;
  }

  void displayInformation() {
    PrintDebug.printDialog(
        id: idempiereControlRejectService,
        msg: 'ControlReject ID   :${this.rejectID}');
    PrintDebug.printDialog(
        id: idempiereControlRejectService,
        msg: 'ControlReject Name :${this.rejectName}');
  }

  static void displayAllControlReject() {
    for (int i = 0; i < ControlReject.listofdata.length; i++) {
      PrintDebug.printDialog(
          id: idempiereControlRejectService,
          msg:
              'Reject Name :${listofdata[i].rejectName} with ID :${listofdata[i].rejectID}');
    }
  }

  //SQFlite Operations
  static ControlRejectDBHelper databaseHelper = ControlRejectDBHelper();
  ControlReject.frommapObject(Map<String, dynamic> mapfromdb) {
    this.rejectID = mapfromdb['Reject_ID'];
    this.rejectName = mapfromdb['Reject_Name'];
  }
  ControlReject.fromMapConvert(Map<String, dynamic> mapfromdb) {
    this.rejectID = mapfromdb['ad_ref_list_id'];
    this.rejectName = mapfromdb['name'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Reject_ID'] = this.rejectID;
    map['Reject_Name'] = this.rejectName;
    return map;
  }
}
