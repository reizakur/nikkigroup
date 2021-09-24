import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nikki_flutter/screen/agen/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'package:nikki_flutter/screen/models/models_produk.dart';

class HalamanRiwayatAgen extends StatefulWidget {
  HalamanRiwayatAgen({Key? key}) : super(key: key);

  @override
  _HalamanRiwayatAgenState createState() => _HalamanRiwayatAgenState();
}

class _HalamanRiwayatAgenState extends State<HalamanRiwayatAgen> {
  late Size ukuranlayar;
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
              height: ukuranlayar.height,
              //    width: ukuranlayar.width * 0.80,
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.08),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: ukuranlayar.width * 0.05,
                        right: ukuranlayar.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(05),
                      color: Colors.red,
                    ),
                    height: ukuranlayar.height * 0.07,
                    width: ukuranlayar.width * 0.10,
                    child: ListTile(
                      leading: Text(
                        'odan',
                        style: TextStyle(fontSize: 30),
                      ),
                      title: Text(
                        'data',
                        style: TextStyle(fontSize: 30),
                      ),
                      trailing: Text(
                        'data',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ukuranlayar.height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ukuranlayar.width * 0.05,
                        right: ukuranlayar.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(05),
                      color: Colors.red,
                    ),
                    height: ukuranlayar.height * 0.07,
                    width: ukuranlayar.width * 0.10,
                    child: ListTile(
                      leading: Text(
                        'odan',
                        style: TextStyle(fontSize: 30),
                      ),
                      title: Text(
                        'data',
                        style: TextStyle(fontSize: 30),
                      ),
                      trailing: Text(
                        'data',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
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
