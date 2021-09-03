import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nikki_flutter/screen/agen/halaman_pemesanan.dart';

import 'package:google_fonts/google_fonts.dart';

class HalamanUtamaAgen extends StatefulWidget {
  HalamanUtamaAgen({Key? key}) : super(key: key);

  @override
  _HalamanUtamaAgenState createState() => _HalamanUtamaAgenState();
}

class _HalamanUtamaAgenState extends State<HalamanUtamaAgen> {
  late Size ukuranlayar;
  @override
  Widget build(BuildContext context) {
    ukuranlayar = MediaQuery.of(context).size;
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
                      Text('Riwayat', style: TextStyle(color: Colors.grey))
                    ],
                  ),
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                              height: ukuranlayar.height * 0.05,
                              width: ukuranlayar.width,
                              child: ListTile(
                                  title: AutoSizeText(
                                    'Sepatu',
                                    style: TextStyle(fontSize: 0.08),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalamanPemesanan()));
                                      },
                                      icon: Icon(Icons.card_travel))),
                            )
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                              height: ukuranlayar.height * 0.05,
                              width: ukuranlayar.width,
                              child: ListTile(
                                  title: AutoSizeText(
                                    'Sepatu',
                                    style: GoogleFonts.poppins(fontSize: 0.08),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalamanPemesanan()));
                                      },
                                      icon: Icon(Icons.card_travel))),
                            )
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                              height: ukuranlayar.height * 0.05,
                              width: ukuranlayar.width,
                              child: ListTile(
                                  title: AutoSizeText(
                                    'Sepatu',
                                    style: TextStyle(fontSize: 0.08),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalamanPemesanan()));
                                      },
                                      icon: Icon(Icons.card_travel))),
                            )
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                              height: ukuranlayar.height * 0.05,
                              width: ukuranlayar.width,
                              child: ListTile(
                                  title: AutoSizeText(
                                    'Sepatu',
                                    style: TextStyle(fontSize: 0.08),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalamanPemesanan()));
                                      },
                                      icon: Icon(Icons.card_travel))),
                            )
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                            ),
                            Container(
                              height: ukuranlayar.height * 0.05,
                              width: ukuranlayar.width,
                              child: ListTile(
                                  title: AutoSizeText(
                                    'Sepatu',
                                    style: TextStyle(fontSize: 0.08),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalamanPemesanan()));
                                      },
                                      icon: Icon(Icons.card_travel))),
                            )
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
                                  color: Colors.black,
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
                                        'Sepatu ',
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
