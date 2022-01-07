part of '../../../screens.dart';

class SelectOperator extends StatefulWidget {
  @override
  _SelectOperatorState createState() => _SelectOperatorState();
}

class _SelectOperatorState extends State<SelectOperator> {
  OperatorService operatorService = OperatorService();
  TextEditingController operatorControler = TextEditingController();
  Chips chips = Chips();
  Size size;
  List<Operator> displayItems = [];
  bool showNotFoundDialog = false;
  bool isSync = false;

  @override
  void dispose() {
    super.dispose();
    displayItems = [];
  }

  @override
  void initState() {
    displayItems = Operator.listofdata;
    print('Check length ${displayItems.length}');
    super.initState();
  }

  void fetchdataGetListOperator() async {
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
    PrintDebug.printDialog(
        id: operatorSelector, msg: 'fetching from idempiere');
    var result;
    result = await operatorService.getOperatorData();

    if (result == 0) {
      // DateTime now = DateTime.now();
      // var updateTime =
      //     '${now.day} ${DateFormat.MMMM().format(now).substring(0, 3)} ${now.year}';
      // await TimeStampUpdate.updateTimeStamp(
      //   key: TimeStampUpdate.locatorUpdate,
      //   value: updateTime,
      // );
      PrintDebug.printDialog(
          id: operatorSelector, msg: 'Fetch status : $result');
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
    displayItems = Operator.listofdata;
    print('Check length ${displayItems.length}');
    setState(() {
      isSync = false;
    });
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
            isSync ? 'Sync data...' : 'Updated',
            style: blackFontStyle2.copyWith(color: greyColor),
          ),
          isSync
              ? loadingIndicator2
              : GestureDetector(
                  onTap: () async {
                    fetchdataGetListOperator();
                  },
                  child: Text(
                    'Update',
                    style: blackFontStyle2.copyWith(color: Colors.blue),
                  ))
        ],
      ),
    );
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
          children: [
            FittedBox(
              fit: BoxFit.none,
              alignment: Alignment.topCenter,
              child: CustomAppBar(
                title: 'Operator',
                subtitle: 'Select available Operator below',
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
                        controller: operatorControler,
                        onChanged: (val) {
                          searchEngine(keysearch: val);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: greyFontStyle,
                            hintText: "Find something..",
                            suffixIcon: operatorControler.text.length > 0
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showNotFoundDialog = false;
                                        operatorControler.clear();
                                        displayItems = Operator.listofdata;
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
                            children: Chips.operator.map((operator) {
                              return InputChip(
                                  onPressed: () async {
                                    var data = Operator.listofdata
                                        .where((element) =>
                                            element.operatorName ==
                                            operator.value)
                                        .toList();
                                    Get.back(result: data[0]);
                                  },
                                  label: Text('${operator.value}'));
                            }).toList()),
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Text(
                        operatorControler.text.length > 0
                            ? 'search result for ${operatorControler.text}'
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
                                children: displayItems.map((operatorItem) {
                                  return CustomListTile(
                                    leadingColor: blueGeneralUse,
                                    icon: Icons.pin_drop,
                                    onTap: () async {
                                      Get.back(result: operatorItem);

                                      await chips.addData(
                                          ChipsPreferences.operatorKey,
                                          operatorItem.operatorName);
                                      Chips.showData();
                                    },
                                    subtitle: operatorItem.operatorID,
                                    title: operatorItem.operatorName,
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

  void searchEngine({@required String keysearch}) {
    List<Operator> temp = [];
    bool founditem = false;
    if (keysearch == '' || keysearch == null) {
      PrintDebug.printDialog(id: locatorSelector, msg: 'reset search');

      temp = [];
      displayItems = Operator.listofdata;
      showNotFoundDialog = false;
    } else {
      PrintDebug.printDialog(
          id: locatorSelector, msg: 'Searching for $keysearch');
      var length = Operator.listofdata.length;
      for (int i = 0; i < length; i++) {
        if (Operator.listofdata[i].getOperatorName
            .toLowerCase()
            .contains(keysearch.toLowerCase())) {
          founditem = true;
          temp.add(Operator.listofdata[i]);
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
