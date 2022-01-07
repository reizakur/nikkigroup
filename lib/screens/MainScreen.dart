part of 'screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

enum StatePage { firstPage, secondPage, thirdPage, reject }

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final pageController = PageController(initialPage: 0);
  StatePage pageScreen = StatePage.firstPage;
  AnimationController animCTR;
  Animation<double> animval;
  bool dimmed = false;
  Size size;
  GlobalKey<Sub2ScreenState> _homeScreen = GlobalKey();
  BackgroundService backgroundService;
  @override
  void dispose() {
    super.dispose();
    animCTR.dispose();
    backgroundService.dispose();
  }

  @override
  void initState() {
    super.initState();
    animpanel();
    backgroundServiceInit();
  }

  void backgroundServiceInit() {
    backgroundService = BackgroundService(
      onStartProcess: () {},
      onSucess: () => setState(() {}),
      onFailed: () {},
    );
    backgroundService.startService();
  }

  void animpanel() {
    animCTR = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    final curvedAnim = CurvedAnimation(
      parent: animCTR, curve: Curves.easeIn,
      //reverseCurve: Curves.easeOut
    );
    animval = Tween<double>(begin: -300, end: -0).animate(curvedAnim)
      ..addListener(() {
        setState(() {
          PrintDebug.printDialog(
              id: mainScreen_anim,
              msg: 'listener actived val is : ${animval.value}');
        });
      });
  }

  void toogledialog() {
    dimmed = !dimmed;
    if (dimmed) {
      animCTR.forward();
    } else {
      animCTR.reverse();
      //AddtoChartDialog.counter = 1;
    }
  }

  void switchingRole(AccountRoles selectedRole) async {
    await UserData.setCurrentRole(
      setRole: selectedRole,
    );
    toogledialog();
    Get.snackbar(
      "",
      "",
      duration: Duration(seconds: 6),
      backgroundColor: "f2c13a".toColor(),
      icon: Icon(MdiIcons.information, color: Colors.black),
      titleText: Text("Role Info",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w600)),
      messageText: Text("You are now using ${selectedRole.roleName} role",
          style: GoogleFonts.poppins(
            color: Colors.black,
          )),
    );
  }

  Widget roleSelectorWidget() {
    return Container(
      height: 250,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      alignment: Alignment.topCenter,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Tambah text
            Container(
              height: 40,
              width: 400,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black26, width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: size.height * 0.02),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Switch to available role(s):",
                      style: blackFontStyle2.copyWith(color: greyColor),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        toogledialog();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey,
                      ))
                ],
              ),
            ),
            Container(
              height: 200,
              width: 400,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin * 0.25,
                  vertical: defaultMargin * 0.5),
              child: ListView(
                children: AccountRoles.listofdata
                    .map((availRole) => CustomListTile(
                          onTap: () {
                            switchingRole(availRole);
                          },
                          disableTrailing: true,
                          leadingColor: mainColor,
                          title: availRole.roleName,
                          subtitle: availRole.adRoleID,
                          icon: Icons.person,
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  StatePage getPageState(int) {
    switch (int) {
      case 0:
        return StatePage.firstPage;
        break;
      case 1:
        return StatePage.secondPage;
        break;
      case 2:
        return StatePage.thirdPage;
        break;
      default:
        return StatePage.reject;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: blueGeneralUse,
    ));
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.yellow,
      child: SafeArea(
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //     child: Icon(Icons.android),
          //     onPressed: () async {
          //       BackgroundService dev = new BackgroundService(
          //         onFailed: () {},
          //         onSucess: () {},
          //         onStartProcess: () {},
          //       );
          //       await dev.pendingInOutBlock();
          //       setState(() {});
          //     }),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                key: PageStorageKey<String>('MyKey'),
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (int) {
                  setState(() {
                    pageScreen = getPageState(int);
                  });
                },
                children: [
                  Sub2screen(
                    key: _homeScreen,
                  ),
                  //Sub1Screen(),
                  TemporaryScreen(),
                  Sub3Screen(
                    showDialog: () {
                      toogledialog();
                    },
                  ),
                ],
              ),
              dimmed
                  ? GestureDetector(
                      onTap: () => toogledialog(),
                      child: Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black45,
                      ),
                    )
                  : SizedBox(),
              //bottom
              Container(
                height: size.height * 0.085,
                width: size.width,
                color: Colors.white,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 75,
                    width: size.width,
                    decoration: BoxDecoration(
                        // borderRadius:
                        //     BorderRadius.vertical(top: Radius.circular(0)),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.3),
                        //     spreadRadius: 7,
                        //     blurRadius: 5,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            color: pageScreen == StatePage.firstPage
                                ? Colors.blue
                                : Colors.white,
                            width: 3.0,
                          ))),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pageScreen = StatePage.firstPage;
                                pageController.jumpToPage(0);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: pageScreen == StatePage.firstPage
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 25,
                                ),
                                Text(
                                  'Home',
                                  style: blackFontStyle2.copyWith(
                                      fontSize: 15,
                                      color: pageScreen == StatePage.firstPage
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            color: pageScreen == StatePage.secondPage
                                ? Colors.blue
                                : Colors.white,
                            width: 3.0,
                          ))),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pageScreen = StatePage.secondPage;
                                pageController.jumpToPage(1);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.history,
                                  color: pageScreen == StatePage.secondPage
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 25,
                                ),
                                Text(
                                  'History',
                                  style: blackFontStyle2.copyWith(
                                      color: pageScreen == StatePage.secondPage
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                            color: pageScreen == StatePage.thirdPage
                                ? Colors.blue
                                : Colors.white,
                            width: 3.0,
                          ))),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pageScreen = StatePage.thirdPage;
                                pageController.jumpToPage(2);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: pageScreen == StatePage.thirdPage
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 25,
                                ),
                                Text(
                                  'Account',
                                  style: blackFontStyle2.copyWith(
                                      color: pageScreen == StatePage.thirdPage
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: animval.value, child: roleSelectorWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
