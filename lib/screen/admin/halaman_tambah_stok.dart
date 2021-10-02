import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/models/models_stok.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/models/models_produk.dart';
import 'package:flutter/cupertino.dart';
import 'package:nikki_flutter/screen/admin/halaman_br_keluar.dart';
import 'package:nikki_flutter/screen/admin/halaman_riwayat_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_supply.dart';

import 'package:nikki_flutter/screen/admin/halaman_tambah_barang_rusak.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanTambahStok extends StatefulWidget {
  final ProdukModel model;
  HalamanTambahStok(this.model);

  @override
  _HalamanTambahStokState createState() => _HalamanTambahStokState();
}

class _HalamanTambahStokState extends State<HalamanTambahStok> {
   late Size ukuranlayar;

  void fetchProdukKeluar() async {
    StokModel.stoklist.clear();
    final responseku = await http.post(
        'https://nikkigroup.joeloecs.com/mobileapi/fetch_stok.php',
        body: {
          "res_id": 'nothing',
        });
    var data = jsonDecode(responseku.body);
    if (data[0]['result'] == '1') {
      print(data[1].toString());
      int count = data[1].length;
      for (int i = 0; i < count; i++) {
        StokModel.stoklist.add(StokModel.fromjson(data[1][i]));
      }
      print('check length ${StokModel.stoklist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProdukKeluar();
    print(widget.model.id_br_masuk);
  }

  Widget build(BuildContext context) {
    ukuranlayar = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
                                builder: (context) => HalamanUtamaAdmin()));
                      },
                      icon: Icon(Icons.home),
                    ),
                    AutoSizeText('Awal', style: TextStyle(color: Colors.grey))
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
                                builder: (context) => HalamanBarangKeluar()));
                      },
                      icon: Icon(Icons.book),
                    ),
                    AutoSizeText('Pesanan',
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
                                builder: (context) => HalamanRiwayatStok()));
                      },
                      icon: Icon(Icons.add_chart_sharp),
                    ),
                    AutoSizeText('Stok', style: TextStyle(color: Colors.grey))
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
                                builder: (context) => HalamanTambahSupply()));
                      },
                      icon: Icon(Icons.home_work_rounded),
                    ),
                    AutoSizeText('Supply', style: TextStyle(color: Colors.grey))
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
                                builder: (context) => HalamanReject()));
                      },
                      icon: Icon(Icons.production_quantity_limits),
                    ),
                    AutoSizeText('Reject', style: TextStyle(color: Colors.grey))
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
                                builder: (context) => HalamanLogin()));
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
                width: ukuranlayar.width,
                height: ukuranlayar.height * 0.105,
                color: Colors.blue[400],
                child: Column(
                  children: [
                    Container(
                      width: ukuranlayar.width,
                      height: ukuranlayar.height * 0.07,
                      margin: EdgeInsets.only(top: ukuranlayar.height * 0.035),
                      //   color: Colors.blue[400],
                      child: ListTile(
                        title: Text(
                          'Tambah Stok',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        leading: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back)),
                      ),
                    ),
                  ],
                )),
            Container(
              //  alignment: Alignment.center,
              height: ukuranlayar.height * 0.50,
              //  width: ukuranlayar.width * 0.95,
              decoration: BoxDecoration(
                  //    color: Colors.yellow,
                  ),
              margin: EdgeInsets.only(
                top: ukuranlayar.height * 0.105,
                //      left: ukuranlayar.width * 0.02),
              ),
              child: Column(
                children: [
                  Container(
                      height: ukuranlayar.height * 0.08,
                      decoration: BoxDecoration(
                          //color: Colors.blue,
                          ),
                      child: ListTile(
                        leading: Icon(Icons.production_quantity_limits),
                        title: TextFormField(
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Stok Tersedia',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      // color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.plus_one),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Tambah Stok',
                          ),
                        ),
                      )),
                  Container(
                    height: ukuranlayar.height * 0.10,
                    //   margin: EdgeInsets.only(bottom: ukuranlayar.height * 0.50),
                    //  width: ukuranlayar.width * 0.95,
                    decoration: BoxDecoration(
                      //   color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          // height: ukuranlayar.height * 0.05,
                          //  width: ukuranlayar.width * 0.95,
                          decoration: BoxDecoration(
                            //       color: Colors.blue[400],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50)),
                          ),
                        ),
                        Container(
                          //   color: Colors.green,
                          height: ukuranlayar.height * 0.06,
                          //   width: ukuranlayar.width * 0.65,
                          margin: EdgeInsets.only(
                              top: ukuranlayar.height * 0.020,
                              left: ukuranlayar.width * 0.28),
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(20),
                            child: Text(
                              'Kirim',
                              style: TextStyle(fontSize: 19),
                            ),
                            color: CupertinoColors.activeGreen,
                            onPressed: () {
                              print('kirim');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
