import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      // ListView 的Y坐标会从statusbar的高度开始，暂没找到哪个属性使得它从0开始
      // body: ListView(
      //   children: <Widget>[
      //     MyHeader(),
      //     TitleContainer(),
      //     OperationContainer()
      //     TextContainer(),
      //   ],
      // ),

      body: Column(
        children: <Widget>[
          MyHeader(),
          TitleContainer(),
          OperationContainer(),
          TextContainer(),
        ],
      )
    );
  }
}

class MyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset("images/IMG_3005.GIF", height: 220, fit: BoxFit.cover,);
  }
}

class TitleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      padding: const EdgeInsets.all(32.0),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.cyan,
      //     width: 1.0,
      //     style: BorderStyle.solid
      //   )
      // ),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Oeschinen Lake Campground", 
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                  ),
                  Text(
                    "Kandersteg, Switzerland",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal
                    ),
                  )
                ],
              ),
          ),
          // Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
          // Text("41"),
          FavoriteWidget(isFavorite: true, count: 20,),
        ],
      ),
    );
  }
}

class OperationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      // decoration: BoxDecoration(
      //     border: Border.all(
      //     color: Colors.green,
      //   )
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildMyButton(context, Icons.call, "CALL"),
          buildMyButton(context, Icons.near_me, "ROUTE"),
          buildMyButton(context, Icons.share, "SHARE"),
        ],
      ),
    );
  }

  @pragma("Private")
  Widget buildMyButton(BuildContext context, IconData icon, String title) {
    final Color color = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.red,
      //   )
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(icon, color: color,),
          ),
          Text(title, style: TextStyle(color: color),)
        ],
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  final String text = "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps."
  " Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes."
  " A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest,"
  " leads you to the lake, which warms to 20 degrees Celsius in the summer."
  " Activities enjoyed here include rowing, and riding the summer toboggan run.";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.brown,
      //   )
      // ),
      child: Text(text, softWrap: true),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key key, this.count, this.isFavorite}) : super(key: key);
  
  int count;
  bool isFavorite;

  @override
  State<StatefulWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  int _favoriteCount;

  void _toggleFavorite(TapUpDetails tapDetail) {
    setState(() {
      widget.isFavorite = !widget.isFavorite;
      if (widget.isFavorite) {
        _favoriteCount++;
      } else {
        _favoriteCount--;
      }
      widget.count = _favoriteCount;
    });
  }

  @override
  void initState() {
    super.initState();
    _favoriteCount = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _toggleFavorite,
      child: Row(
        children: <Widget>[
          Icon(
            widget.isFavorite ? Icons.star : Icons.star_border,
            color: Colors.red[500],
          ),
          SizedBox(
            width: 20.0,
            child: Text("$_favoriteCount"),
          ),
        ],
      ),
    );
  }
}