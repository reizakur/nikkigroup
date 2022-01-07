part of '../screens.dart';

class Sub3Screen extends StatefulWidget {
  final Function showDialog;

  Sub3Screen({this.showDialog});

  @override
  _Sub3ScreenState createState() => _Sub3ScreenState();
}

class _Sub3ScreenState extends State<Sub3Screen> {
  Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.87,
      width: size.width,
      alignment: Alignment.topCenter,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: size.height * 0.88,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: ListView(
              children: [
                //upper component
                Container(
                  height: 250,
                  width: size.width,
                  //color: Colors.yellow,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.symmetric(vertical: defaultMargin),
                          alignment: Alignment.center,
                          child: Container(
                            height: 90,
                            width: 90,
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: greyColor,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/photo_border.png')))),
                      Container(
                        child: Text(
                          UserData.getUsername(),
                          maxLines: 1,
                          style: blackFontStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Text(
                          'AD User ID : ${UserData.getUserID()}',
                          maxLines: 1,
                          style: blackFontStyle2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () {
                            signOut();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign out',
                                style: blackFontStyle2.copyWith(
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.logout,
                                size: 20,
                                color: Colors.white,
                              )
                            ],
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.orange)),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 30,
                      width: size.width,
                      //color: Colors.red,
                      padding: EdgeInsets.only(left: defaultMargin),
                      margin: EdgeInsets.only(
                          bottom: defaultMargin * 0.1,
                          top: defaultMargin * 0.5),
                      child: Text('Account Detail :', style: blackFontStyle2),
                    ),
                    SimpleTextDisplay(
                      leftText: 'username :',
                      rightText: UserData.getUsername(),
                    ),
                    SimpleTextDisplay(
                      leftText: 'AD user id :',
                      rightText: UserData.getUserID(),
                    ),
                    SimpleTextDisplay(
                      leftText: 'client id :',
                      rightText: UserData.getClientID(),
                    ),
                    SimpleTextDisplay(
                      leftText: 'total role :',
                      rightText: AccountRoles.listofdata.length.toString(),
                    ),
                    SimpleTextDisplay(
                      leftText: 'current role :',
                      rightText: UserData.getUsercurrentRoleName(),
                    ),
                    SimpleTextDisplay(
                      leftText: 'current role id :',
                      rightText: UserData.getUserCurrentRoleID(),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          right: defaultMargin, top: defaultMargin * 0.5),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.showDialog();
                          },
                          child: Text(
                            'Change role',
                            textAlign: TextAlign.center,
                            style:
                                blackFontStyle2.copyWith(color: Colors.white),
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
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      height: 30,
                      width: size.width,
                      //color: Colors.red,
                      padding: EdgeInsets.only(left: defaultMargin),
                      margin: EdgeInsets.only(
                          bottom: defaultMargin * 0.1,
                          top: defaultMargin * 0.5),
                      child: Text('Available Roles :', style: blackFontStyle2),
                    ),
                    Column(
                      children: AccountRoles.listofdata.map((e) {
                        return SimpleTextDisplay(
                          leftText: e.roleName,
                          rightText: e.adRoleID,
                        );
                      }).toList(),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 30,
                      width: size.width,
                      //color: Colors.red,
                      padding: EdgeInsets.only(left: defaultMargin),
                      margin: EdgeInsets.only(
                          bottom: defaultMargin * 0.1,
                          top: defaultMargin * 0.5),
                      child: Text('Device Info :', style: blackFontStyle2),
                    ),
                    SimpleTextDisplay(
                      leftText: 'Device Name :',
                      rightText: DeviceValue.devName,
                    ),
                    SimpleTextDisplay(
                      leftText: 'NFC support :',
                      rightText:
                          DeviceValue.isNFCsupport ? 'Yes' : 'Not supported',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signOut() async {
    await AccountRoles.clearall();
    await Locator.clearAll();
    await Production.clearAll();
    await TimeStampUpdate.clearAll();
    await UserData.logOut();
    await PendingSettings.clearToDefault();
    await PendingProductQC.clearall();
    await ProductQCUserPreferences.clearAll();
    Get.offAll(LoginScreen());
  }
}
