part of '../models.dart';

class PendingInOutWarehouseBranch {
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
  static List<PendingInOutWarehouseBranch> listofdata;
  PendingInOutWarehouseBranch();
  PendingInOutWarehouseBranch.insert({
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
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'Col ID $colID');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel,
        msg: 'Submit time $colSubmitTime');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'Status $colStatus');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel,
        msg: 'Action Type $colActionType');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'Username $colUserName');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'colUserID $colUserID');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel, msg: 'colRoleID $colRoleID');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel,
        msg: 'colLocatorDBversion $colLocatorDBversion');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel,
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
        id: pendingInOutWarehouseBranchModel,
        msg:
            'PendingInOutWarehouse before clear Expired Total :${PendingInOutWarehouseBranch.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel,
        msg:
            'Expired threshold is ${PendingSettings.getExpiredDayThreshold()} days');

    PendingInOutWarehouseBranch.listofdata
        .removeWhere((request) => request.isRequestExpired());
    await PendingInOutWarehouseBranch.syncDatabase();
    PrintDebug.printDialog(
        id: pendingInOutWarehouseBranchModel,
        msg:
            'PendingInOutWarehouseBranch after clear Expired Total :${PendingInOutWarehouseBranch.listofdata.length}');
  }

  static Future<void> clearall() async {
    PendingInOutWarehouseBranch.listofdata = [];
    await databaseHelper.deleteAllPendingInOutWarehouseBranch();
    return;
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertDataWHBranch(this);
    PendingInOutWarehouseBranch.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = PendingInOutWarehouseBranch.listofdata;
    await PendingInOutWarehouseBranch.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertDataWHBranch(temp[i]);
    }
    PendingInOutWarehouseBranch.listofdata =
        await databaseHelper.getPendingInOutWarehouseBranchList();
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel,
        msg:
            'Role PendingInOutWarehouse Updates ! Total :${PendingInOutWarehouseBranch.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static PendingInOutWarehouseBranchDbHelper databaseHelper =
      PendingInOutWarehouseBranchDbHelper();
  PendingInOutWarehouseBranch.frommapObject(Map<String, dynamic> mapfromdb) {
    Locator locator = Locator();

    this.colID =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colID].toString();
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb[PendingInOutWarehouseBranchDbHelper.colSubmitTime]);
    this.colStatus = mapfromdb[PendingInOutWarehouseBranchDbHelper.colStatus];
    this.colActionType =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colActionType];
    this.colRoleType =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colRoleType];
    this.colUserName =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colUserName];
    this.colUserID = mapfromdb[PendingInOutWarehouseBranchDbHelper.colUserID];
    this.colPass = mapfromdb[PendingInOutWarehouseBranchDbHelper.colPass];
    this.colRoleID = mapfromdb[PendingInOutWarehouseBranchDbHelper.colRoleID];
    this.colLocatorDBversion =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colLocatorDBversion];
    this.colProductRegistration =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colProductRegistration];
    //locator
    locator.locatorID =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colLocatorID];
    locator.locatorName =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colLocatorName];
    this.locator = locator;
    this.colImagePath =
        mapfromdb[PendingInOutWarehouseBranchDbHelper.colImagePath];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[PendingInOutWarehouseBranchDbHelper.colID] = this.colID;
    map[PendingInOutWarehouseBranchDbHelper.colSubmitTime] =
        this.colSubmitTime.toString();
    map[PendingInOutWarehouseBranchDbHelper.colStatus] = this.colStatus;
    map[PendingInOutWarehouseBranchDbHelper.colActionType] = this.colActionType;
    map[PendingInOutWarehouseBranchDbHelper.colRoleType] = this.colRoleType;
    map[PendingInOutWarehouseBranchDbHelper.colUserName] = this.colUserName;
    map[PendingInOutWarehouseBranchDbHelper.colUserID] = this.colUserID;
    map[PendingInOutWarehouseBranchDbHelper.colPass] = this.colPass;
    map[PendingInOutWarehouseBranchDbHelper.colRoleID] = this.colRoleID;
    map[PendingInOutWarehouseBranchDbHelper.colLocatorDBversion] =
        this.colLocatorDBversion;
    //
    map[PendingInOutWarehouseBranchDbHelper.colProductRegistration] =
        this.colProductRegistration;
    //
    if (locator != null) {
      map[PendingInOutWarehouseBranchDbHelper.colLocatorID] =
          this.locator.locatorID;
      map[PendingInOutWarehouseBranchDbHelper.colLocatorName] =
          this.locator.locatorName;
    } else {
      map[PendingInOutWarehouseBranchDbHelper.colLocatorID] = 'No Locator data';
      map[PendingInOutWarehouseBranchDbHelper.colLocatorName] =
          'No Locator data';
    }
    if (this.colImagePath != null || this.colImagePath != '') {
      map[PendingInOutWarehouseBranchDbHelper.colImagePath] = this.colImagePath;
    } else {
      map[PendingInOutWarehouseBranchDbHelper.colImagePath] = 'No image data';
    }
    //
    return map;
  }
}
