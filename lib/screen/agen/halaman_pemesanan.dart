part of'../screens.dart';

class HalamanPemesanan extends StatefulWidget {
  

  @override
  _HalamanPemesananState createState() => _HalamanPemesananState();
}

class _HalamanPemesananState extends State<HalamanPemesanan> {
  Size ukuranlayar;
  @override
  Widget build(BuildContext context) {
    ukuranlayar = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              //  alignment: Alignment.center,
              height: ukuranlayar.height * 0.50,
              //  width: ukuranlayar.width * 0.95,
              decoration: BoxDecoration(
                  //    color: Colors.yellow,
                  ),
              margin: EdgeInsets.only(
                top: ukuranlayar.height * 0.105,
                //      left: ukuransadjssahlayar.width * 0.02),
              ),
              child: Column(
                children: [
                  Container(
                      height: ukuranlayar.height * 0.08,
                      decoration: BoxDecoration(
                          //color: Colors.blue,
                          ),
                      child: ListTile(
                        leading: Icon(Icons.face),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Nama Pemesan',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      // color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.verified_user_rounded),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Nama Barang',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      //      color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.price_change_outlined),
                        title: TextFormField(
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
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Total',
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
                            onPressed: () {
                              print('kirim');
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
