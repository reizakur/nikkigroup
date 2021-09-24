import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/admin/halaman_br_keluar.dart';
import 'package:nikki_flutter/screen/admin/halaman_riwayat_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_supply.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_barang_rusak.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'package:nikki_flutter/screen/models/models_produk.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HalamanUtamaAdmin extends StatefulWidget {
  HalamanUtamaAdmin({Key? key}) : super(key: key);

  @override
  _HalamanUtamaAdminState createState() => _HalamanUtamaAdminState();
}

class _HalamanUtamaAdminState extends State<HalamanUtamaAdmin> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  var dapetqty = 0;
  var harga = 0;
  var qty = 0;
  var total = 0;
  final controller_nama_produk = TextEditingController();
  final controller_gambar = TextEditingController();
  final controller_harga = TextEditingController();
  final controller_qty = TextEditingController();
  final controller_total = TextEditingController();
  final controller_tanggal = TextEditingController();
  final controller_stok = TextEditingController();
  late Size ukuranlayar;
  var dio = Dio();
  void fetchProduk() async {
    ProdukModel.produklist.clear();
    final responseku = await http.post(
        'https://nikkigroup.joeloecs.com/mobileapi/fetch_tambah_produk.php',
        body: {
          "res_id": 'nothing',
        });
    var data = jsonDecode(responseku.body);
    if (data[0]['result'] == '1') {
      print(data[1].toString());
      int count = data[1].length;
      for (int i = 0; i < count; i++) {
        ProdukModel.produklist.add(ProdukModel.fromjson(data[1][i]));
      }
      print('check length ${ProdukModel.produklist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  void deleteProduk(id_br_masuk) async {
    ProdukModel.produklist.clear();
    final responseku = await http.post(
        'https://nikkigroup.joeloecs.com/mobileapi/delete_produk.php',
        body: {
          "id_br_masuk": id_br_masuk,
        });
    var data = jsonDecode(responseku.body);
    if (['value'] == 1) {
      setState(() {
        fetchProduk();
      });

      print('check length ${ProdukModel.produklist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    ukuranlayar = MediaQuery.of(context).size;
    print('total $total');
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
                    AutoSizeText('Qty', style: TextStyle(color: Colors.grey))
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
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.65),
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

                    rows: ProdukModel.produklist
                        .map((data) => DataRow(cells: [
                              DataCell(Container(
                                //    height: ukuranlayar.height,
                                width: ukuranlayar.width * 0.40,
                                //  color: Colors.blue,
                                child: AutoSizeText(
                                    '${data.nama_barang} ${data.id_br_masuk} || ${data.qty} || ${data.harga} ||'),
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
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalamanTambahStok(
                                                        ProdukModel.init())));
                                      },
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
                                      onPressed: () {
                                        deleteProduk(data.id_br_masuk);
                                        fetchProduk();
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
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.65),
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
                          'Tambah Produk',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              launch(
                                  'https://nikkigroup.joeloecs.com/admin/cetak_br_masuk.php');
                            },
                            icon: Icon(Icons.print)),
                      ),
                    ),
                  ],
                )),
            Container(
              //  alignment: Alignment.center,
              height: ukuranlayar.height * 0.70,
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
                        leading: Icon(Icons.shopping_cart_sharp),
                        title: TextFormField(
                          controller: controller_nama_produk,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Produk',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      // color: Colors.grey,
                      child: ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: CupertinoButton(
                              child: _image == null
                                  ? Text('Upload')
                                  : Text('$_image'),
                              onPressed: () {
                                getImage();
                              }))),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.qr_code),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'QR Code',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      //      color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.price_change_outlined),
                        title: TextFormField(
                          controller: controller_harga,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            harga = int.parse(value);
                            total = harga * qty;
                            setState(() {});
                          },
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Harga',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      //   color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.format_list_numbered_rtl),
                        title: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller_qty,
                          onChanged: (value) {
                            qty = int.parse(value);
                            total = harga * qty;
                            setState(() {});
                          },
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Qty',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      //    color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.check),
                        title: TextFormField(
                          controller: controller_total,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: '$total',
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
                                'nama_barang': controller_nama_produk.text,
                                'harga': controller_harga.text,
                                'qty': controller_qty.text,
                                'total': '$total',
                                'tanggal': '$now',
                                'gambar': await MultipartFile.fromFile(
                                    _image?.path,
                                    filename: 'gambar${now.toString()}.png'),
                              });
                              var response = await dio.post(
                                  'https://joeloecs.com/bersama/nikki/mobileapi/tambah_barang.php',
                                  data: formData);
                              print(
                                  'berhasil, ${controller_gambar.text},${controller_harga.text},${controller_total.text},${controller_nama_produk.text},${controller_qty.text}');
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
