// part of 'models.dart';

// class ShipmentDistinct {
//   // ini ditambahin
//   DateTime colSubmitTime;
//   // sampe sini
//   // ignore: non_constant_identifier_names
//   String SP_ID = 'default';
//   // ignore: non_constant_identifier_names
//   String SP_Optional = 'default';
//   // ignore: non_constant_identifier_names
//   String SP_Content = 'default';
//   // ignore: non_constant_identifier_names
//   String SP_ProductionID = 'default';
//   // ignore: non_constant_identifier_names
//   String SP_ProductionOptional = 'default';
//   // ignore: non_constant_identifier_names
//   String SP_ProductionContent = 'default';
//   String colStatus = 'status';
//   static List<ShipmentDistinct> listofdata;

//   ShipmentDistinct();
//   ShipmentDistinct.createData({
//     @required String spId,
//     @required String spOptional, //IMG or QR
//     @required String spContent,
//     @required String spProductionID,
//     @required String spProductionOptional, //IMG or QR
//     @required String spProductionContent,
//   }) {
//     this.SP_ID = spId;
//     this.SP_Optional = spOptional;
//     this.SP_Content = spContent;
//     this.SP_ProductionID = spProductionID;
//     this.SP_ProductionOptional = spProductionOptional;
//     this.SP_ProductionContent = spProductionContent;
//     this.colSubmitTime = DateTime.now();
//     this.colStatus = "pending";
//   }
//   static Future<void> clearExpiredRequest() async {
//     PrintDebug.printDialog(
//         id: pendingInOutBranchModel,
//         msg:
//             'PendingShipmentDistinctBranch before clear Expired Total :${ShipmentDistinct.listofdata.length}');
//     PrintDebug.printDialog(
//         id: pendingInOutBranchModel,
//         msg:
//             'Expired threshold is ShipmentDistinct ${PendingSettings.getExpiredDayThreshold()} days');

//     ShipmentDistinct.listofdata.removeWhere((request) => request.isRequestExpired());
//     await ShipmentDistinct.syncDatabase();
//     PrintDebug.printDialog(
//         id: pendingInOutBranchModel,
//         msg:
//             'PendingShipmentDistinctBranch after clear Expired Total :${ShipmentDistinct.listofdata.length}');
//   }

//   Future<bool> checkFileAvail() async {
//     bool isAvailable = true;
//     if (this.SP_Optional == 'IMG') {
//       var result = await File(this.SP_Content).exists();
//       if (!result) isAvailable = false;
//     }
//     if (this.SP_ProductionOptional == 'IMG') {
//       var result = await File(this.SP_ProductionContent).exists();
//       if (!result) isAvailable = false;
//     }
//     return isAvailable;
//   }

//   static Future<void> clearAll() async {
//     ShipmentDistinct.listofdata = [];
//     await databaseHelper.deleteAllShipmentDistinct();
//     return;
//   }

//   static Future<void> updateDatabase() async {
//     var temp = ShipmentDistinct.listofdata;
//     ShipmentDistinct.listofdata = [];
//     await databaseHelper.deleteAllShipmentDistinct();
//     for (int i = 0; i < temp.length; i++) {
//       await databaseHelper.insertShipmentDistinct(temp[i]);
//     }
//     ShipmentDistinct.listofdata = await databaseHelper.getShipmentDistinctList();
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService,
//         msg: 'ShipmentDistinct DB Updates ! Total :${ShipmentDistinct.listofdata.length}');

//     return;
//   }

//   void displayInformation() {
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService, msg: 'ShipmentDistinct ID   :${this.SP_ID}');
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService,
//         msg: 'ShipmentDistinct Optional :${this.SP_Optional}');
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService,
//         msg: 'ShipmentDistinct Content :${this.SP_Content}');
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService,
//         msg: 'ShipmentDistinct Production ID :${this.SP_ProductionID}');
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService,
//         msg: 'ShipmentDistinct Production Optional :${this.SP_ProductionOptional}');
//     PrintDebug.printDialog(
//         id: idempiereShipmentDistinctService,
//         msg: 'ShipmentDistinct Production Content :${this.SP_ProductionContent}');
//   }

//   bool isRequestExpired() {
//     var expiredDate = this
//         .colSubmitTime
//         .add(Duration(days: PendingSettings.getExpiredDayThreshold()));
//     DateTime now = DateTime.now();
//     return now.isAfter(expiredDate);
//   }

//   static void displayAllLocator() {
//     for (int i = 0; i < ShipmentDistinct.listofdata.length; i++) {
//       PrintDebug.printDialog(
//           id: idempiereShipmentDistinctService,
//           msg:
//               'ShipmentDistinct Name :${listofdata[i].SP_ID} with ID :${listofdata[i].SP_Optional}');
//     }
//   }

//   Future<int> insertToDatabase() async {
//     await databaseHelper.insertShipmentDistinct(this);
//     ShipmentDistinct.listofdata.add(this);
//     return 1;
//   }

//   static Future<void> syncDatabase() async {
//     var temp = ShipmentDistinct.listofdata;
//     await ShipmentDistinct.clearAll();
//     for (int i = 0; i < temp.length; i++) {
//       await databaseHelper.insertShipmentDistinct(temp[i]);
//     }
//     ShipmentDistinct.listofdata = await databaseHelper.getShipmentDistinctList();
//     PrintDebug.printDialog(
//         id: pendingDeliveryModel,
//         msg:
//             'Role PendingInOutWarehouse Updates ! Total :${ShipmentDistinct.listofdata.length}');
//     return;
//   }

//   //SQFlite Operations
//   static ShipmentDistinctDBHelper databaseHelper = ShipmentDistinctDBHelper();
//   ShipmentDistinct.frommapObject(Map<String, dynamic> mapfromdb) {
//     this.SP_ID = mapfromdb['ShipmentDistinct_ID'];
//     this.SP_Optional = mapfromdb['ShipmentDistinct_Optional'];
//     this.SP_Content = mapfromdb['ShipmentDistinct_Content'];
//     this.SP_ProductionID = mapfromdb['ShipmentDistinct_Production_ID'];
//     this.colStatus = mapfromdb['ShipmentDistinct_Status'];
//     this.SP_ProductionOptional = mapfromdb['ShipmentDistinct_Production_Optional'];
//     this.SP_ProductionContent = mapfromdb['ShipmentDistinct_Production_Content'];
//     this.colSubmitTime = convertSTRtoDateTime(
//         dateSTR: mapfromdb['ShipmentDistinct_Production_colSubmitTime']);
//   }

//   DateTime convertSTRtoDateTime({@required dateSTR}) {
//     return DateTime.parse(dateSTR);
//   }

// // ini ditambahin
//   String getSubmitTimeSTR() {
//     var now = this.colSubmitTime;
//     var result =
//         '${now.day} ${DateFormat.MMMM().format(now).substring(0, 3)} ${now.year} ${DateFormat.jm().format(now)}';
//     return result;
//   }

//   Future<Uint8List> readFileByte(String filePath) async {
//     File imageFile = new File(filePath);
//     Uint8List bytes;
//     await imageFile
//         .readAsBytes()
//         .then((value) =>
//             {bytes = Uint8List.fromList(value), print('reading of bytes')})
//         .catchError((onError) {
//       print('object' + onError.toString());
//     });
//     return bytes;
//   }

// // sampe sini
//   Map<String, dynamic> toMap() {
//     var map = Map<String, dynamic>();
//     map['ShipmentDistinct_ID'] = this.SP_ID;
//     map['ShipmentDistinct_Optional'] = this.SP_Optional;
//     map['ShipmentDistinct_Content'] = this.SP_Content;
//     map['ShipmentDistinct_Production_ID'] = this.SP_ProductionID;
//     map['ShipmentDistinct_Status'] = this.colStatus;
//     map['ShipmentDistinct_Production_Optional'] = this.SP_ProductionOptional;
//     map['ShipmentDistinct_Production_Content'] = this.SP_ProductionContent;
//     map['ShipmentDistinct_Production_colSubmitTime'] = this.colSubmitTime.toString();
//     return map;
//   }
// }
