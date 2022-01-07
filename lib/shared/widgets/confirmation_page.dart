part of '../shared.dart';

// ignore: must_be_immutable
class ConfirmationPage extends StatelessWidget {
  final String appBarTitle;
  final String yesButtonText;
  final String noButtonText;
  final Function yesButton;
  final Function noButton;
  final Function backButton;
  final Widget child;

  ConfirmationPage(
      {@required this.appBarTitle,
      @required this.yesButtonText,
      this.noButtonText,
      @required this.yesButton,
      this.noButton,
      @required this.backButton,
      @required this.child});

  // Widget dummyWidget = Column(
  //   children: [
  //     Container(
  //       alignment: Alignment.centerLeft,
  //       margin: EdgeInsets.only(bottom: defaultMargin, left: defaultMargin),
  //       child: Text(
  //         'Product QC :',
  //         style: blackFontStyle,
  //       ),
  //     ),
  //     Container(
  //       height: 100,
  //       width: 100,
  //       margin:
  //           EdgeInsets.only(bottom: defaultMargin * 0.2, left: defaultMargin),
  //       decoration: BoxDecoration(
  //           color: Colors.yellow,
  //           // image: DecorationImage(
  //           //     image: FileImage(_imagePicture),
  //           //     fit: BoxFit.contain),
  //           borderRadius: BorderRadius.all(Radius.circular(10))),
  //     ),
  //     SimpleTextDisplayWtIcon(
  //       leftText: 'Product :',
  //       rightText: 'Pengunin hitam 23829108',
  //       leadingIcon: Icon(
  //         Icons.widgets,
  //         color: Colors.orange,
  //       ),
  //     ),
  //     SimpleTextDisplayWtIcon(
  //       leftText: 'Status product :',
  //       rightText: 'Rejected',
  //       rightColor: Colors.red,
  //       leadingIcon: Icon(
  //         MdiIcons.checkCircle,
  //         color: Colors.orange,
  //       ),
  //     ),
  //     SimpleTextDisplayWtIcon(
  //       leftText: 'Operator :',
  //       rightText: 'Kusnandar',
  //       leadingIcon: Icon(
  //         Icons.person,
  //         color: Colors.orange,
  //       ),
  //     ),
  //     SimpleTextDisplayWtIcon(
  //       leftText: 'Locator :',
  //       rightText: 'ALF-KRW',
  //       leadingIcon: Icon(
  //         MdiIcons.mapMarker,
  //         color: Colors.orange,
  //       ),
  //     ),
  //     SimpleTextDisplayWtIcon(
  //       leftText: 'RFID :',
  //       rightText: 'xxxxxxxxxxxx',
  //       leadingIcon: Icon(
  //         MdiIcons.nfc,
  //         color: Colors.orange,
  //       ),
  //     ),
  //   ],
  // );
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
          centerTitle: true,
          title: Text(appBarTitle,
              style: blackFontStyle.copyWith(
                color: Colors.white,
              )),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'please check the Data above before proceeding',
                    style: blackFontStyle2.copyWith(color: greyColor),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      noButton != null
                          ? Container(
                              height: 50,
                              width: 130,
                              margin: EdgeInsets.only(
                                  right: defaultMargin,
                                  top: defaultMargin * 0.5),
                              child: ElevatedButton(
                                onPressed: () {
                                  noButton();
                                },
                                child: Text(
                                  noButtonText,
                                  textAlign: TextAlign.center,
                                  style: blackFontStyle.copyWith(
                                      color: Colors.white),
                                ),
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange)),
                              ),
                            )
                          : SizedBox(),
                      Container(
                        height: 50,
                        width: 150,
                        margin: EdgeInsets.only(
                            right: defaultMargin, top: defaultMargin * 0.5),
                        child: ElevatedButton(
                          onPressed: () {
                            yesButton();
                          },
                          child: Text(
                            yesButtonText,
                            textAlign: TextAlign.center,
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
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
