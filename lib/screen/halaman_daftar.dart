import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/agen/halaman_utama.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';

import 'package:nikki_flutter/screen/halaman_login.dart';

class HalamanDaftar extends StatefulWidget {
  HalamanDaftar({Key? key}) : super(key: key);

  @override
  _HalamanDaftarState createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  final controller_nama = TextEditingController();
  final controller_no_hp = TextEditingController();
  final controller_alamat = TextEditingController();
  final controller_username = TextEditingController();
  final controller_password = TextEditingController();
  final controller_akses = TextEditingController();
  final controller_gambar = TextEditingController();
  final controller_gmail = TextEditingController();
  var dio = Dio();
  late Size ukuranlayar;
  var akses = 'usr';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    ukuranlayar = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: ukuranlayar.height * 0.05,
              width: ukuranlayar.width,
              color: Colors.blue,
            ),
            Container(
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.05),
              height: ukuranlayar.height * 0.05,
              width: ukuranlayar.width,
              color: Colors.blue,
              child: Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.10),
              height: ukuranlayar.height,
              width: ukuranlayar.width,
              // color: Colors.black,
              child: ListView(
                children: [
                  SizedBox(
                    height: ukuranlayar.height * 0.15,
                  ),
                  Container(
                    width: ukuranlayar.width,
                    height: ukuranlayar.height * 0.15,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    )),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.05,
                    //  color: Colors.blue,
                    child: TextFormField(
                      controller: controller_nama,
                      decoration: InputDecoration(
                          hintText: 'Nama Lengkap',
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 0.20)),
                    ),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.05,
                    //  color: Colors.blue,
                    child: TextFormField(
                      controller: controller_no_hp,
                      decoration: InputDecoration(
                          hintText: 'No HP',
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 0.20)),
                    ),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.05,
                    //  color: Colors.blue,
                    child: TextFormField(
                      controller: controller_alamat,
                      decoration: InputDecoration(
                          hintText: 'Alamat',
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 0.20)),
                    ),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.05,
                    // color: Colors.yellow,
                    child: TextFormField(
                      controller: controller_gmail,
                      decoration: InputDecoration(
                        hintText: 'Gmail',
                      ),
                    ),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.05,
                    // color: Colors.yellow,
                    child: TextFormField(
                      controller: controller_username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.05,
                    // color: Colors.yellow,
                    child: TextFormField(
                      controller: controller_password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    width: ukuranlayar.width * 0.85,
                    height: ukuranlayar.height * 0.06,
                  ),
                  Container(
                    width: ukuranlayar.width * 0.45,
                    height: ukuranlayar.height * 0.06,
                    child: CupertinoButton(
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      color: CupertinoColors.activeOrange,
                      onPressed: () async {
                        registration();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showWarning() {
    //do something if username or password isn't filled correctly
  }

  void registration() async {
    if (controller_username.text == null ||
        controller_username.text == '' ||
        controller_password.text == null ||
        controller_password.text == '') {
      showWarning();
    }
    DateTime now = new DateTime.now();
    var formData = FormData.fromMap({
      'nama': controller_nama.text,
      'no_hp': controller_no_hp.text,
      'alamat': controller_alamat.text,
      'gmail': controller_gmail.text,
      'username': controller_username.text,
      'password': controller_password.text,
      'tanggal': '$now',
      'akses': '$akses',
      'gambar': '',
    });
    var response = await dio.post(
        'https://joeloecs.com/bersama/nikki/mobileapi/tambah_user.php',
        data: formData);
    print(
        'berhasil, ${controller_gambar.text},${controller_nama.text},${controller_no_hp.text},${controller_alamat.text},$akses');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HalamanLogin()));
  }
}
