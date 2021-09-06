part of'../screens.dart';
class HalamanRiwayatAgen extends StatefulWidget {
  

  @override
  _HalamanRiwayatAgenState createState() => _HalamanRiwayatAgenState();
}

class _HalamanRiwayatAgenState extends State<HalamanRiwayatAgen> {
  Size ukuranlayar;
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
