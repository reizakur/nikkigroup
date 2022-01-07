part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum loginState { loading, loginDisplay, roleDisplay, notFound }

class _LoginScreenState extends State<LoginScreen> {
  Size size;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  loginState displayState = loginState.loginDisplay;
  String roleselected = 'Select Role';
  String roleID = '0';
  bool _togglePassword = true;
  AccountService fetch = AccountService();

  void togglePassword() {
    setState(() {
      _togglePassword = !_togglePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Container(
                  height: 500,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/penguin.png'))),
                      ),
                      compSelector(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget compSelector() {
    switch (displayState) {
      case loginState.loginDisplay:
        return loginComp();
      case loginState.roleDisplay:
        return roleComp();
      case loginState.loading:
        return loadingComp();
      default:
        return loginComp();
    }
  }

  Widget loginComp() {
    return Column(
      children: [
        Container(
          height: 140,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: greyFontStyle,
                      hintText: "Username"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: passwordController,
                  obscureText: _togglePassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: togglePassword,
                          icon: Icon(
                            _togglePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: greyColor,
                          )),
                      border: InputBorder.none,
                      hintStyle: greyFontStyle,
                      hintText: "Password"),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: defaultMargin, right: defaultMargin, left: defaultMargin),
          height: 60,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    loginToAccount();
                  },
                  child: Text(
                    'Login',
                    style: blackFontStyle.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> loginToAccount() async {
    if (usernameController.text == null ||
        usernameController.text == '' ||
        passwordController.text == null ||
        passwordController.text == '') {
      Get.defaultDialog(
          title: 'Sorry',
          titleStyle: blackFontStyle.copyWith(color: Colors.red),
          content: Text(
            'Please fill the form correctly',
            style: greyFontStyle,
          ));
      return;
    }
    setState(() {
      displayState = loginState.loading;
    });
    var fetchStatus = await fetch.loginToAccount(
        username: usernameController.text, pass: passwordController.text);
    PrintDebug.printDialog(
        id: loginScreen, msg: 'val status SignIn $fetchStatus');

    switch (fetchStatus) {
      case 0:
        //success
        PrintDebug.printDialog(
            id: loginScreen, msg: 'Succesfully login to Account');
        selectRoleAccount();
        return;
      case 1:
        //Invalid User
        PrintDebug.printDialog(id: loginScreen, msg: 'Invalid Account');
        Get.snackbar(
          "",
          "",
          duration: Duration(seconds: 6),
          backgroundColor: "f2c13a".toColor(),
          icon: Icon(MdiIcons.login, color: Colors.black),
          titleText: Text("Login Failed",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w600)),
          messageText: Text("Incorrect Username or Password, please try again",
              style: GoogleFonts.poppins(
                color: Colors.black,
              )),
        );
        break;
      case 3:
        //connection Error
        Get.snackbar(
          "",
          "",
          duration: Duration(seconds: 6),
          backgroundColor: "D9435E".toColor(),
          icon: Icon(Icons.warning, color: Colors.white),
          titleText: Text("Connection Error",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600)),
          messageText:
              Text("Cannot communicate to the server, please try again later",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  )),
        );
        break;
    }
    setState(() {
      displayState = loginState.loginDisplay;
    });
  }

  Future<void> selectRoleAccount() async {
    fetch.setnamakey(keySearch: 'getListRoleByUser');
    var fetchStatus = await fetch.getUserRoles(
      username: usernameController.text,
    );
    roleselected = AccountRoles.listofdata[0].roleName;
    PrintDebug.printDialog(id: loginScreen, msg: 'Value fetch :$fetchStatus');
    setState(() {
      displayState = loginState.roleDisplay;
    });
  }

  Widget roleComp() {
    return Column(
      children: [
        Container(
          height: 148,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Account : ${usernameController.text}',
                    maxLines: 1,
                    style: blackFontStyle,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      child: Icon(MdiIcons.checkCircle, color: Colors.blue)),
                ],
              ),
              Text(
                'Please choose available Role(s) below to proceed :',
                maxLines: 1,
                style: blackFontStyle2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black)),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      style: greyFontStyle.copyWith(fontSize: 18),
                      isExpanded: true,
                      value: roleselected,
                      items: AccountRoles.listofdata
                          .map((e) => DropdownMenuItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: greyColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(e.roleName),
                                  ],
                                ),
                                value: e.roleName,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          roleselected = val.toString();
                        });
                        roleID = AccountRoles.listofdata
                            .firstWhere((i) => i.roleName == roleselected)
                            .adRoleID; // 1
                        PrintDebug.printDialog(
                            id: loginScreen,
                            msg:
                                'You are choosing $roleselected with iD :$roleID');
                      },
                      //style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ),
              Text(
                'You can change your role later',
                style: greyFontStyle,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: defaultMargin, right: defaultMargin, left: defaultMargin),
          height: 60,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      displayState = loginState.loginDisplay;
                    });
                  },
                  child: Text(
                    'Back',
                    style: blackFontStyle.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orangeAccent)),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    proceedButtonToMainPage();
                  },
                  child: Text(
                    'Proceed',
                    style: blackFontStyle.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void proceedButtonToMainPage() async {
    PrintDebug.printDialog(id: loginScreen, msg: '===[Summary]===');
    PrintDebug.printDialog(
        id: loginScreen, msg: 'user   : ${usernameController.text}');
    PrintDebug.printDialog(
        id: loginScreen, msg: 'pw     : ${passwordController.text}');
    PrintDebug.printDialog(id: loginScreen, msg: 'role   : $roleselected');
    PrintDebug.printDialog(id: loginScreen, msg: 'ID Role: $roleID');
    setState(() {
      displayState = loginState.loading;
    });
    await UserData.signIn(
      username: usernameController.text,
      password: passwordController.text,
      clientID: 'default Client ID',
      roleID: roleID,
      roleName: roleselected,
    );
    var fetchStatus = fetch.getAdUserId(username: usernameController.text);
    fetchStatus.then((value) {
      PrintDebug.printDialog(
          id: loginScreen, msg: 'val status getADuser $value');
      UserData.printdevinfo();
      if (value == 0) {
        Get.off(MainScreen());
      }
    });
  }

  Widget loadingComp() {
    return Column(
      children: [
        Container(height: 148, child: loadingIndicator),
        Container(
          child: Text(
            'Loading..',
            style: greyFontStyle,
          ),
        ),
      ],
    );
  }
}
