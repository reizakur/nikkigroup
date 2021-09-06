
part of 'screens.dart';
class HalamanLogin extends StatefulWidget {
  HalamanLogin({Key? key}) : super(key: key);

  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  late Size ukuranlayar;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    ukuranlayar = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        body: Container(
          width: ukuranlayar.width,
          height: ukuranlayar.height,
          child: Column(
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
                        margin:
                            EdgeInsets.only(top: ukuranlayar.height * 0.035),
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
                  decoration: InputDecoration(
                      hintText: 'Username',
                      labelStyle:
                          TextStyle(color: Colors.blue, fontSize: 0.20)),
                ),
              ),
              Container(
                width: ukuranlayar.width * 0.85,
                height: ukuranlayar.height * 0.06,
                // color: Colors.yellow,
                child: TextFormField(
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
                      'Login Admin',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ),
                  color: CupertinoColors.activeOrange,
                  onPressed: () {
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
                            fontSize: 16, decoration: TextDecoration.underline),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
