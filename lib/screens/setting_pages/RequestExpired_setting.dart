part of '../screens.dart';

class ExpiredSettingPage extends StatefulWidget {
  const ExpiredSettingPage({Key key}) : super(key: key);

  @override
  _ExpiredSettingPageState createState() => _ExpiredSettingPageState();
}

class _ExpiredSettingPageState extends State<ExpiredSettingPage> {
  TextEditingController _textController = TextEditingController();
  int day = 30;
  Size size;

  @override
  void initState() {
    super.initState();
    day = PendingSettings.getExpiredDayThreshold();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: WillPopScope(
        onWillPop: () async {
          // if (ProductQCUserPreferences.getSettings()) {
          //   ProductQCUserPreferences.enableSetting(
          //       runscript: () => Get.back(),
          //       locator: selectedLocator != null ? true : false,
          //       operator: selectedOperator != null ? true : false,
          //       product: selectedProduct != null ? true : false);
          //   return false;
          // } else {
          //   return true;
          // }
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: greyBackground,
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SimpleListTile(
                          onTap: () async {
                            var result = await setDays();
                            if (result > 0 && result < 31) day = result;
                            setState(() {});
                          },
                          title: 'Remove history data every',
                          subtitle: Text(
                            getResultSTR(),
                            style: blackFontStyle3,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_rounded)),
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
                              style:
                                  blackFontStyle.copyWith(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                backgroundColor:
                                    MaterialStateProperty.all(blueGeneralUse)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomAppBar(
                  height: 80,
                  title: 'Setting',
                  subtitle: 'Pending request',
                  onBackButtonPressed: () {
                    Get.back();
                  },
                  color: blueGeneralUse,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmitButton() async {
    await PendingSettings.setExpiredDays(newDays: day.toString());
    Get.back();
  }

  String getResultSTR() {
    switch (day) {
      case 30:
        return '30 days (default)';
      default:
        return '$day days';
    }
  }

  // ignore: missing_return
  Future<int> setDays() async {
    _textController.text = day.toString();
    await showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              'Remove history data every',
              style: blackFontStyle2,
            ),
            content: Column(
              children: [
                Text(
                  'Days : ',
                  style: blackFontStyle3,
                ),
                CupertinoTextField(
                  textAlign: TextAlign.center,
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('OK')),
            ],
          );
        });
    if (int.parse(_textController.text) > 30 ||
        int.parse(_textController.text) <= 0) errorDialog();
    return int.parse(_textController.text);
  }

  Future<void> errorDialog() async {
    await showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              'the allowed maximum for the day is 30 !',
              style: blackFontStyle2.copyWith(color: Colors.red),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('OK')),
            ],
          );
        });
  }
}
