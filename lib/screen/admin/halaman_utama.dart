part of'../screens.dart';
class HalamanUtamaAdmin extends StatefulWidget {
  

  @override
  _HalamanUtamaAdminState createState() => _HalamanUtamaAdminState();
}

class _HalamanUtamaAdminState extends State<HalamanUtamaAdmin> {
  Size ukuranlayar;

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
  void initState() {
    super.initState();

    fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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
                      Text('Pesanan', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.document_scanner,
                      color: Colors.blueGrey,
                    ),
                    Text('Stok', style: TextStyle(color: Colors.grey))
                  ],
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
              height: ukuranlayar.height * 0.35,
              // color: Colors.blue,
              width: ukuranlayar.width * 1.00,
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.55),
              child: ListView(
                shrinkWrap: true,
                children: [
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          '',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          '',
                        ),
                      ),
                    ],

                    rows: ProdukModel.produklist
                        .map((data) => DataRow(cells: [
                              DataCell(Container(
                                //    height: ukuranlayar.height,
                                width: ukuranlayar.width * 0.40,
                                //  color: Colors.blue,
                                child: AutoSizeText(
                                    '${data.nama_br} || ${data.qty} || ${data.harga} ||'),
                              )),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: ukuranlayar.width * 0.18,
                                    height: ukuranlayar.height * 0.03,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: AutoSizeText(
                                        '+ Stok',
                                        //     style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      textColor: Colors.black,
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text('||'),
                                  Container(
                                    width: ukuranlayar.width * 0.18,
                                    height: ukuranlayar.height * 0.03,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: AutoSizeText(
                                        'Hapus',
                                        //   style: TextStyle(fontSize: 10.0),
                                      ),
                                      color: Colors.red,
                                      textColor: Colors.black,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              )),
                            ]))
                        .toList(),
                    // const <DataRow>[
                    //   DataRow(
                    //     cells: <DataCell>[
                    //       DataCell(Text('Mohit')),
                    //       DataCell(Text('23')),
                    //     ],
                    //   ),
                    // ],
                  )
                ],
              ),
            ),
            Container(
              height: ukuranlayar.height * 0.10,
              color: Colors.white,
              width: ukuranlayar.width,
              margin: EdgeInsets.only(top: ukuranlayar.height * 0.55),
              child: Container(
                margin: EdgeInsets.only(top: ukuranlayar.height * 0.05),
                height: ukuranlayar.height * 0.05,
                color: Colors.blue,
                child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: ukuranlayar.width * 0.25,
                      margin: EdgeInsets.only(left: ukuranlayar.width * 0.04),
                      //  color: Colors.black,
                      child: Text(
                        'Nama Barang',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: ukuranlayar.width * 0.25,
                      // color: Colors.white,
                      margin: EdgeInsets.only(left: ukuranlayar.width * 0.11),
                      child: Text(
                        'Stok',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: ukuranlayar.width * 0.25,
                      //  color: Colors.black,

                      margin: EdgeInsets.only(left: ukuranlayar.width * 0.08),
                      child:
                          Text('Harga', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
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
                          'Tambah Produk',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.print)),
                      ),
                    ),
                  ],
                )),
            Container(
              //  alignment: Alignment.center,
              height: ukuranlayar.height * 0.50,
              //  width: ukuranlayar.width * 0.95,
              decoration: BoxDecoration(
                  //    color: Colors.yellow,
                  ),
              margin: EdgeInsets.only(
                top: ukuranlayar.height * 0.105,
                //      left: ukuranlayar.width * 0.02),
              ),
              child: Column(
                children: [
                  Container(
                      height: ukuranlayar.height * 0.08,
                      decoration: BoxDecoration(
                          //color: Colors.blue,
                          ),
                      child: ListTile(
                        leading: Icon(Icons.production_quantity_limits),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Produk',
                          ),
                        ),
                      )),
                  Container(
                      height: ukuranlayar.height * 0.08,
                      // color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.camera_alt_outlined),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            //   border: InputBorder.none,
                            hintText: 'Foto',
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
                            hintText: 'Stok',
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
