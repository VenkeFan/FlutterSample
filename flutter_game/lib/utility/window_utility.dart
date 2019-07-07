import 'package:flutter/widgets.dart';

class FQWindowUtility {
  FQWindowUtility._internal();
  static FQWindowUtility _instance;

  factory FQWindowUtility.initialize(BuildContext context) {
    if (_instance == null) {
      _instance = FQWindowUtility._internal();

      final Size screenSize = MediaQuery.of(context).size;
      _instance._screenWidth = screenSize.width;
      _instance._screenHeight = screenSize.height;
    }
    return _instance;
  }

  factory FQWindowUtility.instance() {
    return _instance;
  }

  @pragma("Private")
  double _screenWidth;
  double _screenHeight;

  @pragma("Public")
  double get screenWidth => this._screenWidth;
  double get screenHeight => this._screenHeight;
}