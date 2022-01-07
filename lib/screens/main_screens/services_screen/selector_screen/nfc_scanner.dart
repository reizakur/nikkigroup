part of '../../../screens.dart';

class NFCScanner extends StatefulWidget {
  @override
  _NFCScannerState createState() => _NFCScannerState();
}

class _NFCScannerState extends State<NFCScanner> {
  String nfcID;
  bool showHint = false;

  void systemScan() {
    print('NFC is scanning and waiting for the data..');
    try {
      FlutterNfcReader.read().then((hasilscan) {
        print('========[NFC Scan Result]=========');
        print('NFC Tag ID : ${hasilscan.id}');
        print('Content : ${hasilscan.content}');
        print('==================================');
        nfcID = hasilscan.id;
        Navigator.pop(this.context, nfcID);
      });
    } on Exception {
      DeviceValue.isNFCsupport = false;
    }
    new Future.delayed(new Duration(seconds: 7), () async {
      setState(() {
        showHint = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    systemScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  //  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage(
                    'assets/nfc.gif',
                  )),
                ),
              ),
            ),
            Text(
              'Place your device\nagainst RFID',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: blackFontStyle,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedCrossFade(
                firstChild: Text(
                  "Can't detect RFID ? please make sure your NFC is turned on",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: greyFontStyle,
                ),
                secondChild: SizedBox(),
                crossFadeState: showHint
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 250)),
          ],
        ),
      ),
    );
  }
}
