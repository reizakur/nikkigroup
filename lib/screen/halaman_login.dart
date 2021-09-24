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
  void fetchUser() async {
    UserModel.userlist.clear();
    final responseku = await http
        .post('https://nikkigroup.joeloecs.com/mobileapi/login_exe.php', body: {
      "res_id": 'nothing',
    });
    var data = jsonDecode(responseku.body);
    if (data[0]['result'] == '1') {
      print(data[1].toString());
      int count = data[1].length;
      for (int i = 0; i < count; i++) {
        UserModel.userlist.add(UserModel.fromjson(data[1][i]));
      }
      print('check length ${UserModel.userlist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {});
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
                            var formData = FormData.fromMap({
                              'username': controller_username.text,
                              'password': controller_password.text,
                            });
                            var response = await dio.post(
                                'https://joeloecs.com/bersama/nikki/mobileapi/login_exe.php',
                                data: formData);
                            print(
                                'berhasil, ${controller_username.text},${controller_password.text}');
                            fetchUser();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HalamanUtamaAdmin()));
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
