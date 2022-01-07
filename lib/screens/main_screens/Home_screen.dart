part of '../screens.dart';

class Sub2screen extends StatefulWidget {
  const Sub2screen({Key key}) : super(key: key);
  @override
  Sub2ScreenState createState() => Sub2ScreenState();
}

class Sub2ScreenState extends State<Sub2screen> {
  List<Widget> servicesByRole;
  var productionServices,
      warehouseServices,
      deliveryServices,
      administratorServices,
      warehouseBranchServices,
      noServices,
      productionBranchServices;

  @override
  void initState() {
    super.initState();
    setState(() {
      initServices();
    });
  }

  void initServices() {
    productionServices = [
      // IconSquare(
      //   icon: Icons.move_to_inbox,
      //   title: 'Product In',
      //   onTap: () async {
      //     productInServices();
      //   },
      // ),
      IconSquare(
        icon: MdiIcons.clipboardCheck,
        title: 'QC Release',
        onTap: () async {
          productQCServices();
        },
      ),
      IconSquare(
        icon: Icons.outbond,
        title: 'Product Out',
        onTap: () async {
          productOutServices();
        },
      ),
      // IconSquare(
      //   icon: MdiIcons.codeJson,
      //   title: 'JSON tester',
      //   onTap: () async {
      //     jsonTest();
      //   },
      // ),
    ];
    warehouseServices = [
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'Warehouse in',
        onTap: () async {
          warehouseOutServices();
        },
      ),
      IconSquare(
        icon: Icons.outbond,
        title: 'Warehouse out',
        onTap: () async {
          warehouseInServices();
        },
      ),
    ];

    administratorServices = [
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'User',
        onTap: () async {
          warehouseOutServices();
        },
      ),
    ];

    deliveryServices = [
      IconSquare(
        icon: MdiIcons.truck,
        title: 'Shipment',
        onTap: () async {
          driver();
        },
      ),
    ];
    warehouseBranchServices = [
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'Warehouse In',
        onTap: () async {
          warehouseOutBranchServices();
        },
      ),
      IconSquare(
        icon: Icons.move_to_inbox,
        title: 'Warehouse Out',
        onTap: () async {
          warehouseOutBranchServices();
        },
      ),
    ];
    noServices = [
      IconSquare(
        icon: Icons.warning,
        title: 'No services1234',
        onTap: () async {},
      ),
    ];
    productionBranchServices = [
      // IconSquare(
      //   icon: Icons.move_to_inbox,
      //   title: 'Product In',
      //   onTap: () async {
      //     productInBranchServices();
      //   },
      // ),
      IconSquare(
        icon: MdiIcons.clipboardCheck,
        title: 'QC Release',
        onTap: () async {
          productQCBranchServices();
        },
      ),
      IconSquare(
        icon: Icons.outbond,
        title: 'Product Out',
        onTap: () async {
          productOutBranchServices();
        },
      ),
    ];
  }

  void getServices() {
    initServices();
    switch (UserData.getUsercurrentRoleName()) {
      case 'Warehouse':
        servicesByRole = warehouseServices;
        break;
      case 'Production':
        servicesByRole = productionServices;
        break;
      case 'Production-BRANCH':
        servicesByRole = productionBranchServices;
        break;
      case 'Delivery':
        servicesByRole = deliveryServices;
        break;

      case 'Warehouse-BRANCH':
        servicesByRole = warehouseBranchServices;
        break;

      case 'Administrator':
        servicesByRole = administratorServices;
        break;
      default:
        servicesByRole = noServices;
        break;
    }
  }

  // String badgeContent() {
  //   if (PendingProductQC.listofdata.length > 0) {
  //     return PendingProductQC.listofdata.length.toString();
  //   } else {
  //     return 'No Data';
  //   }
  // }

  // void temporaryService() async {
  //   await Get.to(() => TemporaryScreen());
  //   setState(() {});
  // }

  Size size;

  @override
  Widget build(BuildContext context) {
    PrintDebug.printDialog(id: homeScreen, msg: 'Refreshed check list');
    PrintDebug.printDialog(
        id: homeScreen,
        msg: 'check list ${PendingProductQC.listofdata.length}');
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.topCenter,
      color: blueBackground,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: ListView(
          shrinkWrap: true,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 200,
                    margin: EdgeInsets.only(left: defaultMargin * 0.25),
                    decoration: BoxDecoration(
                        //color: Colors.yellow,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                            image: AssetImage('assets/penguin.png'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: defaultMargin),
                    child: Text(
                      'Hi ${UserData.getUsername()}',
                      style: blackFontStyle2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              color: mainColor,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Role',
                    style: blackFontStyle2.copyWith(color: Colors.black54),
                  ),
                  Row(
                    children: [
                      Text(
                        '${UserData.getUsercurrentRoleName()}',
                        style: blackFontStyle2.copyWith(color: Colors.black54),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: defaultMargin),
              alignment: Alignment.bottomLeft,
              child: Text(
                'My Services :',
                style: blackFontStyle.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: defaultMargin * 0.5),
              child: Center(
                child: servicesWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget servicesWidget() {
    getServices();
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: servicesByRole.map((service) => service).toList(),
    );
  }

  Future<void> productQCServices() async {
    Get.to(() => ProductQC());
  }

  // Future<void> productInServices() async {
  //   Get.to(() => ProductInScreen());
  // }

  Future<void> productOutServices() async {
    Get.to(() => ProductOutScreen());
  }

  Future<void> jsonTest() async {
    Get.to(() => JSONPageTest());
  }

  ///
  Future<void> productQCBranchServices() async {
    Get.to(() => ProductQCBranch());
  }

  Future<void> productInBranchServices() async {
    Get.to(() => ProductInBranchScreen());
  }

  Future<void> productOutBranchServices() async {
    Get.to(() => ProductOutBranchScreen());
  }

  ///
  Future<void> warehouseInBranchServices() async {
    Get.to(() => WarehouseInBranchScreen());
  }

  Future<void> warehouseOutBranchServices() async {
    Get.to(() => WarehouseOutBranchScreen());
  }

  Future<void> warehouseInServices() async {
    Get.to(() => WarehouseInScreen());
  }

  Future<void> warehouseOutServices() async {
    Get.to(() => WarehouseOutScreen());
  }

  Future<void> driver() async {
    Get.to(() => DeliveryScreen());
  }

  void underDeveloper() {
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
}
