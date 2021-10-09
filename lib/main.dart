import 'package:flutter/material.dart';
import 'package:nikki_flutter/screen/barcode/halaman_history.dart';
import 'package:nikki_flutter/screen/barcode/halaman_utama.dart';
import 'package:nikki_flutter/screen/barcode/shipment_barcode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.ad
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Halaman_Utama(),
    );
  }
}
