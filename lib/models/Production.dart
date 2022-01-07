part of 'models.dart';

class Production {
  Production();
  String productID = 'default';
  String productName = 'default';
  String productValue = 'default';
  String productIsConsignment = 'default';

  static List<Production> listofdata;

  static Future<void> clearAll() async {
    Production.listofdata = [];
    await databaseHelper.deleteAllProduct();
    return;
  }

  static Future<void> updateDatabase() async {
    var temp = Production.listofdata;
    Production.listofdata = [];
    await databaseHelper.deleteAllProduct();
    for (int i = 0; i < temp.length; i++) {
      await databaseHelper.insertProduct(temp[i]);
    }
    Production.listofdata = await databaseHelper.getProductList();
    PrintDebug.printDialog(
        id: idempiereProductionService,
        msg: 'Production DB Updates ! Total :${Production.listofdata.length}');

    return;
  }

  void displayInformation() {
    PrintDebug.printDialog(
        id: idempiereProductionService,
        msg: 'Production ID   :${this.productValue}');
    PrintDebug.printDialog(
        id: idempiereProductionService,
        msg: 'Production Name :${this.productName}');
  }

  static void displayAllProduct() {
    for (int i = 0; i < Production.listofdata.length; i++) {
      PrintDebug.printDialog(
          id: idempiereProductionService,
          msg:
              'Production Name :${listofdata[i].productName} with ID :${listofdata[i].productValue}');
    }
  }

  //SQFlite Operations
  static ProductDBhelper databaseHelper = ProductDBhelper();
  Production.frommapObject(Map<String, dynamic> mapfromdb) {
    this.productID = mapfromdb['Product_ID'];
    this.productName = mapfromdb['Product_Name'];
    this.productValue = mapfromdb['Product_Value'];
    this.productIsConsignment = mapfromdb['Product_IsConsignment'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Product_ID'] = this.productID;
    map['Product_Name'] = this.productName;
    map['Product_Value'] = this.productValue;
    map['Product_IsConsignment'] = this.productIsConsignment;
    return map;
  }
}
