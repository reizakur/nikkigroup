import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/DatabaseLoca/database_scan.dart';
import 'package:nikki_flutter/screen/barcode/halaman_history.dart';
import 'package:nikki_flutter/screen/barcode/produk_barcode.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:url_launcher/url_launcher.dart';

class ProdukBarcodeState extends StatefulWidget {
  ProdukBarcodeState({@required this.shipmentQR});
  String shipmentQR;
  @override
  _ProdukBarcodeStateState createState() => _ProdukBarcodeStateState();
}

class _ProdukBarcodeStateState extends State<ProdukBarcodeState> {
  Shipmentdbcontroller dbcontroller = Shipmentdbcontroller();
  Size ukuranlayar;
  String barcode;
  String code = '';
  String getcode = '';
  List<String> dataditampung = [];

  @override
  void initState() {
    super.initState();
  }

  void showdialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Produk'),
            content: Text('$code'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdukBarcodeState()));
                },
                child: Text('Undo'),
              ),
              CupertinoDialogAction(
                  onPressed: () async {
                    Navigator.pop(context);
                    dataditampung.add('$code');
                  },
                  child: Text('Next')),
              CupertinoDialogAction(
                  onPressed: () {
                    masukinkedatabase();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HalamanHistory()));
                  },
                  child: Text('Finish')),
            ],
          );
        });
  }

  void masukinkedatabase() async {
    for (int i = 0; i < dataditampung.length; i++) {
      Shipment qrinput = Shipment.create(widget.shipmentQR, dataditampung[i]);
      var result = await dbcontroller.insertnewShipment(qrinput);
      if (result == 0) {
        print('it has error ?');
      } else {
        print('Berhasil disimpan');
      }
    }
  }

  Widget build(BuildContext context) {
    ukuranlayar = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
      child: Scaffold(
        body: Stack(),
      ),
    );
  }
}
