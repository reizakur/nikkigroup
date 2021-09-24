import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/models/models_supply.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:nikki_flutter/screen/admin/halaman_br_keluar.dart';
import 'package:nikki_flutter/screen/admin/halaman_riwayat_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_supply.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_barang_rusak.dart';

class HalamanTambahSupply extends StatefulWidget {
  HalamanTambahSupply({Key? key}) : super(key: key);

  @override
  _HalamanTambahSupplyState createState() => _HalamanTambahSupplyState();
}

class _HalamanTambahSupplyState extends State<HalamanTambahSupply> {
  late Size ukuranlayar;
  var dio = Dio();
  final controller_nama_perusahaan = TextEditingController();
  final controller_alamat = TextEditingController();
  final controller_nohp = TextEditingController();
  void fetchSupply() async {
    SupplyModel.supplylist.clear();
    final responseku = await http.post(
        'https://nikkigroup.joeloecs.com/mobileapi/fetch_supply.php',
        body: {
          "res_id": 'nothing',
        });
    var data = jsonDecode(responseku.body);
    if (data[0]['result'] == '1') {
      print(data[1].toString());
      int count = data[1].length;
      for (int i = 0; i < count; i++) {
        SupplyModel.supplylist.add(SupplyModel.fromjson(data[1][i]));
      }
      print('check length ${SupplyModel.supplylist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  void deletesupply(id_supply) async {
    SupplyModel.supplylist.clear();
    final responseku = await http.post(
        'https://nikkigroup.joeloecs.com/mobileapi/delete_supply.php',
        body: {
          "id_supply": id_supply,
        });
    var data = jsonDecode(responseku.body);
    if (['value'] == 1) {
      setState(() {
        fetchSupply();
      });

      print('check length ${SupplyModel.supplylist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {
      fetchSupply();
    });
  }

  @override
  void initState() {
    super.initState();

    fetchSupply();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    ukuranlayar = MediaQuery.of(context).size;
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
              height: ukuranlayar.height * 0.35,
              // color: Colors.blue,
              width: ukuranlayar.width * 1.00,
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.55),
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

                    rows: SupplyModel.supplylist
                        .map((data) => DataRow(cells: [
                              DataCell(Container(
                                //    height: ukuranlayar.height,
                                width: ukuranlayar.width * 0.40,
                                //  color: Colors.blue,
                                child: AutoSizeText(
                                    '${data.nama_perusahaan} || ${data.no_hp} || ${data.alamat} ||'),
                              )),
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
                                        deletesupply(data.id_supply);
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
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.55),
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
                          'Tambah Supply',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              launch(
                                  'https://nikkigroup.joeloecs.com/admin/cetak_supply.php');
                            },
                            icon: Icon(Icons.print)),
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
                        leading: Icon(Icons.account_balance_rounded),
                        title: TextFormField(
                          controller: controller_nama_perusahaan,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Nama Perusahaan',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      // color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: TextFormField(
                          controller: controller_alamat,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Alamat',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      //      color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: TextFormField(
                          controller: controller_nohp,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'No HP',
                          ),
                        ),
                      )),
                  Container(
                    height: ukuranlayar.height * 0.10,
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
                            onPressed: () async {
                              DateTime now = new DateTime.now();
                              var formData = FormData.fromMap({
                                'nama_perusahaan':
                                    controller_nama_perusahaan.text,
                                'alamat': controller_alamat.text,
                                'no_hp': controller_nohp.text,
                                'tanggal': '$now',
                              });
                              var response = await dio.post(
                                  'https://joeloecs.com/bersama/nikki/mobileapi/tambah_supply.php',
                                  data: formData);
                              print(
                                  'berhasil, ${controller_nama_perusahaan.text}, ${controller_alamat.text}, ${controller_nohp.text}');
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
