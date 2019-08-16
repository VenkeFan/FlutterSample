import 'package:flutter/material.dart';
import 'package:flutter_englisth/utility/fq_marco.dart';
import 'business/main/courses_widget.dart';
import 'business/main/download_widget.dart';

void main() => runApp(MyApp());

class NavigationIconView {
  NavigationIconView({
    Widget child,
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _child = child,
      item = BottomNavigationBarItem(
         icon: icon,
         title: Text(title),
         backgroundColor: color,
       ),
       controller = AnimationController(
         duration: kThemeAnimationDuration,
         vsync: vsync,
       ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _child;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: _child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter English',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'English'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        child: FQCoursesWidget(),
        icon: const Icon(Icons.class_),
        title: '我的课程',
        color: Colors.teal,
        vsync: this,
      ),
      NavigationIconView(
        child: FQDownloadWidget(),
        icon: const Icon(Icons.file_download),
        title: '下载管理',
        color: Colors.indigo,
        vsync: this,
      ),
    ];

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.R
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('英语专业'),
      ),
      body: Center(
        child: _buildTransitionsStack(),
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
