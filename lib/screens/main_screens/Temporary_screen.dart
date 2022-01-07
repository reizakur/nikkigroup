part of '../screens.dart';

class TemporaryScreen extends StatefulWidget {
  @override
  _TemporaryScreenState createState() => _TemporaryScreenState();
}

class _TemporaryScreenState extends State<TemporaryScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Size size;
  String _selectedIndexStr;
  RoleWidgets roleWidgets = RoleWidgets();
  bool isSync = false;
  String timeSync;
  PendingProductQCDBhelper pendingQCDBhelper = PendingProductQCDBhelper();
  PendingQCRequest pendingProductionRequest = PendingQCRequest();
  @override
  void initState() {
    super.initState();
    var length = roleWidgets.getTabsTemporary().length;
    _controller = TabController(length: length, vsync: this);
    _selectedIndexStr = roleWidgets.tabsTitleTemporary().elementAt(0);
    _controller.addListener(() {
      setState(() {
        _selectedIndexStr =
            roleWidgets.tabsTitleTemporary().elementAt(_controller.index);
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  Future<void> pendingQCBlock() async {
    PendingProductQC.listofdata =
        await pendingQCDBhelper.getPendingProductQCList();
    for (int i = 0; i < PendingProductQC.listofdata.length; i++) {
      if (PendingProductQC.listofdata[i].colStatus.toLowerCase() !=
          'uploaded') {
        if (!await PendingProductQC.listofdata[i].checkFileAvail()) {
          await pendingQCDBhelper.updateStatus(
              id: PendingProductQC.listofdata[i].colID,
              status: 'ERROR : File not found');
          continue;
        }
        var result = await pendingProductionRequest.uploadToServerQC(
            model: PendingProductQC.listofdata[i]);
        print("Hasil result : $result");
        switch (result) {
          case 0:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID, status: 'Uploaded');
            break;
          case 1:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID,
                status: 'pending'); //error idem
            break;
          case 3:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID,
                status: 'pending'); //error network
            break;
          default:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID, status: 'pending');

            break;
        }
        PendingProductQC.listofdata =
            await pendingQCDBhelper.getPendingProductQCList();
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: greyBackground,
          body: Column(
            children: [
              Container(
                height: 120,
                width: size.width,
                alignment: Alignment.bottomLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    width: size.width,
                    margin: EdgeInsets.only(
                        left: defaultMargin, bottom: defaultMargin),
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(
                                MdiIcons.history,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Query History :",
                                      textAlign: TextAlign.left,
                                      style: blackFontStyle.copyWith(
                                          fontSize: 30, color: Colors.white)),
                                  Text(
                                      "all your activities\nwill be deleted after ${PendingSettings.getExpiredDayThreshold()} days",
                                      textAlign: TextAlign.left,
                                      style: blackFontStyle2.copyWith(
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => ExpiredSettingPage()),
                          child: Container(
                              height: 40,
                              width: 40,
                              margin:
                                  EdgeInsets.only(right: defaultMargin * 0.5),
                              child: Icon(Icons.miscellaneous_services,
                                  size: 30, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: blueGeneralUse,
                ),
              ),
              Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 30),
                  width: size.width,
                  color: blueGeneralUse,
                  child: Row(
                    children: [
                      TabBar(
                          controller: _controller,
                          labelColor: Colors.black45,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: greyBackground),
                          tabs: roleWidgets.getTabsTemporary()),
                      SizedBox(width: 100),
                      Container(
                        //  color: Colors.black,
                        height: 50,
                        width: 80,

                        //   color: Colors.black,

                        child: Row(
                          children: [
                            isSync
                                ? loadingIndicator2
                                : GestureDetector(
                                    onTap: () async {
                                      pendingQCBlock();
                                    },
                                    child: Text(
                                      'Update',
                                      style: blackFontStyle2.copyWith(
                                          color: Colors.white),
                                    ))
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                constraints: BoxConstraints(
                  maxHeight: size.height - 140 - 130 - 30,
                  minHeight: 300,
                  maxWidth: size.width,
                ),
                margin: EdgeInsets.only(bottom: 30),
                child: roleWidgets.getContentDisplayTabs(_selectedIndexStr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
