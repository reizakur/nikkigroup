part of '../../../screens.dart';

class DeliveryProduct extends StatefulWidget {
  DeliveryProduct(
      {@required this.spId,
      @required this.spOptional,
      @required this.spContent});
  final String spId;
  final String spOptional;
  final String spContent;

  @override
  _DeliveryProductState createState() => _DeliveryProductState();
}

class _DeliveryProductState extends State<DeliveryProduct> {
  List<Shipment> productList = [];
  String idProduct, contentProduct;
  bool useQR;
  int counter = 0;
  // ---------------------

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

  ////
  Future<int> createAlertDialogProdukQR(BuildContext context, newData) async {
    var temp = 0;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Scan Shipment Ulang?'),
            content: Text('Anda yakin untuk mengulang dari awal?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    productList.add(newData);
                    temp = 1;
                  },
                  child: Text('Next')),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    productList.add(newData);

                    temp = 0;
                  },
                  child: Text('Finish'))
            ],
          );
        });
    return temp;
  }

  Future<bool> createAlertDialogSimpan(BuildContext context) async {
    var temp = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Apakah Shipment Anda benar?'),
            content: Text(
                'Anda tidak dapat mengubah shipment setelah melanjut kembali. Tetap lanjutkan?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    temp = false;
                  },
                  child: Text('Batal')),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    temp = true;
                  },
                  child: Text('Kirimkan'))
            ],
          );
        });
    return temp;
  }

  ////
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
    counter = 0;
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
                  child: Column(
                    //  shrinkWrap: true,
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
                                        },
                                        icon: Icon(Icons.camera_alt))),
                              ),
                            ],
                          ),
                        ),
                        //  onTap: () => canMethod(),

                        title: 'Scan Product',

                        subtitle: Text(
                            _imagePicture != null
                                ? basename(_imagePicture.path)
                                : 'No file choosen',
                            style: blackFontStyle2),
                      ),
                      Container(
                        height: 500,
                        color: Colors.red,
                        child: ListView(
                            children: productList.map((e) {
                          counter++;
                          return SimpleListTile(
                            //  onTap: () => scanMethod(),
                            title: '${e.SP_ProductionContent}',
                            subtitle: Text('${e.SP_ProductionOptional}'),
                            leading: CircleAvatar(child: Text('$counter')),
                          );
                        }).toList()),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                width: 55,
                              ),
                              Container(
                                height: 50,
                                width: 130,
                                margin: EdgeInsets.only(
                                    right: defaultMargin, top: defaultMargin),
                                child: ElevatedButton(
                                  onPressed: () {
                                    onSubmitButton();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: blackFontStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              blueGeneralUse)),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 130,
                                margin: EdgeInsets.only(
                                    right: defaultMargin, top: defaultMargin),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var lanjut =
                                        await createAlertDialogSimpan(context);
                                    if (lanjut) {
                                      Get.back(result: productList);
                                    }
                                  },
                                  child: Text(
                                    'Next',
                                    style: blackFontStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              blueGeneralUse)),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                CustomAppBar(
                  height: 80,
                  title: 'Delivery',
                  subtitle: 'Shipment product',
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
    PrintDebug.printDialog(
        id: ProductQCBranchScreen, msg: 'valid result : ${validationInput()}');
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

    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath =
        join(dir, 'PendingProduct_${selectedProduct.productName}.jpg');
    File f = await File(_imagePicture.path).copy(newPath);
    var syncPath = f.path;
// for a file
    bool ada = await File(syncPath).exists();
    if (ada)
      PrintDebug.printDialog(
          id: ProductQCBranchScreen, msg: 'file ada ${f.path}');
    DateTime now = DateTime.now();
    print('=====DATA CHECK======');
    print('Cek ID Shiment ${widget.spId} ');
    print('Cek content Shiment ${widget.spContent} ');
    print('cek optional shipment ${widget.spOptional}');
    print('cek id product ${idProduct}');
    print('cek productOp ${useNFC ? 'QR' : 'IMG'}');
    print('cek content product ${contentProduct}');
    Shipment newData = new Shipment.createData(
      spId: widget.spId,
      spOptional: widget.spOptional,
      spContent: widget.spContent,
      spProductionID: idProduct,
      spProductionOptional: useNFC ? 'QR' : 'IMG',
      spProductionContent: contentProduct,
    );
    newData.displayInformation();
    await newData.insertToDatabase();
    PrintDebug.printDialog(
        id: ProductQCBranchScreen,
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
    barcode = await BarcodeScanner.scan();

    idProduct = "Product-QR-$barcode";
    useQR = true;
    contentProduct = barcode;
    print('=====DATA CHECK======');
    print('Cek ID Shiment ${widget.spId} ');
    print('Cek content Shiment ${widget.spContent} ');
    print('cek optional shipment ${widget.spOptional}');
    print('cek id product ${idProduct}');
    print('cek productOp ${useNFC ? 'QR' : 'IMG'}');
    print('cek content product ${contentProduct}');
    Shipment newData = Shipment.createData(
        spId: widget.spId,
        spContent: widget.spContent,
        spOptional: widget.spOptional,
        spProductionID: idProduct,
        spProductionOptional: useQR ? 'QR' : 'IMG',
        spProductionContent: barcode);

    if (productList
            .where((element) => element.SP_ProductionContent == barcode)
            .length >
        0) {
      print("GABISA");
    } else {
      var a = await createAlertDialogProdukQR(this.context, newData);
      setState(() {});
      print('hasil a $a');
      if (a == 1) scanMethod();
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
                child: const Text('From a File'),
                onPressed: () async {
                  print('From a File');
                  getimage(ImageSource.gallery).then((gambar) async {
                    _imagePicture = gambar;
                    hasImage = _imagePicture != null ? true : false;
                    bool ada = await _imagePicture.exists();
                    if (ada) await setShipmentToFileIMG(gambar);
                    setState(() {});
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Camera'),
                onPressed: () async {
                  print('Camera');
                  getimage(ImageSource.camera).then((gambar) async {
                    _imagePicture = gambar;
                    hasImage = _imagePicture != null ? true : false;
                    bool ada = await _imagePicture.exists();
                    print('Sebetulnya ada gk sih ?$ada');
                    if (ada) await setShipmentToFileIMG(gambar);
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
    var uuid = Uuid();
    var uniqCode = uuid.v1();
    uniqCode = uniqCode.substring(1, 7);
    useQR = false;
    idProduct = "Product-CAM-$uniqCode";
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = join(dir, 'ProductIMG_$idProduct.jpg');
    File f = await File(img.path).copy(newPath);
    var syncPath = f.path;
// for a file
    bool ada = await File(syncPath).exists();
    if (ada) {
      print('=====DATA CHECK======');
      print('Cek ID Shiment ${widget.spId} ');
      print('Cek content Shiment ${widget.spContent} ');
      print('cek optional shipment ${widget.spOptional}');
      print('cek id product ${idProduct}');
      print('cek productOp ${useNFC ? 'QR' : 'IMG'}');
      print('cek content product ${contentProduct}');
      Shipment newData = Shipment.createData(
          spId: widget.spId,
          spOptional: widget.spOptional,
          spContent: widget.spContent,
          spProductionContent: syncPath,
          spProductionID: idProduct,
          spProductionOptional: useQR ? 'QR' : 'IMG');
      productList.add(newData);
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
