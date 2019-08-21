import 'package:flutter/widgets.dart';

class FQWindowUtility {
  FQWindowUtility._internal();
  static FQWindowUtility _instance;

  factory FQWindowUtility.initialize(BuildContext context) {
    if (_instance == null) {
      _instance = FQWindowUtility._internal();

      MediaQueryData mediaQuery = MediaQuery.of(context);
      
      _instance._screenWidth = mediaQuery.size.width;
      _instance._screenHeight = mediaQuery.size.height;

      _instance._safeAreaBottomY = mediaQuery.padding.bottom;
    }
    return _instance;
  }

  factory FQWindowUtility.instance() {
    return _instance;
  }

  @pragma("Private")
  double _screenWidth;
  double _screenHeight;
  double _safeAreaBottomY;

  @pragma("Public")
  double get screenWidth => this._screenWidth;
  double get screenHeight => this._screenHeight;
  double get safeAreaBottomY => this._safeAreaBottomY;
}