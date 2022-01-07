part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ChipsPreferences chipsPreferences = ChipsPreferences();
  PendingInOutWarehouseDbHelper pendingInOutWarehouseDbHelper =
      PendingInOutWarehouseDbHelper();
  AccountRolesDBHelper accountRolesDBhelper = AccountRolesDBHelper();
  OperatorDBHelper operatorDBHelper = OperatorDBHelper();
  LocatorDBHelper locatorDBhelper = LocatorDBHelper();
  ControlRejectDBHelper rejectDBhelper = ControlRejectDBHelper();
  ProductDBhelper productDBhelper = ProductDBhelper();
  ShipmentDBHelper shipmentDBhelper = ShipmentDBHelper();
  PendingProductQCDBhelper productPendingDBhelper = PendingProductQCDBhelper();
  PendingInOutDbHelper inOutPendingDBhelper = PendingInOutDbHelper();
  PendingProductQCBranchDBhelper productPendingDBBranchhelper =
      PendingProductQCBranchDBhelper();
  PendingInOutBranchDbHelper inOutPendingDBBranchhelper =
      PendingInOutBranchDbHelper();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  int count = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> getDevInfo() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    DeviceValue.devName = androidInfo.model;
    DeviceValue.devManufactureName = androidInfo.manufacturer;
    DeviceValue.isNFCsupport =
        androidInfo.systemFeatures.toString().contains('nfc');
    print(androidInfo.systemFeatures.toString());
    print(androidInfo..toString());
    return;
  }

  Future<void> loadData() async {
    print('1 now');
    await PendingSettings.getPref();
    print('2 now');
    await TimeStampUpdate.getPref();
    print('3 now');
    await UserData.getPref();
    print('4 now');
    await ProductQCUserPreferences.getPref();
    print('5 now');
    await getDevInfo();
    print('6 now');
    await initSQFlite(); //Database
    // await chipsPreferences.loadData();
    print('7 now');
    if (UserData.getStatusLog()) {
      Get.off(() => MainScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }

  Future<void> initSQFlite() async {
    if (AccountRoles.listofdata == null) {
      AccountRoles.listofdata = [];
      await updateAccountRoles();
    }
    if (Locator.listofdata == null) {
      Locator.listofdata = [];
      await updateLocator();
    }
    print('Check length ${Operator.listofdata}');
    if (Operator.listofdata == null || Operator.listofdata.length == 0) {
      Operator.listofdata = [];
      await updateOperator();
    }
    if (Production.listofdata == null) {
      Production.listofdata = [];
      await updateProduct();
    }
    if (ControlReject.listofdata == null) {
      ControlReject.listofdata = [];
      await updateControlReject();
    }
    if (PendingProductQC.listofdata == null) {
      PendingProductQC.listofdata = [];
      await updateProductPending();
    }
    if (PendingInOut.listofdata == null) {
      PendingInOut.listofdata = [];
      await updateInOutPending();
    }
    if (PendingProductQCBranch.listofdata == null) {
      PendingProductQCBranch.listofdata = [];
      await updateProductBranchPending();
    }
    if (PendingInOutBranch.listofdata == null) {
      PendingInOutBranch.listofdata = [];
      await updateInOutBranchPending();
    }
    if (Shipment.listofdata == null) {
      Shipment.listofdata = [];
      Shipment.listofdataDistinct = [];
      await updateShipmentPending();
    }

    return;
  }

  Future<void> updateInOutBranchPending() async {
    Future<Database> dbfuture;
    dbfuture = inOutPendingDBBranchhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<PendingInOutBranch>> listdata =
          inOutPendingDBBranchhelper.getPendingInOutBranchList();
      listdata.then((data) async {
        PendingInOutBranch.listofdata = data;
        PrintDebug.printDialog(
            id: splashScreen,
            msg:
                'Pending InOut loaded ! Total :${PendingInOutBranch.listofdata.length}');
        await PendingInOutBranch.clearExpiredRequest();
        return;
      });
    });
  }

  Future<void> updateShipmentPending() async {
    Future<Database> dbfuture;
    dbfuture = shipmentDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<Shipment>> listdata = shipmentDBhelper.getShipmentList();
      listdata.then((data) async {
        Shipment.listofdata = data;
        PrintDebug.printDialog(
            id: splashScreen,
            msg: 'gapake dinsticc:${Shipment.listofdata.length}');
        await Shipment.clearExpiredRequest();
        return;
      });
    });
    Future<List<Shipment>> listdata = shipmentDBhelper.getShipmentListDinstic();
    listdata.then((data) async {
      Shipment.listofdataDistinct = data;
      PrintDebug.printDialog(
          id: splashScreen,
          msg: 'dinstivccc :${Shipment.listofdataDistinct.length}');
      await Shipment.clearExpiredRequest();
      return;
    });
  }

  Future<void> updateInOutWarehousePending() async {
    Future<Database> dbfuture;
    dbfuture = pendingInOutWarehouseDbHelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<PendingInOutWarehouse>> listdata =
          pendingInOutWarehouseDbHelper.getPendingInOutWarehouseList();
      listdata.then((data) async {
        PendingInOutWarehouse.listofdata = data;
        PrintDebug.printDialog(
            id: splashScreen,
            msg:
                'Pending InOut Warehouse loaded ! Total :${PendingInOutWarehouse.listofdata.length}');
        await PendingInOutWarehouse.clearExpiredRequest();
        return;
      });
    });
  }

  Future<void> updateProductBranchPending() async {
    Future<Database> dbfuture;
    dbfuture = productPendingDBBranchhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<PendingProductQCBranch>> listdata =
          productPendingDBBranchhelper.getPendingProductQCBranchList();
      listdata.then((data) async {
        PendingProductQCBranch.listofdata = data;
        PrintDebug.printDialog(
            id: splashScreen,
            msg:
                'Pending ProductQC Branch loaded ! Total :${PendingProductQCBranch.listofdata.length}');
        await PendingProductQCBranch.clearExpiredRequest();
        return;
      });
    });
  }

  Future<void> updateInOutPending() async {
    Future<Database> dbfuture;
    dbfuture = inOutPendingDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<PendingInOut>> listdata =
          inOutPendingDBhelper.getPendingInOutList();
      listdata.then((data) async {
        PendingInOut.listofdata = data;
        PrintDebug.printDialog(
            id: splashScreen,
            msg:
                'Pending InOut loaded ! Total :${PendingInOut.listofdata.length}');
        await PendingInOut.clearExpiredRequest();
        return;
      });
    });
  }

  Future<void> updateProductPending() async {
    Future<Database> dbfuture;
    dbfuture = productPendingDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<PendingProductQC>> listdata =
          productPendingDBhelper.getPendingProductQCList();
      listdata.then((data) async {
        PendingProductQC.listofdata = data;
        PrintDebug.printDialog(
            id: splashScreen,
            msg:
                'Pending ProductQC loaded ! Total :${PendingProductQC.listofdata.length}');
        await PendingProductQC.clearExpiredRequest();
        return;
      });
    });
  }

  Future<void> updateAccountRoles() async {
    Future<Database> dbfuture;
    dbfuture = accountRolesDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<AccountRoles>> accountRoleList =
          accountRolesDBhelper.getAccountRoleList();
      accountRoleList.then((accountRoleList) {
        AccountRoles.listofdata = accountRoleList;
        PrintDebug.printDialog(
            id: splashScreen,
            msg: 'Role DB loaded ! Total :${AccountRoles.listofdata.length}');
        return;
      });
    });
  }

  Future<void> updateProduct() async {
    Future<Database> dbfuture;
    dbfuture = productDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<Production>> productList = productDBhelper.getProductList();
      productList.then((result) {
        Production.listofdata = result;
        PrintDebug.printDialog(
            id: splashScreen,
            msg: 'Product DB loaded ! Total :${Production.listofdata.length}');
        return;
      });
    });
  }

  Future<void> updateOperator() async {
    Future<Database> dbfuture;
    dbfuture = operatorDBHelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<Operator>> locatorList = operatorDBHelper.getLocatorList();
      locatorList.then((locatorList) {
        Operator.listofdata = locatorList;
        PrintDebug.printDialog(
            id: splashScreen,
            msg: 'Operator DB loaded ! Total :${Operator.listofdata.length}');
        return;
      });
    });
  }

  Future<void> updateLocator() async {
    Future<Database> dbfuture;
    dbfuture = locatorDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<Locator>> locatorList = locatorDBhelper.getLocatorList();
      locatorList.then((locatorList) {
        Locator.listofdata = locatorList;
        PrintDebug.printDialog(
            id: splashScreen,
            msg: 'Locator DB loaded ! Total :${Locator.listofdata.length}');
        return;
      });
    });
  }

  Future<void> updateControlReject() async {
    Future<Database> dbfuture;
    dbfuture = rejectDBhelper.initializeDatabase();
    dbfuture.then((database) {
      Future<List<ControlReject>> rejectList =
          rejectDBhelper.getControlRejectList();
      rejectList.then((rejectList) {
        ControlReject.listofdata = rejectList;
        PrintDebug.printDialog(
            id: splashScreen,
            msg:
                'Reject DB loaded ! Total :${ControlReject.listofdata.length}');
        return;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Container(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              image: AssetImage('assets/Penguin-Ad-Logo.png'))),
                    ),
                    loadingIndicator,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: defaultMargin * 2,
              child: Text(
                'version 3.3.0',
                style: greyFontStyle,
              ))
        ],
      ),
    );
  }
}
