part of '../models.dart';

class PendingInOutBranch {
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
  static List<PendingInOutBranch> listofdata;
  PendingInOutBranch();
  PendingInOutBranch.insert({
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
    PrintDebug.printDialog(id: pendingInOutBranchModel, msg: 'Col ID $colID');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'Submit time $colSubmitTime');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'Status $colStatus');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'Action Type $colActionType');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'Username $colUserName');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'colUserID $colUserID');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel, msg: 'colRoleID $colRoleID');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg: 'colLocatorDBversion $colLocatorDBversion');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
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
        id: pendingInOutBranchModel,
        msg:
            'PendingInOutBranch before clear Expired Total :${PendingInOutBranch.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg:
            'Expired threshold is ${PendingSettings.getExpiredDayThreshold()} days');

    PendingInOutBranch.listofdata
        .removeWhere((request) => request.isRequestExpired());
    await PendingInOutBranch.syncDatabase();
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg:
            'PendingInOutBranch after clear Expired Total :${PendingInOutBranch.listofdata.length}');
  }

  static Future<void> clearall() async {
    PendingInOutBranch.listofdata = [];
    await databaseHelper.deleteAllPendingInOutBranch();
    return;
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertData(this);
    PendingInOutBranch.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = PendingInOutBranch.listofdata;
    await PendingInOutBranch.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertData(temp[i]);
    }
    PendingInOutBranch.listofdata =
        await databaseHelper.getPendingInOutBranchList();
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg:
            'Role PendingInOutBranch Updates ! Total :${PendingInOutBranch.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static PendingInOutBranchDbHelper databaseHelper =
      PendingInOutBranchDbHelper();
  PendingInOutBranch.frommapObject(Map<String, dynamic> mapfromdb) {
    Locator locator = Locator();

    this.colID = mapfromdb[PendingInOutBranchDbHelper.colID].toString();
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb[PendingInOutBranchDbHelper.colSubmitTime]);
    this.colStatus = mapfromdb[PendingInOutBranchDbHelper.colStatus];
    this.colActionType = mapfromdb[PendingInOutBranchDbHelper.colActionType];
    this.colRoleType = mapfromdb[PendingInOutBranchDbHelper.colRoleType];
    this.colUserName = mapfromdb[PendingInOutBranchDbHelper.colUserName];
    this.colUserID = mapfromdb[PendingInOutBranchDbHelper.colUserID];
    this.colPass = mapfromdb[PendingInOutBranchDbHelper.colPass];
    this.colRoleID = mapfromdb[PendingInOutBranchDbHelper.colRoleID];
    this.colLocatorDBversion =
        mapfromdb[PendingInOutBranchDbHelper.colLocatorDBversion];
    this.colProductRegistration =
        mapfromdb[PendingInOutBranchDbHelper.colProductRegistration];
    //locator
    locator.locatorID = mapfromdb[PendingInOutBranchDbHelper.colLocatorID];
    locator.locatorName = mapfromdb[PendingInOutBranchDbHelper.colLocatorName];
    this.locator = locator;
    this.colImagePath = mapfromdb[PendingInOutBranchDbHelper.colImagePath];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[PendingInOutBranchDbHelper.colID] = this.colID;
    map[PendingInOutBranchDbHelper.colSubmitTime] =
        this.colSubmitTime.toString();
    map[PendingInOutBranchDbHelper.colStatus] = this.colStatus;
    map[PendingInOutBranchDbHelper.colActionType] = this.colActionType;
    map[PendingInOutBranchDbHelper.colRoleType] = this.colRoleType;
    map[PendingInOutBranchDbHelper.colUserName] = this.colUserName;
    map[PendingInOutBranchDbHelper.colUserID] = this.colUserID;
    map[PendingInOutBranchDbHelper.colPass] = this.colPass;
    map[PendingInOutBranchDbHelper.colRoleID] = this.colRoleID;
    map[PendingInOutBranchDbHelper.colLocatorDBversion] =
        this.colLocatorDBversion;
    //
    map[PendingInOutBranchDbHelper.colProductRegistration] =
        this.colProductRegistration;
    //
    if (locator != null) {
      map[PendingInOutBranchDbHelper.colLocatorID] = this.locator.locatorID;
      map[PendingInOutBranchDbHelper.colLocatorName] = this.locator.locatorName;
    } else {
      map[PendingInOutBranchDbHelper.colLocatorID] = 'No Locator data';
      map[PendingInOutBranchDbHelper.colLocatorName] = 'No Locator data';
    }
    if (this.colImagePath != null || this.colImagePath != '') {
      map[PendingInOutBranchDbHelper.colImagePath] = this.colImagePath;
    } else {
      map[PendingInOutBranchDbHelper.colImagePath] = 'No image data';
    }
    //
    return map;
  }
}
