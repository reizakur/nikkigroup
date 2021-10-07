import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/DatabaseLoca/database_scan.dart';
import 'package:nikki_flutter/screen/barcode/halaman_history.dart';
import 'package:nikki_flutter/screen/barcode/halaman_utama.dart';
import 'package:nikki_flutter/screen/barcode/produk_barcode.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'package:url_launcher/url_launcher.dart';

class ShipmentBarcode extends StatefulWidget {
  ShipmentBarcode({Key key}) : super(key: key);

  @override
  _ShipmentBarcodeState createState() => _ShipmentBarcodeState();
}

class _ShipmentBarcodeState extends State<ShipmentBarcode> {
  Size ukuranlayar;
  String barcode, rfid;
  String code = '';
  String getcode = '';

  @override
  void initState() {
    super.initState();
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Masukan FJ?'),
            content: Text('Apakah barcode dari Shipment tidak terbaca?'),
            actions: [
              FlatButton(onPressed: () {}, child: Text('Batal')),
              FlatButton(onPressed: () {}, child: Text('Kirimkan'))
            ],
          );
        });
  }

  createAlertDialogFinish(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Apakah Shipment Anda benar?'),
            content: Text(
                'Anda tidak dapat mengubah shipment setelah melanjut kembali. Tetap lanjutkan?'),
            actions: [
              FlatButton(onPressed: () {}, child: Text('Batal')),
              FlatButton(onPressed: () {}, child: Text('Kirimkan'))
            ],
          );
        });
  }

  createAlertDialogUndo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Scan Produk Ulang?'),
            content: Text('Anda yakin untuk mengulang scan produk?'),
            actions: [
              FlatButton(onPressed: () {}, child: Text('Batal')),
              FlatButton(onPressed: () {}, child: Text('Kirimkan'))
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    ukuranlayar = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ));
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: ukuranlayar.height * 0.09,
            width: ukuranlayar.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Halaman_Utama()));
                      },
                      icon: Icon(Icons.qr_code),
                    ),
                    AutoSizeText('Shipment',
                        style: TextStyle(color: Colors.grey))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HalamanHistory()));
                      },
                      icon: Icon(Icons.list_alt),
                    ),
                    AutoSizeText('History',
                        style: TextStyle(color: Colors.grey))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShipmentBarcode()));
                      },
                      icon: Icon(Icons.logout),
                    ),
                    AutoSizeText('Keluar', style: TextStyle(color: Colors.grey))
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                width: ukuranlayar.width,
                height: ukuranlayar.height * 0.05,
                alignment: Alignment.center,
                child: ListTile(
                    title: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Shipment Barcode',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ),
              Container(
                color: Colors.white,
                width: ukuranlayar.width,
                height: ukuranlayar.height * 0.08,
                child: ListTile(
                    leading: Icon(Icons.qr_code),
                    title: TextFormField(
                      enabled: false,
                    ),
                    //title: Text('QR-34829423'),
                    subtitle: Text('Shipment'),
                    trailing: TextButton.icon(
                      onPressed: () {
                        createAlertDialog(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Masukan FJ',
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              ),
              Container(
                  height: ukuranlayar.height * 0.05,
                  color: Colors.white70,
                  child: ListTile(
                    trailing: Text('Pilih Shipment'),
                    title: Text(''),
                    leading: Text(''),
                  )),
              Container(
                height: ukuranlayar.height * 0.60,

                // margin: EdgeInsets.only(bottom: ukuranlayar.height * 0.01),
                //padding: EdgeInsets.only(top: ukuranlayar.height * 0.08),
                // color: Colors.green,
                child: ListView(
                  children: [
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '1',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833xxx'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '2',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833xxx'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '3',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '4',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '5',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '6',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '7',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                        trailing: Icon(Icons.check_box_outline_blank_outlined),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '8',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                      ),
                    ),
                    SizedBox(height: ukuranlayar.height * 0.004),
                    Container(
                      color: Colors.white,
                      height: ukuranlayar.height * 0.08,
                      child: ListTile(
                        leading: Text(
                          '9',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('QR-099332833'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: ukuranlayar.height * 0.075,
                width: ukuranlayar.width,
                color: Colors.white70,
                child: Row(
                  children: [
                    SizedBox(
                      width: ukuranlayar.width * 0.03,
                    ),
                    SizedBox(
                      width: ukuranlayar.width * 0.47,
                      height: ukuranlayar.height * 0.07,
                      child: CupertinoButton(
                          color: Colors.red,
                          child: Text(
                            'UNDO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            createAlertDialogUndo(context);
                          }),
                    ),
                    SizedBox(
                      width: ukuranlayar.width * 0.01,
                    ),
                    SizedBox(
                      width: ukuranlayar.width * 0.47,
                      height: ukuranlayar.height * 0.07,
                      child: CupertinoButton(
                          color: Colors.green,
                          child: Text(
                            'FINISH',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            createAlertDialogFinish(context);
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
