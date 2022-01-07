import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penguin_new_version/screens/screens.dart';
import 'package:get/get.dart';

void main() {
//  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(0.8, 0.8);
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
          );
        },
        title: 'Penguin Utility',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
