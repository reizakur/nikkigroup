import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:nikki_flutter/screen/admin/halaman_utama.dart';
import 'package:nikki_flutter/screen/halaman_daftar.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';
import 'package:nikki_flutter/screen/models/models_user.dart';
import 'package:nikki_flutter/service/API_service/API_service.dart';
import 'package:nikki_flutter/service/SP_service/SP_service.dart';

class HalamanLogin extends StatefulWidget {
  HalamanLogin({Key? key}) : super(key: key);

  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final controller_username = TextEditingController();
  final controller_password = TextEditingController();
  var dio = Dio();
  late Size ukuranlayar;
  UserData userData = UserData();

  Future<void> fetchUser() async {
    APIUserService apiUserService = APIUserService();
    // ignore: unnecessary_null_comparison
    if (controller_username.text == null ||
        controller_username.text == '' ||
        controller_password.text == null ||
        controller_password.text == '') {
      showWarning();
      return;
    }
    var result = await apiUserService.loginUser(
        user: controller_username.text, pass: controller_password.text);
    switch (result) {
      case 0:
        if (userData.getAdminStatus()) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HalamanUtamaAdmin()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            //Client
              MaterialPageRoute(builder: (context) => HalamanUtamaAdmin()),
              (Route<dynamic> route) => false);
        }

        break;
      case 1:
        controller_username.clear();
        controller_password.clear();
        setState(() {});
        //Invalid Account
        break;
      case 3:
        //network error
        break;
      default:
        break;
    }
  }

  void showWarning() {
    //do something if username or password isn't filled correctly
  }

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
                width: ukuranlayar.width,
                height: ukuranlayar.height * 0.105,
                color: Colors.blue[400],
                child: Column(
                  children: [
                    Container(
                      width: ukuranlayar.width,
                      height: ukuranlayar.height * 0.07,
                      margin: EdgeInsets.only(top: ukuranlayar.height * 0.035),
                      color: Colors.blue[400],
                      child: ListTile(
                        title: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
            ListView(
              children: [
                Container(
                  height: ukuranlayar.height * 0.90,
                  width: ukuranlayar.width,
                  //  color: Colors.black,
                  margin: EdgeInsets.only(top: ukuranlayar.height * 0.10),
                  child: Column(
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
                        height: ukuranlayar.height * 0.10,
                        //  color: Colors.blue,
                        child: TextFormField(
                          controller: controller_username,
                          decoration: InputDecoration(
                              hintText: 'Username',
                              labelStyle: TextStyle(
                                  color: Colors.blue, fontSize: 0.20)),
                        ),
                      ),
                      Container(
                        width: ukuranlayar.width * 0.85,
                        height: ukuranlayar.height * 0.06,
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
                        width: ukuranlayar.width * 0.5,
                        height: ukuranlayar.height * 0.06,
                        child: CupertinoButton(
                          child: Container(
                            //   color: Colors.blue,
                            child: AutoSizeText(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          color: CupertinoColors.activeOrange,
                          onPressed: () async {
                            await fetchUser();
                          },
                        ),
                      ),
                      SizedBox(
                        height: ukuranlayar.height * 0.05,
                      ),
                      Container(
                          height: ukuranlayar.height * 0.05,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HalamanDaftar()));
                              },
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              ))),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
