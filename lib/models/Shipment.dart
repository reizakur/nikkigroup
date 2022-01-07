part of 'models.dart';

class Shipment {
  // ini ditambahin
  DateTime colSubmitTime;
  // sampe sini
  // ignore: non_constant_identifier_names
  String SP_ID = 'default';
  // ignore: non_constant_identifier_names
  String SP_Optional = 'default';
  // ignore: non_constant_identifier_names
  String SP_Content = 'default';
  // ignore: non_constant_identifier_names
  String SP_ProductionID = 'default';
  // ignore: non_constant_identifier_names
  String SP_ProductionOptional = 'default';
  // ignore: non_constant_identifier_names
  String SP_ProductionContent = 'default';
  String colStatus = 'status';
  static List<Shipment> listofdata;
  static List<Shipment> listofdataDistinct;

  Shipment();
  Shipment.createData({
    @required String spId,
    @required String spOptional, //IMG or QR
    @required String spContent,
    @required String spProductionID,
    @required String spProductionOptional, //IMG or QR
    @required String spProductionContent,
  }) {
    this.SP_ID = spId;
    this.SP_Optional = spOptional;
    this.SP_Content = spContent;
    this.SP_ProductionID = spProductionID;
    this.SP_ProductionOptional = spProductionOptional;
    this.SP_ProductionContent = spProductionContent;
    this.colSubmitTime = DateTime.now();
    this.colStatus = "pending";
  }
  static Future<void> clearExpiredRequest() async {
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg:
            'PendingShipmentBranch before clear Expired Total :${Shipment.listofdata.length}');
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg:
            'Expired threshold is Shipment ${PendingSettings.getExpiredDayThreshold()} days');

    Shipment.listofdata.removeWhere((request) => request.isRequestExpired());
    await Shipment.syncDatabase();
    PrintDebug.printDialog(
        id: pendingInOutBranchModel,
        msg:
            'PendingShipmentBranch after clear Expired Total :${Shipment.listofdata.length}');
  }

  Future<bool> checkFileAvail() async {
    bool isAvailable = true;
    if (this.SP_Optional == 'IMG') {
      var result = await File(this.SP_Content).exists();
      if (!result) isAvailable = false;
    }
    if (this.SP_ProductionOptional == 'IMG') {
      var result = await File(this.SP_ProductionContent).exists();
      if (!result) isAvailable = false;
    }
    return isAvailable;
  }

  static Future<void> clearAll() async {
    Shipment.listofdata = [];
    Shipment.listofdataDistinct = [];
    await databaseHelper.deleteAllShipment();
    return;
  }

  static Future<void> updateDatabase() async {
    var temp = Shipment.listofdata;
    var temp2 = Shipment.listofdataDistinct;
    Shipment.listofdata = [];
    Shipment.listofdataDistinct = [];
    await databaseHelper.deleteAllShipment();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertShipment(temp[i]);
    }
    Shipment.listofdata = await databaseHelper.getShipmentList();
    Shipment.listofdataDistinct = await databaseHelper.getShipmentListDinstic();
    PrintDebug.printDialog(
        id: idempiereShipmentService,
        msg: 'Shipment DB Updates ! Total :${Shipment.listofdata.length}');

    return;
  }

  void displayInformation() {
    PrintDebug.printDialog(
        id: idempiereShipmentService, msg: 'Shipment ID   :${this.SP_ID}');
    PrintDebug.printDialog(
        id: idempiereShipmentService,
        msg: 'Shipment Optional :${this.SP_Optional}');
    PrintDebug.printDialog(
        id: idempiereShipmentService,
        msg: 'Shipment Content :${this.SP_Content}');
    PrintDebug.printDialog(
        id: idempiereShipmentService,
        msg: 'Shipment Production ID :${this.SP_ProductionID}');
    PrintDebug.printDialog(
        id: idempiereShipmentService,
        msg: 'Shipment Production Optional :${this.SP_ProductionOptional}');
    PrintDebug.printDialog(
        id: idempiereShipmentService,
        msg: 'Shipment Production Content :${this.SP_ProductionContent}');
  }

  bool isRequestExpired() {
    var expiredDate = this
        .colSubmitTime
        .add(Duration(days: PendingSettings.getExpiredDayThreshold()));
    DateTime now = DateTime.now();
    return now.isAfter(expiredDate);
  }

  static void displayAllLocator() {
    for (int i = 0; i < Shipment.listofdata.length; i++) {
      PrintDebug.printDialog(
          id: idempiereShipmentService,
          msg:
              'Shipment Name :${listofdata[i].SP_ID} with ID :${listofdata[i].SP_Optional}');
    }
  }

  Future<int> insertToDatabase() async {
    await databaseHelper.insertShipment(this);
    Shipment.listofdata.add(this);
    return 1;
  }

  static Future<void> syncDatabase() async {
    var temp = Shipment.listofdata;
    await Shipment.clearAll();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertShipment(temp[i]);
    }
    Shipment.listofdata = await databaseHelper.getShipmentList();
    PrintDebug.printDialog(
        id: pendingDeliveryModel,
        msg:
            'Role PendingInOutWarehouse Updates ! Total :${Shipment.listofdata.length}');
    return;
  }

  //SQFlite Operations
  static ShipmentDBHelper databaseHelper = ShipmentDBHelper();
  Shipment.frommapObject(Map<String, dynamic> mapfromdb) {
    this.SP_ID = mapfromdb['Shipment_ID'];
    this.SP_Optional = mapfromdb['Shipment_Optional'];
    this.SP_Content = mapfromdb['Shipment_Content'];
    this.SP_ProductionID = mapfromdb['Shipment_Production_ID'];
    this.colStatus = mapfromdb['Shipment_Status'];
    this.SP_ProductionOptional = mapfromdb['Shipment_Production_Optional'];
    this.SP_ProductionContent = mapfromdb['Shipment_Production_Content'];
    this.colSubmitTime = convertSTRtoDateTime(
        dateSTR: mapfromdb['Shipment_Production_colSubmitTime']);
  }

  DateTime convertSTRtoDateTime({@required dateSTR}) {
    return DateTime.parse(dateSTR);
  }

// ini ditambahin
  String getSubmitTimeSTR() {
    var now = this.colSubmitTime;
    var result =
        '${now.day} ${DateFormat.MMMM().format(now).substring(0, 3)} ${now.year} ${DateFormat.jm().format(now)}';
    return result;
  }

  Future<Uint8List> readFileByte(String filePath) async {
    File imageFile = new File(filePath);
    Uint8List bytes;
    await imageFile
        .readAsBytes()
        .then((value) =>
            {bytes = Uint8List.fromList(value), print('reading of bytes')})
        .catchError((onError) {
      print('object' + onError.toString());
    });
    return bytes;
  }

// sampe sini
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Shipment_ID'] = this.SP_ID;
    map['Shipment_Optional'] = this.SP_Optional;
    map['Shipment_Content'] = this.SP_Content;
    map['Shipment_Production_ID'] = this.SP_ProductionID;
    map['Shipment_Status'] = this.colStatus;
    map['Shipment_Production_Optional'] = this.SP_ProductionOptional;
    map['Shipment_Production_Content'] = this.SP_ProductionContent;
    map['Shipment_Production_colSubmitTime'] = this.colSubmitTime.toString();
    return map;
  }
}
