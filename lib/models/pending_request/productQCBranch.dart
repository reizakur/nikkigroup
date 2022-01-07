part of '../models.dart';

class PendingProductQCBranch {
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
  //  String colOperatorID = 'operator_id';
  //  String colOperatorName = 'operator_name';
  String colImagePath = 'image_pic_path';

  static List<PendingProductQCBranch> listofdata;
  PendingProductQCBranch.insert({
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
  PendingProductQCBranch();

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
            'Role PendingProductQCBranch before clear Expired Total :${PendingProductQCBranch.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg:
            'Expired threshold is ${PendingSettings.getExpiredDayThreshold()} days');

    PendingProductQCBranch.listofdata
        .removeWhere((request) => request.isRequestExpired());
    await PendingProductQCBranch.syncDatabase();
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg:
            'Role PendingProductQCBranch after clear Expired Total :${PendingProductQCBranch.listofdata.length}');

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
    PendingProductQCBranch.listofdata = [];
    await databaseHelper.deleteAllPendingProductQCBranch();
    // await databaseHelper.deleteAllPendingInOut();
    return;
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertAccountRole(this);
    PendingProductQCBranch.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = PendingProductQCBranch.listofdata;
    await PendingProductQCBranch.clearall();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertAccountRole(temp[i]);
    }
    PendingProductQCBranch.listofdata =
        await databaseHelper.getPendingProductQCBranchList();
    PrintDebug.printDialog(
        id: pendingQCModel,
        msg:
            'Role PendingProductQCBranch Updates ! Total :${PendingProductQCBranch.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static PendingProductQCBranchDBhelper databaseHelper =
      PendingProductQCBranchDBhelper();
  PendingProductQCBranch.frommapObject(Map<String, dynamic> mapfromdb) {
    Locator locator = Locator();
    Production product = Production();
    Operator operator = Operator();
    this.colID = mapfromdb[PendingProductQCBranchDBhelper.colID].toString();
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb[PendingProductQCBranchDBhelper.colSubmitTime]);
    this.colStatus = mapfromdb[PendingProductQCBranchDBhelper.colStatus];
    this.colActionType =
        mapfromdb[PendingProductQCBranchDBhelper.colActionType];
    this.colUserName = mapfromdb[PendingProductQCBranchDBhelper.colUserName];
    this.colUserID = mapfromdb[PendingProductQCBranchDBhelper.colUserID];
    this.colPass = mapfromdb[PendingProductQCBranchDBhelper.colPass];
    this.colRoleID = mapfromdb[PendingProductQCBranchDBhelper.colRoleID];
    this.colLocatorDBversion =
        mapfromdb[PendingProductQCBranchDBhelper.colLocatorDBversion];
    this.colProductDBversion =
        mapfromdb[PendingProductQCBranchDBhelper.colProductDBversion];
    //product
    product.productID = mapfromdb[PendingProductQCBranchDBhelper.colProductID];
    product.productName =
        mapfromdb[PendingProductQCBranchDBhelper.colProductName];
    product.productValue =
        mapfromdb[PendingProductQCBranchDBhelper.colProductValue];
    product.productIsConsignment =
        mapfromdb[PendingProductQCBranchDBhelper.colProductIsConsignment];
    this.product = product;
    this.colProductRegistration =
        mapfromdb[PendingProductQCBranchDBhelper.colProductRegistration];

    this.colProductStatus =
        mapfromdb[PendingProductQCBranchDBhelper.colProductStatus];

    //locator
    locator.locatorID = mapfromdb[PendingProductQCBranchDBhelper.colLocatorID];
    locator.locatorName =
        mapfromdb[PendingProductQCBranchDBhelper.colLocatorName];
    this.locator = locator;
    //operator
    operator.operatorID =
        mapfromdb[PendingProductQCBranchDBhelper.colOperatorID];
    operator.operatorName =
        mapfromdb[PendingProductQCBranchDBhelper.colOperatorName];
    this.operator = operator;
    this.colImagePath = mapfromdb[PendingProductQCBranchDBhelper.colImagePath];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[PendingProductQCBranchDBhelper.colID] = this.colID;
    map[PendingProductQCBranchDBhelper.colSubmitTime] =
        this.colSubmitTime.toString();
    map[PendingProductQCBranchDBhelper.colStatus] = this.colStatus;
    map[PendingProductQCBranchDBhelper.colActionType] = this.colActionType;
    map[PendingProductQCBranchDBhelper.colUserName] = this.colUserName;
    map[PendingProductQCBranchDBhelper.colUserID] = this.colUserID;
    map[PendingProductQCBranchDBhelper.colPass] = this.colPass;
    map[PendingProductQCBranchDBhelper.colRoleID] = this.colRoleID;
    map[PendingProductQCBranchDBhelper.colLocatorDBversion] =
        this.colLocatorDBversion;
    map[PendingProductQCBranchDBhelper.colProductDBversion] =
        this.colProductDBversion;
    //
    map[PendingProductQCBranchDBhelper.colProductID] = this.product.productID;
    map[PendingProductQCBranchDBhelper.colProductName] =
        this.product.productName;
    map[PendingProductQCBranchDBhelper.colProductIsConsignment] =
        this.product.productIsConsignment;
    map[PendingProductQCBranchDBhelper.colProductValue] =
        this.product.productValue;
    map[PendingProductQCBranchDBhelper.colProductStatus] =
        this.colProductStatus;
    map[PendingProductQCBranchDBhelper.colProductRegistration] =
        this.colProductRegistration;
    //
    map[PendingProductQCBranchDBhelper.colLocatorID] = this.locator.locatorID;
    map[PendingProductQCBranchDBhelper.colLocatorName] =
        this.locator.locatorName;
    //
    map[PendingProductQCBranchDBhelper.colOperatorID] =
        this.operator.operatorID;
    map[PendingProductQCBranchDBhelper.colOperatorName] =
        this.operator.operatorName;
    map[PendingProductQCBranchDBhelper.colImagePath] = this.colImagePath;
    return map;
  }
}
