import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nikki_flutter/screen/agen/halaman_pemesanan.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nikki_flutter/screen/agen/halaman_riwayat.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'package:nikki_flutter/screen/models/models_produk.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanUtamaAgen extends StatefulWidget {
  HalamanUtamaAgen({Key? key}) : super(key: key);

  @override
  _HalamanUtamaAgenState createState() => _HalamanUtamaAgenState();
}

class _HalamanUtamaAgenState extends State<HalamanUtamaAgen> {
  late Size ukuranlayar;

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

  @override
  Widget build(BuildContext context) {
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
                                builder: (context) => HalamanUtamaAgen()));
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
                                builder: (context) => HalamanRiwayatAgen()));
                      },
                      icon: Icon(Icons.add_shopping_cart_outlined),
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
              //  color: Colors.red,
              height: ukuranlayar.height,
              width: ukuranlayar.width,
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.08),
              child: ListView(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      Container(
                        //   color: Colors.blue,
                        height: ukuranlayar.height * 0.20,
                        width: ukuranlayar.width * 0.30,
                        child: Column(
                          children: [
                            Container(
                              height: ukuranlayar.height * 0.15,
                              width: ukuranlayar.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/vans.jpg'),
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                                height: ukuranlayar.height * 0.04,
                                width: ukuranlayar.width,
                                margin: EdgeInsets.only(
                                    top: ukuranlayar.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: ukuranlayar.height,
                                      width: ukuranlayar.width * 0.15,
                                      ////  color: Colors.white,
                                      child: AutoSizeText(
                                        'Nike Autentik',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        height: ukuranlayar.height,
                                        width: ukuranlayar.width * 0.15,
                                        //  color: Colors.yellow,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HalamanPemesanan()));
                                            },
                                            icon: Icon(Icons.card_travel)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        //   color: Colors.blue,
                        height: ukuranlayar.height * 0.20,
                        width: ukuranlayar.width * 0.30,
                        child: Column(
                          children: [
                            Container(
                              height: ukuranlayar.height * 0.15,
                              width: ukuranlayar.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/vans1.jpg'),
                                  ),
                                  //     color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                                height: ukuranlayar.height * 0.04,
                                width: ukuranlayar.width,
                                margin: EdgeInsets.only(
                                    top: ukuranlayar.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: ukuranlayar.height,
                                      width: ukuranlayar.width * 0.15,
                                      ////  color: Colors.white,
                                      child: AutoSizeText(
                                        'Nike AND The hill',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        height: ukuranlayar.height,
                                        width: ukuranlayar.width * 0.15,
                                        //  color: Colors.yellow,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HalamanPemesanan()));
                                            },
                                            icon: Icon(Icons.card_travel)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        //   color: Colors.blue,
                        height: ukuranlayar.height * 0.20,
                        width: ukuranlayar.width * 0.30,
                        child: Column(
                          children: [
                            Container(
                              height: ukuranlayar.height * 0.15,
                              width: ukuranlayar.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/nike1.png'),
                                  ),
                                  //   color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                                height: ukuranlayar.height * 0.04,
                                width: ukuranlayar.width,
                                margin: EdgeInsets.only(
                                    top: ukuranlayar.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: ukuranlayar.height,
                                      width: ukuranlayar.width * 0.15,
                                      ////  color: Colors.white,
                                      child: AutoSizeText(
                                        'Nike Ardila',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        height: ukuranlayar.height,
                                        width: ukuranlayar.width * 0.15,
                                        //  color: Colors.yellow,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HalamanPemesanan()));
                                            },
                                            icon: Icon(Icons.card_travel)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        //   color: Colors.blue,
                        height: ukuranlayar.height * 0.20,
                        width: ukuranlayar.width * 0.30,
                        child: Column(
                          children: [
                            Container(
                              height: ukuranlayar.height * 0.15,
                              width: ukuranlayar.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/nike1.png'),
                                  ),
                                  //   color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                                height: ukuranlayar.height * 0.04,
                                width: ukuranlayar.width,
                                margin: EdgeInsets.only(
                                    top: ukuranlayar.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: ukuranlayar.height,
                                      width: ukuranlayar.width * 0.15,
                                      ////  color: Colors.white,
                                      child: AutoSizeText(
                                        'Nike X Samson',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        height: ukuranlayar.height,
                                        width: ukuranlayar.width * 0.15,
                                        //  color: Colors.yellow,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HalamanPemesanan()));
                                            },
                                            icon: Icon(Icons.card_travel)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        //   color: Colors.blue,
                        height: ukuranlayar.height * 0.20,
                        width: ukuranlayar.width * 0.30,
                        child: Column(
                          children: [
                            Container(
                              height: ukuranlayar.height * 0.15,
                              width: ukuranlayar.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/vans1.jpg'),
                                  ),
                                  //  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                                height: ukuranlayar.height * 0.04,
                                width: ukuranlayar.width,
                                margin: EdgeInsets.only(
                                    top: ukuranlayar.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: ukuranlayar.height,
                                      width: ukuranlayar.width * 0.15,
                                      ////  color: Colors.white,
                                      child: AutoSizeText(
                                        'Vans Old ',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        height: ukuranlayar.height,
                                        width: ukuranlayar.width * 0.15,
                                        //  color: Colors.yellow,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HalamanPemesanan()));
                                            },
                                            icon: Icon(Icons.card_travel)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        //  color: Colors.blue,
                        height: ukuranlayar.height * 0.20,
                        width: ukuranlayar.width * 0.30,
                        child: Column(
                          children: [
                            Container(
                              height: ukuranlayar.height * 0.15,
                              width: ukuranlayar.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/nike1.png'),
                                  ),
                                  //  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                                height: ukuranlayar.height * 0.04,
                                width: ukuranlayar.width,
                                margin: EdgeInsets.only(
                                    top: ukuranlayar.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: ukuranlayar.height,
                                      width: ukuranlayar.width * 0.15,
                                      ////  color: Colors.white,
                                      child: AutoSizeText(
                                        'Nike Air Jordan',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        height: ukuranlayar.height,
                                        width: ukuranlayar.width * 0.15,
                                        //  color: Colors.yellow,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HalamanPemesanan()));
                                            },
                                            icon: Icon(Icons.card_travel)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
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
                          'PT.Nikki Internasional',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
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
