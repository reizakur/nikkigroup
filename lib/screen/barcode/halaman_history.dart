import 'dart:ui';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nikki_flutter/DatabaseLoca/database_scan.dart';

import 'package:url_launcher/url_launcher.dart';

import 'shipment_barcode.dart';

class HalamanHistory extends StatefulWidget {
  HalamanHistory({Key key}) : super(key: key);

  @override
  _HalamanHistoryState createState() => _HalamanHistoryState();
}

class _HalamanHistoryState extends State<HalamanHistory> {
  Size ukuranlayar;
  List<Shipment> history;
  Shipmentdbcontroller dbController = Shipmentdbcontroller();

  @override
  void initState() {
    super.initState();
  }

  void fetchHistory() {
    Future<Database> dbfuture;
    dbfuture = dbController.initdb();
    dbfuture.then((data) {
      Future<List<Shipment>> listbahan = dbController.getShipmentlist();
      listbahan.then((bahan) {
        history = bahan;
        setState(() {});
      });
    });
  }

  Widget build(BuildContext context) {
    ukuranlayar = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    if (history == null) {
      history = [];
      fetchHistory();
    }
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
                                builder: (context) => ShipmentBarcode()));
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
                      icon: Icon(Icons.history),
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
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.10),
              //  color: Colors.red,
              height: ukuranlayar.height,
              width: ukuranlayar.width,

              child: ListView(
                  children: history.map((e) {
                return Container(
                  margin: EdgeInsets.only(
                      left: ukuranlayar.width * 0.05,
                      right: ukuranlayar.width * 0.05,
                      top: ukuranlayar.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(05),
                    color: Colors.red,
                  ),
                  height: ukuranlayar.height * 0.07,
                  width: ukuranlayar.width * 0.10,
                  child: ListTile(
                    leading: Text(
                      e.qr_shipment,
                      style: TextStyle(fontSize: 30),
                    ),
                    trailing: (IconButton(
                        onPressed: () async {
                          await dbController.deleteShipment(e.id);
                          fetchHistory();
                        },
                        icon: Icon(Icons.restore_from_trash_rounded))),
                  ),
                );
              }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
