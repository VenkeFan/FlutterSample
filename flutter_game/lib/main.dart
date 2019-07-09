import 'package:flutter/material.dart';
import 'business/sign/route/lg_signin_route.dart';
import 'business/common_ui/lg_ui_config.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: kNavBarColor,
        canvasColor: kMainBgColor,
      ),
      home: LGSignInRoute(),
    );
  }
}
