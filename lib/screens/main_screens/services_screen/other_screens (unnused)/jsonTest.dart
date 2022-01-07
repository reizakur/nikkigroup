part of '../../../screens.dart';

class JSONPageTest extends StatefulWidget {
  @override
  _JSONPageTestState createState() => _JSONPageTestState();
}

class _JSONPageTestState extends State<JSONPageTest> {
  Size size;
  String toDisplay = 'noData';
  @override
  void initState() {
    super.initState();
    testJson();
  }

  Future<void> testJson() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    TestingCodec coba = TestingCodec();
    TestingCodec.data = await deviceInfoPlugin.androidInfo;
    setState(() {
      toDisplay = json.encode(coba.getData()).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [Text(toDisplay)],
        ),
      ),
    );
  }
}
