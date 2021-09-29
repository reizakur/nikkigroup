import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/models/models_stok.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nikki_flutter/screen/admin/halaman_br_keluar.dart';
import 'package:nikki_flutter/screen/admin/halaman_riwayat_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_supply.dart';

import 'package:nikki_flutter/screen/admin/halaman_tambah_barang_rusak.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanRiwayatStok extends StatefulWidget {
  

  @override
  _HalamanRiwayatStokState createState() => _HalamanRiwayatStokState();
}

class _HalamanRiwayatStokState extends State<HalamanRiwayatStok> {
   late Size ukuranlayar;

  void fetchStok() async {
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

  void deleteStok(id_stok_br) async {
    StokModel.stoklist.clear();
    final responseku = await http.post(
        'https://nikkigroup.joeloecs.com/mobileapi/delete_stok.php',
        body: {
          "id_stok_br": id_stok_br,
        });
    var data = jsonDecode(responseku.body);
    if (['value'] == 1) {
      setState(() {
        print('nyetak $id_stok_br');
        fetchStok();
      });

      print('check length ${StokModel.stoklist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {
      print('apa kamu kesini ?');
      fetchStok();
    });
  }

  @override
  void initState() {
    super.initState();

    fetchStok();
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
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.10),
              //  color: Colors.red,
              //  height: ukuranlayar.height * 0.90,
              width: ukuranlayar.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          '',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          '',
                        ),
                      ),
                    ],

                    rows: StokModel.stoklist
                        .map((data) => DataRow(cells: [
                              DataCell(
                                Container(
                                  //    height: ukuranlayar.height,
                                  width: ukuranlayar.width * 0.40,
                                  //  color: Colors.blue,
                                  child: AutoSizeText(
                                      '${data.nama_barang} || ${data.stok} || ${data.tanggal} ||'),
                                ),
                              ),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: ukuranlayar.width * 0.18,
                                    height: ukuranlayar.height * 0.03,
                                    child: FlatButton(
                                      child: AutoSizeText(
                                        'Hapus',
                                        //   style: TextStyle(fontSize: 10.0),
                                      ),
                                      color: Colors.red,
                                      textColor: Colors.black,
                                      onPressed: () {
                                        deleteStok(data.id_stok_br);
                                      },
                                    ),
                                  ),
                                ],
                              )),
                            ]))
                        .toList(),
                    // const <DataRow>[
                    //   DataRow(
                    //     cells: <DataCell>[
                    //       DataCell(Text('Mohit')),
                    //       DataCell(Text('23')),
                    //     ],
                    //   ),
                    // ],
                  )
                ],
              ),
            ),
            Container(
              height: ukuranlayar.height * 0.10,
              color: Colors.white,
              width: ukuranlayar.width,
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.10),
              child: Container(
                margin: EdgeInsets.only(top: ukuranlayar.height * 0.05),
                height: ukuranlayar.height * 0.05,
                color: Colors.blue,
                child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: ukuranlayar.width * 0.25,
                      margin: EdgeInsets.only(left: ukuranlayar.width * 0.04),
                      //  color: Colors.black,
                      child: Text(
                        'Nama Barang',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: ukuranlayar.width * 0.25,
                      // color: Colors.white,
                      margin: EdgeInsets.only(left: ukuranlayar.width * 0.11),
                      child: Text(
                        'Stok',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: ukuranlayar.width * 0.25,
                      //  color: Colors.black,

                      margin: EdgeInsets.only(left: ukuranlayar.width * 0.08),
                      child:
                          Text('Harga', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
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
                          'Riwayat Stok',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              launch(
                                  'https://nikkigroup.joeloecs.com/admin/cetak_tambah_stok.php');
                            },
                            icon: Icon(Icons.print)),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
