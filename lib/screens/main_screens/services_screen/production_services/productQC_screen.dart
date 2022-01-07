part of '../../../screens.dart';

class ProductQC extends StatefulWidget {
  @override
  _ProductQCState createState() => _ProductQCState();
}

class _ProductQCState extends State<ProductQC> {
  bool statusProduct = true;
  bool isFilledCorrectly = false;
  bool hasImage = false;
  String barcode, rfid;
  Size size;
  File _imagePicture;
  Locator selectedLocator;
  Operator selectedOperator;
  Production selectedProduct;
  ControlReject selectedReject;
  List<bool> validationColor = List.generate(5, (index) => true);
  bool useNFC = true;
  bool checkBoxVal = true;
  //above mine

  @override
  void initState() {
    super.initState();
    fetchSettings();
  }

  void fetchSettings() async {
    PrintDebug.printDialog(
        id: productQCScreen,
        msg: 'Remember Loc : ${ProductQCUserPreferences.getrememberLocator()}');
    PrintDebug.printDialog(
        id: productQCScreen,
        msg: 'Remember OP : ${ProductQCUserPreferences.getrememberOperator()}');
    PrintDebug.printDialog(
        id: productQCScreen,
        msg:
            'Remember Product : ${ProductQCUserPreferences.getrememberProduct()}');
    try {
      if (ProductQCUserPreferences.getSettings()) {
        try {
          if (Locator.listofdata.length == 0 ||
              ProductQCUserPreferences.getrememberLocator() == null) {
            throw ("Bad State");
          }
          if (ProductQCUserPreferences.rememberLocator()) {
            selectedLocator = Locator.listofdata.firstWhere((loc) =>
                loc.locatorID ==
                ProductQCUserPreferences.getrememberLocator()); // 1
          }
        } on Exception {
          print('Its works ?');
        }
        try {
          if (Operator.listofdata.length == 0 ||
              ProductQCUserPreferences.getrememberOperator() == null)
            throw ("Bad State Operator");
          if (ProductQCUserPreferences.rememberOperator()) {
            selectedOperator = Operator.listofdata.firstWhere((op) =>
                op.operatorID ==
                ProductQCUserPreferences.getrememberOperator()); // 1
          }
        } on Exception {}
        try {
          if (Production.listofdata.length == 0 ||
              ProductQCUserPreferences.getrememberLocator() == null)
            throw ("Bad State for Production");
          if (ProductQCUserPreferences.rememberProduct()) {
            selectedProduct = Production.listofdata.firstWhere((product) =>
                product.productID ==
                ProductQCUserPreferences.getrememberProduct()); // 1
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
      child: WillPopScope(
        onWillPop: () async {
          if (ProductQCUserPreferences.getSettings()) {
            await ProductQCUserPreferences.enableSetting(
                locator: selectedLocator != null ? true : false,
                operator: selectedOperator != null ? true : false,
                product: selectedProduct != null ? true : false);
            Get.back();
            return false;
          } else {
            return true;
          }
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
                            var select = await Get.to(() => SelectLocator());
                            if (select != null)
                              setState(() {
                                selectedLocator = select;
                              });
                          },
                          title: 'Location',
                          subtitle: Text(
                              selectedLocator == null
                                  ? 'Tap to choose location'
                                  : selectedLocator.locatorName,
                              style: blackFontStyle2),
                          trailing: CircleAvatar(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            backgroundColor: !validationColor[0]
                                ? Colors.red
                                : blueGeneralUse,
                          )),
                      SimpleListTile(
                          onTap: () async {
                            var select = await Get.to(() => SelectOperator());
                            if (select != null)
                              setState(() {
                                selectedOperator = select;
                              });
                          },
                          title: 'Operator',
                          subtitle: Text(
                              selectedOperator != null
                                  ? selectedOperator.getOperatorName
                                  : 'Tap to choose operator',
                              style: blackFontStyle2),
                          trailing: CircleAvatar(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            backgroundColor: !validationColor[1]
                                ? Colors.red
                                : blueGeneralUse,
                          )),
                      SimpleListTile(
                          onTap: () async {
                            var select = await Get.to(() => SelectProduction());
                            if (select != null)
                              setState(() {
                                selectedProduct = select;
                              });
                          },
                          title: 'Product',
                          subtitle: Text(
                              selectedProduct != null
                                  ? selectedProduct.productName
                                  : 'Tap to choose product',
                              style: blackFontStyle2),
                          trailing: CircleAvatar(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            backgroundColor: !validationColor[2]
                                ? Colors.red
                                : blueGeneralUse,
                          )),
                      SimpleListTile(
                        onTap: () => scanMethod(),
                        title: useNFC ? 'Scan QR Code' : 'Scan NFC tag',
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
                      SimpleListTile(
                        onTap: () async {
                          setState(() {
                            statusProduct = !statusProduct;
                          });
                        },
                        title: 'Lolos QC ',
                        subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                              maxWidth: 80,
                              minWidth: 30,
                              maxHeight: 30,
                            ),
                            decoration: BoxDecoration(
                                color:
                                    statusProduct ? Colors.red : Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Text(statusProduct ? 'No' : 'Yes',
                                style: blackFontStyle2.copyWith(
                                    color: Colors.white)),
                          ),
                        ),
                        trailing: Switch(
                          value: statusProduct,
                          activeColor: Colors.red,
                          inactiveTrackColor: Colors.redAccent.withOpacity(0.7),
                          inactiveThumbColor: Colors.blue,
                          onChanged: (val) {
                            setState(() {
                              statusProduct = val;
                            });
                          },
                        ),
                      ),
                      statusProduct
                          ? SimpleListTile(
                              onTap: () async {
                                var select =
                                    await Get.to(() => SelectKeterangan());
                                if (select != null)
                                  setState(() {
                                    selectedReject = select;
                                  });
                              },
                              title: 'Reason',
                              subtitle: Text(
                                  selectedReject != null
                                      ? selectedReject.rejectName
                                      : 'Tap to choose product',
                                  style: blackFontStyle2),
                              trailing: CircleAvatar(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                backgroundColor: !validationColor[4]
                                    ? Colors.red
                                    : blueGeneralUse,
                              ),
                            )
                          : Container(),
                      SimpleListTile(
                          onTap: () => selectmethodtoupload(
                              this.context, 'Choose Image'),
                          title: 'Product Image',
                          subtitle: Text(
                              _imagePicture != null
                                  ? basename(_imagePicture.path)
                                  : 'No file choosen',
                              style: blackFontStyle2),
                          trailing: CircleAvatar(
                            child: Icon(
                              Icons.insert_photo,
                              color: Colors.white,
                            ),
                            backgroundColor: !validationColor[4]
                                ? Colors.red
                                : blueGeneralUse,
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: 130,
                          margin: EdgeInsets.only(
                              right: defaultMargin, top: defaultMargin),
                          child: ElevatedButton(
                            onPressed: () {
                              onSubmitButton();
                            },
                            child: Text(
                              'Submit',
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
                      ),
                    ],
                  ),
                ),
                CustomAppBar(
                  height: 80,
                  title: 'Product QC',
                  subtitle: 'Product Quality check',
                  onTrailingButtonPressed: () {
                    Get.to(() => ProductQCSettingsPage());
                  },
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

  bool validationInput() {
    bool isValid = true;
    List<dynamic> inputCheck = [
      selectedLocator,
      selectedOperator,
      selectedProduct,
      [rfid, barcode],
      _imagePicture
    ];

    for (int i = 0; i < inputCheck.length; i++) {
      if (i == 4) continue;
      if (i == 3) {
        if (!useNFC) {
          if (rfid == null) {
            PrintDebug.printDialog(
                id: productQCScreen, msg: 'Value of rfid $rfid');
            validationColor[3] = false;
            isValid = false;
          } else {
            validationColor[3] = true;
          }
        } else {
          PrintDebug.printDialog(
              id: productQCScreen, msg: 'Value of barcode $barcode');
          if (barcode == null) {
            validationColor[3] = false;
            isValid = false;
          } else {
            validationColor[3] = true;
          }
        }
        continue;
      }
      if (inputCheck[i] == null) {
        validationColor[i] = false;
        isValid = false;
      } else {
        validationColor[i] = true;
      }
      setState(() {});
    }
    return isValid;
  }

  void onSubmitButton() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    TestingCodec coba = TestingCodec();
    TestingCodec.data = await deviceInfoPlugin.androidInfo;
    print(json.encode(coba.getData()).toString());
  }

  void onSubmitButton2() async {
    PrintDebug.printDialog(
        id: productQCScreen, msg: 'valid result : ${validationInput()}');
    if (!validationInput()) {
      Get.snackbar(
        "",
        "",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning_amber_outlined, color: Colors.white),
        titleText: Text("Cannot submit your request",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
        messageText: Text("Please fill the data correctly",
            style: GoogleFonts.poppins(
              color: Colors.white,
            )),
      );
      return;
    }
    String newPath;

    if (_imagePicture != null) {
      String dir = (await getApplicationDocumentsDirectory()).path;
      newPath = join(dir, 'PendingProduct_${selectedProduct.productName}.jpg');

      File f = await File(_imagePicture.path).copy(newPath);
      var syncPath = f.path;
// for a file
      bool ada = await File(syncPath).exists();
      if (ada)
        PrintDebug.printDialog(id: productQCScreen, msg: 'file ada ${f.path}');
    } else {
      newPath = "No Image";
    }
    DateTime now = DateTime.now();
    PendingProductQC newData = new PendingProductQC.insert(
        colActionType: 'ProductQC',
        colSubmitTime: now,
        colUserID: UserData.getUserID(),
        colStatus: 'pending',
        colUserName: UserData.getUsername(),
        colPass: UserData.getPassword(),
        colRoleID: UserData.getUserCurrentRoleID(),
        colLocatorDBversion: TimeStampUpdate.getLocatorUpdateTimeStamp(),
        colProductDBversion: TimeStampUpdate.getProductUpdateTimeStamp(),
        locator: selectedLocator,
        operator: selectedOperator,
        // keterangan: selectedReject,
        product: selectedProduct,
        colProductStatus: statusProduct ? 'Rejected' : 'Accepted',
        colProductRegistration: !useNFC ? 'RFID-$rfid' : 'QR-$barcode',
        colImagePath: newPath);
    newData.printAllData();
    await newData.insertToDatabase();
    PrintDebug.printDialog(
        id: productQCScreen,
        msg: 'Setting ons ${ProductQCUserPreferences.getSettings()}');
    if (ProductQCUserPreferences.getSettings()) {
      await ProductQCUserPreferences.updateChoice(
          locator: selectedLocator.locatorID,
          operator: selectedOperator.operatorID,
          product: selectedProduct.productID);
      reloadWidget();
      return;
    }
    reloadWidget();
  }

  void reloadWidget() {
    hasImage = false;
    _imagePicture = null;
    Get.snackbar(
      "",
      "",
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check, color: Colors.white),
      titleText: Text("Successfully added new data",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600)),
      messageText: Text("check temporary to review your data(s)",
          style: GoogleFonts.poppins(
            color: Colors.white,
          )),
    );

    setState(() {
      statusProduct = true;
      hasImage = false;
      _imagePicture = null;
      rfid = null;
      barcode = null;
    });
  }

  Widget confirmWidget() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: defaultMargin, left: defaultMargin),
          child: Text(
            'Product QC :',
            style: blackFontStyle,
          ),
        ),
        Container(
          height: 100,
          width: 100,
          margin:
              EdgeInsets.only(bottom: defaultMargin * 0.2, left: defaultMargin),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(_imagePicture), fit: BoxFit.contain),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        SimpleTextDisplayWtIcon(
          leftText: 'Product :',
          rightText: selectedProduct.productName,
          leadingIcon: Icon(
            Icons.widgets,
            color: Colors.orange,
          ),
        ),
        SimpleTextDisplayWtIcon(
          leftText: 'Status product :',
          rightText: statusProduct ? 'Accepted' : 'Rejected',
          rightColor: statusProduct ? Colors.green : Colors.red,
          leadingIcon: Icon(
            MdiIcons.checkCircle,
            color: Colors.orange,
          ),
        ),
        SimpleTextDisplayWtIcon(
          leftText: 'Operator :',
          rightText: selectedOperator.getOperatorName,
          leadingIcon: Icon(
            Icons.person,
            color: Colors.orange,
          ),
        ),
        SimpleTextDisplayWtIcon(
          leftText: 'Locator :',
          rightText: selectedLocator.locatorName,
          leadingIcon: Icon(
            MdiIcons.mapMarker,
            color: Colors.orange,
          ),
        ),
        SimpleTextDisplayWtIcon(
          leftText: useNFC ? 'QR Code :' : 'RFID :',
          rightText: !useNFC ? rfid : barcode,
          leadingIcon: Icon(
            !useNFC ? MdiIcons.nfc : MdiIcons.qrcode,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget productImageChooser() {
    return CustomListTile(
      icon: Icons.insert_photo,
      leadingColor: !validationColor[4] ? Colors.red : null,
      title: 'Add Image',
      subtitle: 'Format : .jpeg/.jpg/.png',
      onTap: () {
        selectmethodtoupload(this.context, 'Choose Image');
      },
    );
  }

  void scanMethod() async {
    if (!useNFC) {
      if (DeviceValue.isNFCsupport) {
        var temp = await Get.to(() => NFCScanner());
        if (temp != null) rfid = temp;
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
      barcode = await BarcodeScanner.scan();
      setState(() {
        //if (barcode == null) validationColor[3] = false;
      });
    }
  }

  String subtitleForScan() {
    if (!useNFC) {
      if (rfid != null) {
        return rfid;
      } else {
        return 'Tap to Scan NFC';
      }
    } else {
      if (barcode != null) {
        return barcode;
      } else {
        return 'Tap to Scan QR Code';
      }
    }
  }

  Widget productImage() {
    return hasImage
        ? Container(
            height: 100,
            width: size.width,
            margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
            alignment: Alignment.centerLeft,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () =>
                        selectmethodtoupload(this.context, 'Choose Image'),
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(bottom: defaultMargin * 0.2),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_imagePicture),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: defaultMargin * 0.5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tap Image to remove/change',
                        style: blackFontStyle2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        //padding: EdgeInsets.only(right: defaultMargin),
                        width: size.width * 0.6,
                        child: Text(
                          basename(_imagePicture.path),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: blackFontStyle3,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Widget scanModeHyperlink({bool validationCheck = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          useNFC = !useNFC;
          if (!useNFC) {
            if (validationCheck) if (rfid == null) validationColor[3] = false;
          } else {
            if (validationCheck) if (barcode == null)
              validationColor[3] = false;
          }
        });
      },
      child: Container(
        height: 30,
        margin: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            bottom: defaultMargin * 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              useNFC ? MdiIcons.nfc : Icons.qr_code,
              color: Colors.blue,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              useNFC ? 'Use NFC instead' : 'Use QR Code instead',
              style: greyFontStyle.copyWith(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
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
                    _imagePicture = null;
                    hasImage = false;
                    setState(() {
                      Navigator.pop(context);
                    });
                  }),
              CupertinoDialogAction(
                child: const Text('Camera'),
                onPressed: () async {
                  print('Camera');
                  getimage(ImageSource.camera).then((gambar) {
                    _imagePicture = gambar;
                    hasImage = _imagePicture != null ? true : false;
                    setState(() {});
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
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
