import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/models/models_stok.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

class HalamanTambahStok extends StatefulWidget {
  HalamanTambahStok({Key? key}) : super(key: key);

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
            height: ukuranlayar.height * 0.07,
            width: ukuranlayar.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      'Awal',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                InkWell(
                  onTap: () => () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        color: Colors.blueGrey,
                      ),
                      Text('Pesanan', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.document_scanner,
                      color: Colors.blueGrey,
                    ),
                    Text('Stok', style: TextStyle(color: Colors.grey))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.blueGrey,
                    ),
                    Text('Keluar', style: TextStyle(color: Colors.grey))
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
                              DataCell(Container(
                                //    height: ukuranlayar.height,
                                width: ukuranlayar.width * 0.40,
                                //  color: Colors.blue,
                                child: AutoSizeText(
                                    '${data.nama_barang} || ${data.qty} || ${data.total} ||'),
                              )),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: ukuranlayar.width * 0.18,
                                    height: ukuranlayar.height * 0.03,
                                    child: FlatButton(
                                      child: AutoSizeText(
                                        '+ Stok',
                                        //     style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      textColor: Colors.black,
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text('||'),
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
                                      onPressed: () {},
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
                          'Data Tambah Stok',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                            color: Colors.white,
                            onPressed: () {},
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
