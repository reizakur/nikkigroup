part of '../shared.dart';

// ignore: must_be_immutable
class InputOutputPage extends StatefulWidget {
  final String titleRole;
  final String subtitleRole;
  final Function onSubmitButton;
  static File imagePicture;
  static bool hasImage = false;
  final bool useLoc;
  static bool useNFC = true;
  static String barcode, rfid;
  static Locator selectedLocator;

  InputOutputPage({
    Key key,
    this.useLoc = true,
    @required this.titleRole,
    @required this.subtitleRole,
    @required this.onSubmitButton,
  }) : super(key: key);

  @override
  _InputOutputPageState createState() => _InputOutputPageState();
}

class _InputOutputPageState extends State<InputOutputPage> {
  bool checkBoxVal = true;
  Size size;

  @override
  initState() {
    super.initState();
    fetchSettings();
  }

  void selectmethodtoupload(BuildContext context, String str) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Choose Picture'),
            content: Text(str),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: const Text(
                    'Hapus Foto',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    InputOutputPage.imagePicture = null;
                    InputOutputPage.hasImage = false;
                    setState(() {
                      Navigator.pop(context);
                    });
                  }),
              CupertinoDialogAction(
                child: const Text('From a File'),
                onPressed: () async {
                  print('From a File');
                  getimage(ImageSource.gallery).then((gambar) {
                    InputOutputPage.imagePicture = gambar;
                    InputOutputPage.hasImage =
                        InputOutputPage.imagePicture != null ? true : false;
                    setState(() {});
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Camera'),
                onPressed: () async {
                  print('Camera');
                  getimage(ImageSource.camera).then((gambar) {
                    InputOutputPage.imagePicture = gambar;
                    InputOutputPage.hasImage =
                        InputOutputPage.imagePicture != null ? true : false;
                    setState(() {});
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void fetchSettings() async {
    PrintDebug.printDialog(
        id: productQCScreen,
        msg: 'Remember Loc : ${ProductQCUserPreferences.getrememberLocator()}');

    try {
      if (Locator.listofdata.length == 0 ||
          ProductQCUserPreferences.rememberLocator() == null) return;
      if (ProductQCUserPreferences.getSettings()) {
        try {
          if (ProductQCUserPreferences.rememberLocator()) {
            InputOutputPage.selectedLocator = Locator.listofdata.firstWhere(
                (loc) =>
                    loc.locatorID ==
                    ProductQCUserPreferences.getrememberLocator()); // 1
          }
        } on Exception {}
      }
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
            child: Scaffold(
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    widget.useLoc
                        ? SimpleListTile(
                            color: greyColor,
                            onTap: () async {
                              var select = await Get.to(() => SelectLocator());
                              if (select != null)
                                setState(() {
                                  InputOutputPage.selectedLocator = select;
                                });
                            },
                            title: InputOutputPage.selectedLocator == null
                                ? 'No Locator'
                                : InputOutputPage.selectedLocator.locatorName,
                            subtitle: Text('Tap to change locator'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded))
                        : SizedBox(),
                    // widget.useLoc
                    //     ? SimpleListTile(
                    //         color: greyColor,
                    //         onTap: () async {
                    //           var select = await Get.to(() => SelectLocator());
                    //           if (select != null)
                    //             setState(() {
                    //               InputOutputPage.selectedLocator = select;
                    //             });
                    //         },
                    //         title: InputOutputPage.selectedLocator == null
                    //             ? 'Input Nama'
                    //             : InputOutputPage.selectedLocator.locatorName,
                    //         subtitle: Text('Tap to change locator'),
                    //         trailing: Icon(Icons.arrow_forward_ios_rounded))
                    //     : SizedBox(),
                    widget.useLoc
                        ? SizedBox()
                        : SimpleListTile(
                            onTap: () => selectmethodtoupload(
                                this.context, 'Choose Image'),
                            title: 'Product Image',
                            subtitle: Text(
                                InputOutputPage.imagePicture != null
                                    ? basename(
                                        InputOutputPage.imagePicture.path)
                                    : 'No file choosen',
                                style: blackFontStyle2),
                            trailing: CircleAvatar(
                              child: Icon(
                                Icons.insert_photo,
                                color: Colors.white,
                              ),
                            )),
                    SimpleListTile(
                      onTap: () => scanMethod(),
                      title: InputOutputPage.useNFC
                          ? 'Scan QR Code'
                          : 'Scan NFC tag',
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              subtitleForScan(),
                              style: blackFontStyle2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 130,
                        margin: EdgeInsets.only(
                            right: defaultMargin, top: defaultMargin),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onSubmitButton();
                          },
                          child: Text(
                            'Submit',
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
                    ),
                  ],
                ),
              ),
              CustomAppBar(
                height: 80,
                title: '${widget.titleRole}',
                subtitle: 'current role : ${widget.subtitleRole}',
                onBackButtonPressed: () {
                  //Get.back();
                },
                color: blueGeneralUse,
                textColor: Colors.white,
              ),
            ],
          ),
        )));
  }

  String subtitleForScan() {
    if (!InputOutputPage.useNFC) {
      if (InputOutputPage.rfid != null) {
        return InputOutputPage.rfid;
      } else {
        return 'Tap to Scan NFC';
      }
    } else {
      if (InputOutputPage.barcode != null) {
        return InputOutputPage.barcode;
      } else {
        return 'Tap to Scan QR Code';
      }
    }
  }

  void scanMethod() async {
    if (!InputOutputPage.useNFC) {
      if (DeviceValue.isNFCsupport) {
        var temp = await Get.to(() => NFCScanner());
        if (temp != null) InputOutputPage.rfid = temp;
        setState(() {});
      } else {
        Get.to(() => IlustrationDialog(
              asset: 'assets/gagal.png',
              title: "Sorry your device is not supported for NFC",
              subtitle: 'Please use QR Code instead',
              sub2title:
                  '${DeviceValue.devManufactureName}\nDevice model : ${DeviceValue.devName}',
              buttonTitle: 'Ok',
              colorButton: Colors.orange,
              onTap: () {
                Get.back();
              },
            ));
      }
    } else {
      InputOutputPage.barcode = await BarcodeScanner.scan();
      setState(() {
        //if (barcode == null) validationColor[3] = false;
      });
    }
  }

  Future<File> getimage(ImageSource source) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);
    //return image;
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 800,
          maxHeight: 800,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.lightBlueAccent,
              toolbarTitle: "Crop Image",
              statusBarColor: Colors.brown,
              backgroundColor: Colors.white));
      return cropped;
    }
    return null;
  }
}
