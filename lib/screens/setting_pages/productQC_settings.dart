part of '../screens.dart';

class ProductQCSettingsPage extends StatefulWidget {
  @override
  _ProductQCSettingsPageState createState() => _ProductQCSettingsPageState();
}

class _ProductQCSettingsPageState extends State<ProductQCSettingsPage> {
  Size size;
  bool toogleSetting = false;
  bool locatorChoice = false;
  bool operatorChoice = false;
  bool productChoice = false;

  @override
  void initState() {
    super.initState();
    fetchSettings();
  }

  void fetchSettings() {
    if (ProductQCUserPreferences.getSettings()) {
      toogleSetting = true;
      if (ProductQCUserPreferences.rememberLocator()) {
        locatorChoice = true;
      }
      if (ProductQCUserPreferences.rememberOperator()) {
        operatorChoice = true;
      }
      if (ProductQCUserPreferences.rememberProduct()) {
        productChoice = true;
      }
      setState(() {});
    }
  }

  void switchToogle() {
    if (!toogleSetting) {
      //turned on
      if (!locatorChoice && !operatorChoice && !productChoice) {
        Get.snackbar(
          "",
          "",
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
          icon: Icon(Icons.warning_amber_outlined, color: Colors.white),
          titleText: Text("Cannot applied your setting",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600)),
          messageText: Text("you must specify choice at least 1",
              style: GoogleFonts.poppins(
                color: Colors.white,
              )),
        );
        return;
      }
      setState(() {
        toogleSetting = true;
      });
    } else {
      setState(() {
        toogleSetting = false;
        operatorChoice = false;
        locatorChoice = false;
        productChoice = false;
      });
    }
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
                title: 'Settings',
                subtitle: 'Product quality check',
                onBackButtonPressed: () {
                  Get.back();
                }),
            ListView(
              shrinkWrap: true,
              children: [
                CustomListTile(
                    icon: Icons.miscellaneous_services,
                    title: 'Remember my choice',
                    subtitle: 'always use my choice next time',
                    trailing: Switch(
                      value: toogleSetting,
                      activeColor: blueGeneralUse,
                      onChanged: (val) => switchToogle(),
                    ),
                    onTap: () {}),
                Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: CheckboxListTile(
                      title: Row(
                        children: [
                          Icon(MdiIcons.mapMarker,
                              color:
                                  locatorChoice ? blueGeneralUse : greyColor),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Locator",
                            style: blackFontStyle2,
                          ),
                        ],
                      ),
                      value: locatorChoice,
                      onChanged: (newValue) {
                        setState(() {
                          locatorChoice = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .trailing, //  <-- leading Checkbox
                    )),
                Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: CheckboxListTile(
                      title: Row(
                        children: [
                          Icon(Icons.person,
                              color:
                                  operatorChoice ? blueGeneralUse : greyColor),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Operator",
                            style: blackFontStyle2,
                          ),
                        ],
                      ),

                      value: operatorChoice,

                      onChanged: (newValue) {
                        setState(() {
                          operatorChoice = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .trailing, //  <-- leading Checkbox
                    )),
                Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: CheckboxListTile(
                      title: Row(
                        children: [
                          Icon(MdiIcons.widgets,
                              color:
                                  productChoice ? blueGeneralUse : greyColor),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Product",
                            style: blackFontStyle2,
                          ),
                        ],
                      ),

                      value: productChoice,
                      onChanged: (newValue) {
                        setState(() {
                          productChoice = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .trailing, //  <-- leading Checkbox
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 45,
                    width: 100,
                    margin: EdgeInsets.only(
                        right: defaultMargin, top: defaultMargin * 0.5),
                    child: ElevatedButton(
                      onPressed: () {
                        onSubmitButton();
                      },
                      child: Text(
                        'Save',
                        style: blackFontStyle.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          backgroundColor:
                              MaterialStateProperty.all(blueGeneralUse)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  void onSubmitButton() async {
    if (toogleSetting) {
      await ProductQCUserPreferences.enableSetting(
        locator: locatorChoice,
        operator: operatorChoice,
        product: productChoice,
      );
      Get.back();
    } else {
      await ProductQCUserPreferences.disabledSetting();
      Get.back();
    }
  }
}
