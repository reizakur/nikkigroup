part of '../models.dart';

class PendingInOut {
  String colID;
  DateTime colSubmitTime;
  String colStatus = 'status';
  String colActionType = 'action_type'; //whether it's In or Out
  String colRoleType = 'role_type'; //whether it's production , warehouse etc..
  //Idempiere Access
  String colUserName = 'username';
  String colUserID = 'userID';
  String colPass = 'password';
  String colRoleID = 'role_id';
  //Database Info
  String colLocatorDBversion = 'locator_db_version';
  //standard attribute
  String colProductRegistration =
      'product_registration'; //whether its RFID or QR code
  Locator locator = Locator();
  String colImagePath = 'image_path';
  static List<PendingInOut> listofdata;
  PendingInOut();
  PendingInOut.insert({
    @required this.colStatus,
    @required this.colActionType,
    @required this.colRoleType,
    @required this.colUserName,
    @required this.colUserID,
    @required this.colPass,
    @required this.colRoleID,
    @required this.colLocatorDBversion,
    @required this.colProductRegistration,
    this.locator,
    this.colImagePath,
  }) {
    var uuid = Uuid();
    var uniqCode = uuid.v1();
    uniqCode = uniqCode.substring(1, 7);
    this.colID = 'Product QC-$uniqCode';
    this.colSubmitTime = DateTime.now();
  }

  void printAllData() {
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'Col ID $colID');
    PrintDebug.printDialog(
        id: pendingInOutModel, msg: 'Submit time $colSubmitTime');
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'Status $colStatus');
    PrintDebug.printDialog(
        id: pendingInOutModel, msg: 'Action Type $colActionType');
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'Username $colUserName');
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'colUserID $colUserID');
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(id: pendingInOutModel, msg: 'colRoleID $colRoleID');
    PrintDebug.printDialog(
        id: pendingInOutModel, msg: 'colLocatorDBversion $colLocatorDBversion');
    PrintDebug.printDialog(
        id: pendingInOutModel,
        msg: 'colProductRegistration $colProductRegistration');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'colImagePath $colImagePath');
  }

  bool isRequestExpired() {
    var expiredDate = this
        .colSubmitTime
        .add(Duration(days: PendingSettings.getExpiredDayThreshold()));
    DateTime now = DateTime.now();
    return now.isAfter(expiredDate);
  }

  String getSubmitTimeSTR() {
    var now = this.colSubmitTime;
    var result =
        '${now.day} ${DateFormat.MMMM().format(now).substring(0, 3)} ${now.year} ${DateFormat.jm().format(now)}';
    return result;
  }

  DateTime convertSTRtoDateTime({@required dateSTR}) {
    return DateTime.parse(dateSTR);
  }

  static Future<void> clearExpiredRequest() async {
    PrintDebug.printDialog(
        id: pendingInOutModel,
        msg:
            'PendingInOut before clear Expired Total :${PendingInOut.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingInOutModel,
        msg:
            'Expired threshold is ${PendingSettings.getExpiredDayThreshold()} days');

    PendingInOut.listofdata
        .removeWhere((request) => request.isRequestExpired());
    await PendingInOut.syncDatabase();
    PrintDebug.printDialog(
        id: pendingInOutModel,
        msg:
            'PendingInOut after clear Expired Total :${PendingInOut.listofdata.length}');
  }

  static Future<void> clearall() async {
    PendingInOut.listofdata = [];
    await databaseHelper.deleteAllPendingInOut();
    return;
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertData(this);
    PendingInOut.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = PendingInOut.listofdata;
    await PendingInOut.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertData(temp[i]);
    }
    PendingInOut.listofdata = await databaseHelper.getPendingInOutList();
    PrintDebug.printDialog(
        id: pendingInOutModel,
        msg:
            'Role PendingInOut Updates ! Total :${PendingInOut.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static PendingInOutDbHelper databaseHelper = PendingInOutDbHelper();
  PendingInOut.frommapObject(Map<String, dynamic> mapfromdb) {
    Locator locator = Locator();

    this.colID = mapfromdb[PendingInOutDbHelper.colID].toString();
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb[PendingInOutDbHelper.colSubmitTime]);
    this.colStatus = mapfromdb[PendingInOutDbHelper.colStatus];
    this.colActionType = mapfromdb[PendingInOutDbHelper.colActionType];
    this.colRoleType = mapfromdb[PendingInOutDbHelper.colRoleType];
    this.colUserName = mapfromdb[PendingInOutDbHelper.colUserName];
    this.colUserID = mapfromdb[PendingInOutDbHelper.colUserID];
    this.colPass = mapfromdb[PendingInOutDbHelper.colPass];
    this.colRoleID = mapfromdb[PendingInOutDbHelper.colRoleID];
    this.colLocatorDBversion =
        mapfromdb[PendingInOutDbHelper.colLocatorDBversion];
    this.colProductRegistration =
        mapfromdb[PendingInOutDbHelper.colProductRegistration];
    //locator
    locator.locatorID = mapfromdb[PendingInOutDbHelper.colLocatorID];
    locator.locatorName = mapfromdb[PendingInOutDbHelper.colLocatorName];
    this.locator = locator;
    this.colImagePath = mapfromdb[PendingInOutDbHelper.colImagePath];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[PendingInOutDbHelper.colID] = this.colID;
    map[PendingInOutDbHelper.colSubmitTime] = this.colSubmitTime.toString();
    map[PendingInOutDbHelper.colStatus] = this.colStatus;
    map[PendingInOutDbHelper.colActionType] = this.colActionType;
    map[PendingInOutDbHelper.colRoleType] = this.colRoleType;
    map[PendingInOutDbHelper.colUserName] = this.colUserName;
    map[PendingInOutDbHelper.colUserID] = this.colUserID;
    map[PendingInOutDbHelper.colPass] = this.colPass;
    map[PendingInOutDbHelper.colRoleID] = this.colRoleID;
    map[PendingInOutDbHelper.colLocatorDBversion] = this.colLocatorDBversion;
    //
    map[PendingInOutDbHelper.colProductRegistration] =
        this.colProductRegistration;
    //
    if (locator != null) {
      map[PendingInOutDbHelper.colLocatorID] = this.locator.locatorID;
      map[PendingInOutDbHelper.colLocatorName] = this.locator.locatorName;
    } else {
      map[PendingInOutDbHelper.colLocatorID] = 'No Locator data';
      map[PendingInOutDbHelper.colLocatorName] = 'No Locator data';
    }
    if (this.colImagePath != null || this.colImagePath != '') {
      map[PendingInOutDbHelper.colImagePath] = this.colImagePath;
    } else {
      map[PendingInOutDbHelper.colImagePath] = 'No image data';
    }
    //
    return map;
  }
}
