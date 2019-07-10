import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';
import 'business/sign/route/lg_signin_route.dart';
import 'business/common_ui/lg_ui_config.dart';
import 'service/internationalization/fq_internationalization.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const FQLocalizationsDelegate(),
         GlobalMaterialLocalizations.delegate,
         GlobalWidgetsLocalizations.delegate,
         GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: [
        const Locale('en'),
        const Locale('zh'), // 这个在iOS 12.2中识别不出中文环境
      ],

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
