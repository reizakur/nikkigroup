import 'package:flutter/material.dart';
import 'package:nikki_flutter/screen/admin/halaman_br_keluar.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_stok.dart';
import 'package:nikki_flutter/screen/admin/halaman_tambah_supply.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/agen/halaman_riwayat.dart';
import 'package:nikki_flutter/screen/agen/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_daftar.dart';
import 'package:nikki_flutter/screen/halaman_login.dart';

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
      home: HalamanUtamaAdmin(),
    );
  }
}
