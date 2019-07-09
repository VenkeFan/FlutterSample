import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'business/sign/route/lg_signin_route.dart';
import 'business/common_ui/lg_ui_config.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
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
