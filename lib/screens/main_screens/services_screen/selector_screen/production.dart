part of '../../../screens.dart';

class SelectProduction extends StatefulWidget {
  @override
  _SelectProductionState createState() => _SelectProductionState();
}

class _SelectProductionState extends State<SelectProduction> {
  ProductionService fetch = ProductionService();
  TextEditingController productController = TextEditingController();
  Chips chips = Chips();
  Size size;
  List<Production> displayItems = [];
  bool showNotFoundDialog = false;
  bool isSync = false;
  String timeSync;

  void fetchProduct() async {
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

    PrintDebug.printDialog(id: productSelector, msg: 'fetching from idempiere');
    var result = await fetch.getProductData();
    if (result == 0) {
      DateTime now = DateTime.now();
      var updateTime =
          '${now.day} ${DateFormat.MMMM().format(now).substring(0, 3)} ${now.year}';
      await TimeStampUpdate.updateTimeStamp(
        key: TimeStampUpdate.productUpdate,
        value: updateTime,
      );
      PrintDebug.printDialog(
          id: productSelector, msg: 'Fetch status : $result');
      timeSync = 'Today';
      Get.snackbar(
        "",
        "",
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
        icon: Icon(Icons.check, color: Colors.white),
        titleText: Text("Database Info",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
        messageText: Text("you are up to date !",
            style: GoogleFonts.poppins(
              color: Colors.white,
            )),
      );
    } else {
      timeSync = TimeStampUpdate.getProductUpdateTimeStamp();
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
    displayItems = Production.listofdata;
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
    timeSync = TimeStampUpdate.getProductUpdateTimeStamp();
    displayItems = Production.listofdata;
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
                title: 'Product',
                subtitle: 'Select available Product below',
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
                        controller: productController,
                        onChanged: (val) {
                          searchEngine(keysearch: val);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: greyFontStyle,
                            hintText: "Find something..",
                            suffixIcon: productController.text.length > 0
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showNotFoundDialog = false;
                                        productController.clear();
                                        displayItems = Production.listofdata;
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
                            children: Chips.production.map((product) {
                              return InputChip(
                                  onPressed: () async {
                                    var data = Production.listofdata
                                        .where((element) =>
                                            element.productName ==
                                            product.value)
                                        .toList();
                                    Get.back(result: data[0]);
                                  },
                                  label: Text('${product.value}'));
                            }).toList()),
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Text(
                        productController.text.length > 0
                            ? 'search result for ${productController.text}'
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
                                children: displayItems.map((productItem) {
                                  return CustomListTile2(
                                    leadingColor: blueGeneralUse,
                                    icon: Icons.pin_drop,
                                    onTap: () async {
                                      Get.back(result: productItem);
                                      await chips.addData(
                                          ChipsPreferences.productKey,
                                          productItem.productName);
                                      Chips.showData();
                                    },
                                    title: productItem.productName,
                                    subtitle: productItem.productID,
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
                    fetchProduct();
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
    List<Production> temp = [];
    bool founditem = false;
    if (keysearch == '' || keysearch == null) {
      PrintDebug.printDialog(id: productSelector, msg: 'reset search');
      //fetchMenu();
      temp = [];
      displayItems = Production.listofdata;
      showNotFoundDialog = false;
    } else {
      PrintDebug.printDialog(
          id: productSelector, msg: 'Searching for $keysearch');
      var length = Production.listofdata.length;
      for (int i = 0; i < length; i++) {
        if (Production.listofdata[i].productName
            .toLowerCase()
            .contains(keysearch.toLowerCase())) {
          founditem = true;
          temp.add(Production.listofdata[i]);
        }
      }
      if (founditem) {
        PrintDebug.printDialog(id: productSelector, msg: 'Found item');
        displayItems = temp;
        showNotFoundDialog = false;
      } else {
        showNotFoundDialog = true;
        PrintDebug.printDialog(id: productSelector, msg: 'Not found');
        displayItems = [];
      }
    }
    setState(() {});
  }
}
