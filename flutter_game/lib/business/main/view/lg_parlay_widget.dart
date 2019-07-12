import 'package:flutter/material.dart';
import 'package:flutter_game/utility/window_utility.dart';

class LGParlayWidget extends StatefulWidget {
  LGParlayWidget._initialize();

  static LGParlayWidget _instance;
  factory LGParlayWidget.instance() {
    if (_instance == null) {
      _instance = LGParlayWidget._initialize();
    }
    return _instance;
  }

  @pragma('Public')
  void addTeamAndOdds(Map teamDic, Map oddsDic) {
    print('------> LGParlayWidget addTeamAndOdds');
  }

  @pragma('Public')
  void removeTeamAndOdds(Map teamDic, Map oddsDic) {

  }

  @override
  State<StatefulWidget> createState() => _LGParlayWidgetState();
}

class _LGParlayWidgetState extends State<LGParlayWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double width = FQWindowUtility.instance().screenWidth;
  double height = 200;

  @override
  void initState() {
    super.initState();
    print('------> _LGParlayWidgetState initState');
    _controller = AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    _animation = Tween<double>(begin: FQWindowUtility.instance().screenHeight, end: FQWindowUtility.instance().screenHeight - height).animate(_controller);
    _controller.forward();
  }

  @override
  void setState(fn) {
    super.setState(fn);

    // if (widget._expanded) {
    //   print('------> _LGParlayWidgetState _expanded = true');
    //   _controller.forward();
    // }R
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.red,
      margin: EdgeInsets.only(top: _animation.value),
    );
  }
}