part of '../models.dart';

class PendingProductQC {
  String colID;
  DateTime colSubmitTime;
  String colStatus = 'status';
  String colActionType = 'action_type';
  //Idempiere Access
  String colUserName = 'username';
  String colUserID = 'userID';
  String colPass = 'password';
  String colRoleID = 'role_id';
  //Database Info
  String colLocatorDBversion = 'locator_db_version';
  String colProductDBversion = 'product_db_version';
  //standard attribute

  Production product = Production();
  //  String colProductID = 'product_id';
  //  String colProductName = 'product_name';
  String colProductStatus = 'product_status';
  String colProductRegistration = 'product_registration';

  Locator locator = Locator();
  //  String colLocatorID = 'locator_id';
  //  String colLocatorName = 'locator_name';

  Operator operator = Operator();
  ControlReject keterangan = ControlReject();
  //  String colOperatorID = 'operator_id';
  //  String colOperatorName = 'operator_name';
  String colImagePath = 'image_pic_path';

  static List<PendingProductQC> listofdata;
  PendingProductQC.insert({
    @required this.colSubmitTime,
    @required this.colStatus,
    @required this.colActionType,
    @required this.colUserName,
    @required this.colUserID,
    @required this.colPass,
    @required this.colRoleID,
    @required this.colLocatorDBversion,
    @required this.colProductDBversion,
    @required this.locator,
    @required this.operator,
    @required this.product,
    @required this.keterangan,
    @required this.colProductStatus,
    @required this.colProductRegistration,
    @required this.colImagePath,
  }) {
    var uuid = Uuid();
    var uniqCode = uuid.v1();
    uniqCode = uniqCode.substring(1, 7);
    this.colID = 'Product QC-$uniqCode';

    this.colSubmitTime = DateTime.now();
    this.printAllData();
  }
  PendingProductQC();

  Future<bool> checkFileAvail() async {
    if (this.colImagePath == 'No Image') return true;
    var result = await File(this.colImagePath).exists();
    return result;
  }

  void printAllData() {
    PrintDebug.printDialog(id: pendingQCModel, msg: 'Col ID $colID');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'Submit time $colSubmitTime');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'Status $colStatus');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'Action Type $colActionType');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'Username $colUserName');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'colUserID $colUserID');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'colPass $colPass');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'colRoleID $colRoleID');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'colLocatorDBversion $colLocatorDBversion');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'colProductDBversion $colProductDBversion');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'locator ${locator.toString()}');
    PrintDebug.printDialog(id: pendingQCModel, msg: 'operator $operator');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'operator ${product.toString()}');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'colProductStatus $colProductStatus');
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg: 'colProductRegistration $colProductRegistration');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'colImagePath $colImagePath');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'file avail? $checkFileAvail()');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'keterangan ${keterangan.toString()}');
    PrintDebug.printDialog(
        id: pendingInOutModel,
        msg: 'colProductRegistration $colProductRegistration');
    PrintDebug.printDialog(
        id: pendingQCModel, msg: 'colImagePath $colImagePath');
  }

  bool isRequestExpired() {
    var expiredDate = this.colSubmitTime.add(Duration(
          days: PendingSettings.getExpiredDayThreshold(), /*hours*/
        ));
    DateTime now = DateTime.now();
    return now.isAfter(expiredDate);
  }

  Future<void> deleteImageInFile() async {
    await File(this.colImagePath).delete();
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
        id: pendingQCModel,
        msg:
            'Role PendingProductQC before clear Expired Total :${PendingProductQC.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg:
            'Expired threshold is ${PendingSettings.getExpiredDayThreshold()} days');

    PendingProductQC.listofdata
        .removeWhere((request) => request.isRequestExpired());
    await PendingProductQC.syncDatabase();
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg:
            'Role PendingProductQC after clear Expired Total :${PendingProductQC.listofdata.length}');

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
    PendingProductQC.listofdata = [];
    await databaseHelper.deleteAllPendingProductQC();
    // await databaseHelper.deleteAllPendingInOut();
    return;
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertAccountRole(this);
    PendingProductQC.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = PendingProductQC.listofdata;
    await PendingProductQC.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertAccountRole(temp[i]);
    }
    PendingProductQC.listofdata =
        await databaseHelper.getPendingProductQCList();
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg:
            'Role PendingProductQC Updates ! Total :${PendingProductQC.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static PendingProductQCDBhelper databaseHelper = PendingProductQCDBhelper();
  PendingProductQC.frommapObject(Map<String, dynamic> mapfromdb) {
    Locator locator = Locator();
    Production product = Production();
    Operator operator = Operator();
    this.colID = mapfromdb[PendingProductQCDBhelper.colID].toString();
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb[PendingProductQCDBhelper.colSubmitTime]);
    this.colStatus = mapfromdb[PendingProductQCDBhelper.colStatus];
    this.colActionType = mapfromdb[PendingProductQCDBhelper.colActionType];
    this.colUserName = mapfromdb[PendingProductQCDBhelper.colUserName];
    this.colUserID = mapfromdb[PendingProductQCDBhelper.colUserID];
    this.colPass = mapfromdb[PendingProductQCDBhelper.colPass];
    this.colRoleID = mapfromdb[PendingProductQCDBhelper.colRoleID];
    this.colLocatorDBversion =
        mapfromdb[PendingProductQCDBhelper.colLocatorDBversion];
    this.colProductDBversion =
        mapfromdb[PendingProductQCDBhelper.colProductDBversion];
    //product
    product.productID = mapfromdb[PendingProductQCDBhelper.colProductID];
    product.productName = mapfromdb[PendingProductQCDBhelper.colProductName];
    product.productValue = mapfromdb[PendingProductQCDBhelper.colProductValue];
    product.productIsConsignment =
        mapfromdb[PendingProductQCDBhelper.colProductIsConsignment];
    this.product = product;
    this.colProductRegistration =
        mapfromdb[PendingProductQCDBhelper.colProductRegistration];

    this.colProductStatus =
        mapfromdb[PendingProductQCDBhelper.colProductStatus];

    //locator
    locator.locatorID = mapfromdb[PendingProductQCDBhelper.colLocatorID];
    locator.locatorName = mapfromdb[PendingProductQCDBhelper.colLocatorName];
    this.locator = locator;
    //operator
    operator.operatorID = mapfromdb[PendingProductQCDBhelper.colOperatorID];
    operator.operatorName = mapfromdb[PendingProductQCDBhelper.colOperatorName];
    this.operator = operator;
    this.colImagePath = mapfromdb[PendingProductQCDBhelper.colImagePath];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[PendingProductQCDBhelper.colID] = this.colID;
    map[PendingProductQCDBhelper.colSubmitTime] = this.colSubmitTime.toString();
    map[PendingProductQCDBhelper.colStatus] = this.colStatus;
    map[PendingProductQCDBhelper.colActionType] = this.colActionType;
    map[PendingProductQCDBhelper.colUserName] = this.colUserName;
    map[PendingProductQCDBhelper.colUserID] = this.colUserID;
    map[PendingProductQCDBhelper.colPass] = this.colPass;
    map[PendingProductQCDBhelper.colRoleID] = this.colRoleID;
    map[PendingProductQCDBhelper.colLocatorDBversion] =
        this.colLocatorDBversion;
    map[PendingProductQCDBhelper.colProductDBversion] =
        this.colProductDBversion;
    //
    map[PendingProductQCDBhelper.colProductID] = this.product.productID;
    map[PendingProductQCDBhelper.colProductName] = this.product.productName;
    map[PendingProductQCDBhelper.colProductIsConsignment] =
        this.product.productIsConsignment;
    map[PendingProductQCDBhelper.colProductValue] = this.product.productValue;
    map[PendingProductQCDBhelper.colProductStatus] = this.colProductStatus;
    map[PendingProductQCDBhelper.colProductRegistration] =
        this.colProductRegistration;
    //
    map[PendingProductQCDBhelper.colLocatorID] = this.locator.locatorID;
    map[PendingProductQCDBhelper.colLocatorName] = this.locator.locatorName;
    //
    map[PendingProductQCDBhelper.colOperatorID] = this.operator.operatorID;
    map[PendingProductQCDBhelper.colOperatorName] = this.operator.operatorName;
    map[PendingProductQCDBhelper.colImagePath] = this.colImagePath;
    return map;
  }
}
