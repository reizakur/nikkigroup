part of '../../../screens.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String idShipment, contentData;
  bool useQR = false;
  int productsCount = 0;
  List<Shipment> productsList = [];
  //----------------

  bool statusProduct = true;
  bool isFilledCorrectly = false;
  bool hasImage = false;
  String barcode, rfid;
  Size size;
  File _imagePicture;
  Locator selectedLocator;
  Operator selectedOperator;
  Production selectedProduct;
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
        id: ProductQCBranchScreen,
        msg: 'Remember Loc : ${ProductQCUserPreferences.getrememberLocator()}');
    PrintDebug.printDialog(
        id: ProductQCBranchScreen,
        msg: 'Remember OP : ${ProductQCUserPreferences.getrememberOperator()}');
    PrintDebug.printDialog(
        id: ProductQCBranchScreen,
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
    print('cek shipment list ${Shipment.listofdata.length}');
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
                        trailing: Container(
                          // color: Colors.red,
                          width: 86,
                          child: Row(
                            children: [
                              Container(
                                width: 43,
                                //  height: 100,
                                //  color: Colors.blue,
                                child: CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        scanMethod();
                                        setState(() {});
                                      },
                                      icon:
                                          Icon(Icons.qr_code_scanner_rounded)),
                                ),
                              ),
                              Container(
                                width: 43,
                                //  height: 100,
                                //  color: Colors.green,
                                child: CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          selectmethodtoupload(
                                              this.context, 'Choose Image');
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.camera_alt))),
                              ),
                            ],
                          ),
                        ),
                        //  onTap: () => scanMethod(),
                        title: 'Surat Jalan',
                        subtitle: Text(
                            _imagePicture != null
                                ? contentData
                                : 'No file choosen',
                            style: blackFontStyle2),
                      ),
                      SimpleListTile(
                        onTap: () async {
                          productsList = await Get.to(() => DeliveryProduct(
                                spId: idShipment,
                                spContent: contentData,
                                spOptional: this.useQR ? 'QR' : 'IMG',
                              ));

                          if (productsList.length > 0) {
                            productsCount = productsList.length;
                            productsList.map((shipment) {
                              shipment.SP_ID = this.idShipment;
                              shipment.SP_Optional = this.useQR ? 'QR' : 'IMG';
                              shipment.SP_Content = this.contentData;
                            });
                          } else {
                            productsCount = 0;
                          }
                          setState(() {});
                        },
                        title: 'Product',
                        subtitle: Text('Tap to scan ', style: blackFontStyle2),
                        trailing: CircleAvatar(
                          child: Text('$productsCount',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor:
                              !validationColor[0] ? Colors.red : blueGeneralUse,
                        ),
                      ),
                      SimpleListTile(
                        trailing: Container(
                          // color: Colors.red,
                          width: 86,
                          child: Row(
                            children: [
                              Container(
                                width: 43,
                                //  height: 100,
                                //  color: Colors.green,
                                child: CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          selectmethodtoupload(
                                              this.context, 'Choose Imagee');
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.camera_alt))),
                              ),
                            ],
                          ),
                        ),
                        //  onTap: () => scanMethod(),
                        title: 'Image Shipment',
                        subtitle: Text(
                            _imagePicture != null
                                ? contentData
                                : 'No file choosen',
                            style: blackFontStyle2),
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
                  title: 'Product QC Branch',
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
      if (i == 3) {
        if (!useNFC) {
          if (rfid == null) {
            PrintDebug.printDialog(
                id: ProductQCBranchScreen, msg: 'Value of rfid $rfid');
            validationColor[3] = false;
            isValid = false;
          } else {
            validationColor[3] = true;
          }
        } else {
          PrintDebug.printDialog(
              id: ProductQCBranchScreen, msg: 'Value of barcode $barcode');
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
    print('Cek panjang list product ${productsList.length}');
    print('Cek panjang list global ${Shipment.listofdata.length}');
    await Shipment.updateDatabase();
    for (int i = 0; i < productsList.length; i++) {
      Shipment.listofdata.add(productsList[i]);
    }
    await Shipment.updateDatabase();
    print(
        'Cek panjang list global setelah ditambah ${Shipment.listofdata.length}');
    Get.back();
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
    barcode = await BarcodeScanner.scan();
    useQR = true;
    idShipment = "QR-${barcode}";
    contentData = barcode;
    try {} on Exception {}

    setState(() {
      //if (barcode == null) validationColor[3] = false;
    });
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

  String trailingForScan() {
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
        return 'child: ';
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
                  getimage(ImageSource.camera).then((gambar) async {
                    _imagePicture = gambar;
                    hasImage = _imagePicture != null ? true : false;
                    await setShipmentToFileIMG(_imagePicture);
                    setState(() {});
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> setShipmentToFileIMG(File img) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = join(dir, 'ShipmentIMG_$idShipment.jpg');
    File f = await File(img.path).copy(newPath);
    var syncPath = f.path;
// for a file
    bool ada = await File(syncPath).exists();
    if (ada) {
      var uuid = Uuid();
      var uniqCode = uuid.v1();
      uniqCode = uniqCode.substring(1, 7);
      contentData = newPath;
      useQR = false;
      idShipment = "CAM-$uniqCode";
      if (productsList.length > 0) {
        productsCount = productsList.length;
        productsList.map((shipment) {
          shipment.SP_ID = this.idShipment;
          shipment.SP_Optional = this.useQR ? 'QR' : 'IMG';
          shipment.SP_Content = this.contentData;
        });
      } else {
        productsCount = 0;
      }
    } else {
      print("ERROR");
    }
    return;
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
