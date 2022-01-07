part of '../shared.dart';

class RoleWidgets {
  _GeneralPendingQuery _generalPendingQuery = _GeneralPendingQuery();
  List<dynamic> productionServices,
      warehouseServices,
      deliveryServices,
      noServices;
  List<Widget> productionServicesWidget,
      warehouseServicesWidget,
      deliveryServicesWidget,
      noServicesWidget;

  void _squareIconInit() {
    productionServicesWidget = [
      IconSquare(
        icon: MdiIcons.clipboardCheck,
        title: 'Product QC',
        onTap: () async {
          _productQCServices();
        },
      ),
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'Product In',
        onTap: () async {
          _productInServices();
        },
      ),
      IconSquare(
        icon: Icons.outbond,
        title: 'Check out product',
        onTap: () async {
          _underDeveloper();
        },
      ),
    ];
    warehouseServicesWidget = [
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'Warehouse in',
        onTap: () async {
          _underDeveloper();
        },
      ),
      IconSquare(
        icon: Icons.outbond,
        title: 'Warehouse out',
        onTap: () async {
          _underDeveloper();
        },
      ),
    ];
    deliveryServicesWidget = [
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'Delivery',
        onTap: () async {
          _underDeveloper();
        },
      ),
    ];
    noServicesWidget = [
      IconSquare(
        icon: Icons.warning,
        title: 'No services',
        onTap: () async {},
      ),
    ];
  }

  List<Widget> getServicesIcon() {
    _squareIconInit();
    switch (UserData.getUsercurrentRoleName()) {
      case 'Warehouse':
        return warehouseServicesWidget;
      case 'Production':
        return productionServicesWidget;
      case 'Delivery':
        return deliveryServicesWidget;
      default:
        return noServicesWidget;
    }
  }

  void _productQCServices() {
    Get.to(() => ProductQC());
  }

  void _productInServices() {
    Get.to(() => ProductInScreen());
  }

  void _underDeveloper() {
    PrintDebug.printDialog(id: homeScreen, msg: 'is okay ?');
    Get.snackbar(
      "",
      "",
      duration: Duration(seconds: 6),
      backgroundColor: "f2c13a".toColor(),
      icon: Icon(MdiIcons.signCaution, color: Colors.black),
      titleText: Text("Under Project",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w600)),
      messageText: Text("ups sorry this feature is under developer..",
          style: GoogleFonts.poppins(
            color: Colors.black,
          )),
    );
  }

  //Temporary widgets
  Widget getContentDisplayTabs(String selectedTabs) {
    print('Hasil tab $selectedTabs');
    print('Test');
    switch (selectedTabs) {
      case 'Production Query':
        _generalPendingQuery.clearAll();
        for (int i = 0; i < PendingProductQC.listofdata.length; i++) {
          _generalPendingQuery.addObjectList(
              item: ProductQCcard(data: PendingProductQC.listofdata[i]),
              time: PendingProductQC.listofdata[i].colSubmitTime);
        }
        for (int i = 0; i < PendingInOut.listofdata.length; i++) {
          _generalPendingQuery.addObjectList(
              item: InOutCard(data: PendingInOut.listofdata[i]),
              time: PendingInOut.listofdata[i].colSubmitTime);
        }
        return ListView(
          shrinkWrap: true,
          children: _generalPendingQuery
              .getListOfWidgets()
              .map((data) => data)
              .toList(),
        );
      case 'Production-BRANCH':
        _generalPendingQuery.clearAll();
        for (int i = 0; i < PendingProductQCBranch.listofdata.length; i++) {
          _generalPendingQuery.addObjectList(
              item: ProductQCBranchcard(
                  data: PendingProductQCBranch.listofdata[i]),
              time: PendingProductQCBranch.listofdata[i].colSubmitTime);
        }
        for (int i = 0; i < PendingInOutBranch.listofdata.length; i++) {
          _generalPendingQuery.addObjectList(
              item: InOutBranchCard(data: PendingInOutBranch.listofdata[i]),
              time: PendingInOutBranch.listofdata[i].colSubmitTime);
        }
        return ListView(
          shrinkWrap: true,
          children: _generalPendingQuery
              .getListOfWidgets()
              .map((data) => data)
              .toList(),
        );

      case 'Warehouse':
        _generalPendingQuery.clearAll();
        for (int i = 0; i < PendingInOutWarehouse.listofdata.length; i++) {
          _generalPendingQuery.addObjectList(
              item:
                  InOutWarehouseCard(data: PendingInOutWarehouse.listofdata[i]),
              time: PendingInOutWarehouse.listofdata[i].colSubmitTime);
        }
        return ListView(
          shrinkWrap: true,
          children: _generalPendingQuery
              .getListOfWidgets()
              .map((data) => data)
              .toList(),
        );

      case 'Warehouse-BRANCH':
        _generalPendingQuery.clearAll();
        for (int i = 0;
            i < PendingInOutWarehouseBranch.listofdata.length;
            i++) {
          _generalPendingQuery.addObjectList(
              item: InOutWarehouseBranchCard(
                  data: PendingInOutWarehouseBranch.listofdata[i]),
              time: PendingInOutWarehouseBranch.listofdata[i].colSubmitTime);
        }
        return ListView(
          shrinkWrap: true,
          children: _generalPendingQuery
              .getListOfWidgets()
              .map((data) => data)
              .toList(),
        );
      case 'Delivery':
        _generalPendingQuery.clearAll();
        for (int i = 0; i < Shipment.listofdataDistinct.length; i++) {
          _generalPendingQuery.addObjectList(
              item: ShipmentCard(data: Shipment.listofdataDistinct[i]),
              time: Shipment.listofdataDistinct[i].colSubmitTime);
        }
        return ListView(
          shrinkWrap: true,
          children: _generalPendingQuery
              .getListOfWidgets()
              .map((data) => data)
              .toList(),
        );

      /* 
        add another case for other roles in here
        */
      default:
        return Center(
          child: Text(
            'No data to display\nplease define it in\npenguin_new_version/lib/shared/widgets/widget_provider_role.dart\nat line 97',
            textAlign: TextAlign.center,
            style: blackFontStyle2,
          ),
        );
    }
  }

  List<String> tabsTitleTemporary() {
    print(UserData.getUsercurrentRoleName());
    switch (UserData.getUsercurrentRoleName()) {
      case 'Production':
        return ["Production Query"];
      case 'Production-BRANCH':
        return ["Production-BRANCH"];

      case 'Warehouse':
        return ["Warehouse"];

      case 'Warehouse-BRANCH':
        return ["Warehouse-BRANCH"];
      case 'Delivery':
        return ["Delivery"];
      default:
        return ["No Services 123"];
    }
  }

  List<Widget> getTabsTemporary() {
    return tabsTitleTemporary()
        .map((e) => Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(e),
              ),
            ))
        .toList();
  }
}

// ignore: unused_element
class _GeneralPendingQuery {
  _GeneralPendingQuery();
  Widget widget;
  DateTime time;

  _GeneralPendingQuery.create({
    @required this.widget,
    @required this.time,
  });

  void clearAll() {
    _GeneralPendingQuery._objectData.clear();
  }

  void addObjectList({@required Widget item, @required DateTime time}) {
    _objectData.add(_GeneralPendingQuery.create(widget: item, time: time));
    _objectData.sort((a, b) {
      if (a.time.isAfter(b.time)) return 1;
      return 0;
    });
  }

  List<Widget> getListOfWidgets() {
    List<Widget> sortedWidget = [];
    for (int i = 0; i < _objectData.length; i++) {
      sortedWidget.add(_objectData[i].widget);
    }
    return sortedWidget;
  }

  static List<_GeneralPendingQuery> _objectData = [];
}
