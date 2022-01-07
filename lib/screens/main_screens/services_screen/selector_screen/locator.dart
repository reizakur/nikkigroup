part of '../../../screens.dart';

class SelectLocator extends StatefulWidget {
  @override
  _SelectLocatorState createState() => _SelectLocatorState();
}

class _SelectLocatorState extends State<SelectLocator> {
  Chips chips = Chips();
  LocatorService fetch = LocatorService();
  TextEditingController locatorController = TextEditingController();
  Size size;
  List<Locator> displayItems = [];
  bool showNotFoundDialog = false;
  bool isSync = false;
  String timeSync;

  void fetchdataGetListLocator() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("", "",
          duration: Duration(seconds: 6),
          backgroundColor: Colors.red,
          icon: Icon(Icons.warning, color: Colors.white),
          titleText: Text("No Connection",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600)),
          messageText: Text("Please try again later",
              style: GoogleFonts.poppins(
                color: Colors.white,
              )));
      return;
    }
    setState(() {
      isSync = true;
    });
    PrintDebug.printDialog(id: locatorSelector, msg: 'fetching from idempiere');
    var result;
    switch (UserData.getUsercurrentRoleName()) {
      case 'Production':
        result = await fetch.getLocatorData();
        break;
      case 'Production-BRANCH':
        result = await fetch.getLocatorBranchData(
          roleID: UserData.getUserCurrentRoleID(),
          userID: UserData.getUserID(),
        );
        break;
    }

    if (result == 0) {
      DateTime now = DateTime.now();
      var updateTime =
          '${now.day} ${DateFormat.MMMM().format(now).substring(0, 3)} ${now.year}';
      await TimeStampUpdate.updateTimeStamp(
        key: TimeStampUpdate.locatorUpdate,
        value: updateTime,
      );
      PrintDebug.printDialog(
          id: locatorSelector, msg: 'Fetch status : $result');
      timeSync = 'Today';
      Get.snackbar(
        "",
        "",
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
        icon: Icon(Icons.check, color: Colors.white),
        titleText: Text("Database Info :",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
        messageText: Text("you are up to date !",
            style: GoogleFonts.poppins(
              color: Colors.white,
            )),
      );
    } else {
      timeSync = TimeStampUpdate.getLocatorUpdateTimeStamp();
      Get.snackbar(
        "",
        "",
        duration: Duration(seconds: 6),
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning, color: Colors.white),
        titleText: Text("Connection Error",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
        messageText: Text("Cannot update the data , please try again later",
            style: GoogleFonts.poppins(
              color: Colors.white,
            )),
      );
    }
    displayItems = Locator.listofdata;
    setState(() {
      isSync = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    displayItems = [];
  }

  @override
  void initState() {
    timeSync = TimeStampUpdate.getLocatorUpdateTimeStamp();
    displayItems = Locator.listofdata;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        height: size.height,
        width: size.width,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.none,
              alignment: Alignment.topCenter,
              child: CustomAppBar(
                title: 'Locator',
                subtitle: 'Select available Locator below',
                onBackButtonPressed: () {
                  Get.back();
                },
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.88,
                child: ListView(
                  children: [
                    syncDialog(),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)),
                      child: TextField(
                        enabled: !isSync,
                        controller: locatorController,
                        onChanged: (val) {
                          searchEngine(keysearch: val);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: greyFontStyle,
                            hintText: "Find something..",
                            suffixIcon: locatorController.text.length > 0
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showNotFoundDialog = false;
                                        locatorController.clear();
                                        displayItems = Locator.listofdata;
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: greyColor,
                                    ))
                                : Icon(Icons.search)),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 10,
                      //  color: Colors.red,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        height: 50,
                        width: 05,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: Chips.locator.map((locator) {
                              return InputChip(
                                  onPressed: () async {
                                    var data = Locator.listofdata
                                        .where((element) =>
                                            element.locatorName ==
                                            locator.value)
                                        .toList();
                                    Get.back(result: data[0]);
                                  },
                                  label: Text('${locator.value}'));
                            }).toList()),
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Text(
                        locatorController.text.length > 0
                            ? 'search result for ${locatorController.text}'
                            : '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: greyFontStyle,
                      ),
                    ),
                    AnimatedCrossFade(
                        firstChild: dialog(),
                        secondChild: SizedBox(),
                        crossFadeState: showNotFoundDialog
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: Duration(microseconds: 250)),
                    isSync
                        ? dialog(msg: 'Fetching data..')
                        : Container(
                            height: size.height * 0.7,
                            width: size.width,
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (overscroll) {
                                overscroll.disallowGlow();
                                return false;
                              },
                              child: ListView(
                                children: displayItems.map((locatorItem) {
                                  PrintDebug.printDialog(
                                      id: locatorSelector,
                                      msg:
                                          'Apakah kosong ? ${locatorItem.locatorName}');

                                  return CustomListTile(
                                    leadingColor: blueGeneralUse,
                                    icon: Icons.pin_drop,
                                    onTap: () async {
                                      Get.back(result: locatorItem);

                                      await chips.addData(
                                          ChipsPreferences.locatorKey,
                                          locatorItem.locatorName);
                                      Chips.showData();
                                    },
                                    subtitle: locatorItem.locatorID,
                                    title: locatorItem.locatorName,
                                    disableTrailing: true,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )));
  }

  Widget dialog({String msg = 'No result found'}) {
    return Container(
      height: 100,
      width: size.width,
      alignment: Alignment.center,
      child: Text(
        msg,
        style: blackFontStyle.copyWith(color: greyColor),
      ),
    );
  }

  Widget syncDialog() {
    return Container(
      height: 35,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isSync ? 'Sync data...' : 'Last update : $timeSync',
            style: blackFontStyle2.copyWith(color: greyColor),
          ),
          isSync
              ? loadingIndicator2
              : GestureDetector(
                  onTap: () async {
                    fetchdataGetListLocator();
                  },
                  child: Text(
                    'Update',
                    style: blackFontStyle2.copyWith(color: Colors.blue),
                  ))
        ],
      ),
    );
  }

  void searchEngine({@required String keysearch}) {
    List<Locator> temp = [];
    bool founditem = false;
    if (keysearch == '' || keysearch == null) {
      PrintDebug.printDialog(id: locatorSelector, msg: 'reset search');
      //fetchMenu();
      temp = [];
      displayItems = Locator.listofdata;
      showNotFoundDialog = false;
    } else {
      PrintDebug.printDialog(
          id: locatorSelector, msg: 'Searching for $keysearch');
      var length = Locator.listofdata.length;
      for (int i = 0; i < length; i++) {
        if (Locator.listofdata[i].locatorName
            .toLowerCase()
            .contains(keysearch.toLowerCase())) {
          founditem = true;
          temp.add(Locator.listofdata[i]);
        }
      }
      if (founditem) {
        PrintDebug.printDialog(id: locatorSelector, msg: 'Found item');
        displayItems = temp;
        showNotFoundDialog = false;
      } else {
        showNotFoundDialog = true;
        PrintDebug.printDialog(id: locatorSelector, msg: 'Not found');
        displayItems = [];
      }
    }
    setState(() {});
  }
}
