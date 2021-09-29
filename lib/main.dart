import 'package:flutter/material.dart';
import 'package:nikki_flutter/screen/admin/halaman_br_keluar.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_supply.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/agen/halaman_riwayat.dart';
import 'service/API_service/API_service.dart';
import 'package:nikki_flutter/screen/agen/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_daftar.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';
import 'service/SP_service/SP_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.ad
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    try {
      UserData myUserData = UserData();
      APIUserService userService = APIUserService();
      await myUserData.getPref(); //get User data
      print('ID is ${myUserData.getUsernameID()}');
      myUserData.printdevinfo();
      if (myUserData.getStatusLog()) {
        if (!myUserData.getAdminStatus()) {
          //admin
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HalamanUtamaAdmin()),
              (Route<dynamic> route) => false);
        } else {
          //user
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HalamanUtamaAdmin()),
              (Route<dynamic> route) => false);
        }
      } else {
        //Guest
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HalamanLogin()),
            (Route<dynamic> route) => false);
      }
    } on Exception {
      // setState(() {
      //   displayError = true;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
