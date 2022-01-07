part of '../models.dart';

class PendingInOutWarehouse {
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
  static List<PendingInOutWarehouse> listofdata;
  PendingInOutWarehouse();
  PendingInOutWarehouse.insert({
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
        id: pendingInOutWarehouseModel, msg: 'Col ID $colID');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'Submit time $colSubmitTime');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'Status $colStatus');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'Action Type $colActionType');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'Username $colUserName');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'colUserID $colUserID');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel, msg: 'colRoleID $colRoleID');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel,
        msg: 'colLocatorDBversion $colLocatorDBversion');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel,
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
        id: pendingInOutWarehouseModel,
        msg:
            'PendingInOutWarehouse before clear Expired Total :${PendingInOutWarehouse.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel,
        msg:
            'Expired threshold is ${PendingSettings.getExpiredDayThreshold()} days');

    PendingInOutWarehouse.listofdata
        .removeWhere((request) => request.isRequestExpired());
    await PendingInOutWarehouse.syncDatabase();
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel,
        msg:
            'PendingInOutWarehouse after clear Expired Total :${PendingInOutWarehouse.listofdata.length}');
  }

  static Future<void> clearall() async {
    PendingInOutWarehouse.listofdata = [];
    await databaseHelper.deleteAllPendingInOutWarehouse();
    return;
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertData(this);
    PendingInOutWarehouse.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = PendingInOutWarehouse.listofdata;
    await PendingInOutWarehouse.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertData(temp[i]);
    }
    PendingInOutWarehouse.listofdata =
        await databaseHelper.getPendingInOutWarehouseList();
    PrintDebug.printDialog(
        id: pendingInOutWarehouseModel,
        msg:
            'Role PendingInOutWarehouse Updates ! Total :${PendingInOutWarehouse.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static PendingInOutWarehouseDbHelper databaseHelper =
      PendingInOutWarehouseDbHelper();
  PendingInOutWarehouse.frommapObject(Map<String, dynamic> mapfromdb) {
    Locator locator = Locator();

    this.colID = mapfromdb[PendingInOutWarehouseDbHelper.colID].toString();
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb[PendingInOutWarehouseDbHelper.colSubmitTime]);
    this.colStatus = mapfromdb[PendingInOutWarehouseDbHelper.colStatus];
    this.colActionType = mapfromdb[PendingInOutWarehouseDbHelper.colActionType];
    this.colRoleType = mapfromdb[PendingInOutWarehouseDbHelper.colRoleType];
    this.colUserName = mapfromdb[PendingInOutWarehouseDbHelper.colUserName];
    this.colUserID = mapfromdb[PendingInOutWarehouseDbHelper.colUserID];
    this.colPass = mapfromdb[PendingInOutWarehouseDbHelper.colPass];
    this.colRoleID = mapfromdb[PendingInOutWarehouseDbHelper.colRoleID];
    this.colLocatorDBversion =
        mapfromdb[PendingInOutWarehouseDbHelper.colLocatorDBversion];
    this.colProductRegistration =
        mapfromdb[PendingInOutWarehouseDbHelper.colProductRegistration];
    //locator
    locator.locatorID = mapfromdb[PendingInOutWarehouseDbHelper.colLocatorID];
    locator.locatorName =
        mapfromdb[PendingInOutWarehouseDbHelper.colLocatorName];
    this.locator = locator;
    this.colImagePath = mapfromdb[PendingInOutWarehouseDbHelper.colImagePath];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[PendingInOutWarehouseDbHelper.colID] = this.colID;
    map[PendingInOutWarehouseDbHelper.colSubmitTime] =
        this.colSubmitTime.toString();
    map[PendingInOutWarehouseDbHelper.colStatus] = this.colStatus;
    map[PendingInOutWarehouseDbHelper.colActionType] = this.colActionType;
    map[PendingInOutWarehouseDbHelper.colRoleType] = this.colRoleType;
    map[PendingInOutWarehouseDbHelper.colUserName] = this.colUserName;
    map[PendingInOutWarehouseDbHelper.colUserID] = this.colUserID;
    map[PendingInOutWarehouseDbHelper.colPass] = this.colPass;
    map[PendingInOutWarehouseDbHelper.colRoleID] = this.colRoleID;
    map[PendingInOutWarehouseDbHelper.colLocatorDBversion] =
        this.colLocatorDBversion;
    //
    map[PendingInOutWarehouseDbHelper.colProductRegistration] =
        this.colProductRegistration;
    //
    if (locator != null) {
      map[PendingInOutWarehouseDbHelper.colLocatorID] = this.locator.locatorID;
      map[PendingInOutWarehouseDbHelper.colLocatorName] =
          this.locator.locatorName;
    } else {
      map[PendingInOutWarehouseDbHelper.colLocatorID] = 'No Locator data';
      map[PendingInOutWarehouseDbHelper.colLocatorName] = 'No Locator data';
    }
    if (this.colImagePath != null || this.colImagePath != '') {
      map[PendingInOutWarehouseDbHelper.colImagePath] = this.colImagePath;
    } else {
      map[PendingInOutWarehouseDbHelper.colImagePath] = 'No image data';
    }
    //
    return map;
  }
}
