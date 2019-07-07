import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/utility/window_utility.dart';
import '../management/lg_signflow_manager.dart';
import '../../common_ui/lg_ui_config.dart';

class LGSignInRoute extends StatelessWidget {
  final fieldTxtStyle = TextStyle(
    color: kNameFontColor,
    fontSize: kFieldFontSize,
  );

  @pragma('Events')
  void _forgetBtnPressed() {
    print('_forgetBtnPressed');
  }

  void _signInBtnPressed() {
    print('_signInBtnPressed');
    // LGSignFlowManager flowManager = LGSignFlowManager();
    // flowManager.signIn("18701147885", "000000");
  }
  
  void _signUpBtnPressed() {
    print('_signUpBtnPressed');
  }

  void _visiteBtnPressed() {
    print('_visiteBtnPressed');
  }

  @override
  Widget build(BuildContext context) {
    FQWindowUtility.initialize(context);
    final screenWidth = FQWindowUtility.instance().screenWidth;
    final screenHeight = FQWindowUtility.instance().screenHeight;

    final x = 28.0, y = screenHeight * 0.5 - 50.0;
    final width = screenWidth - x * 2;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/sign_bg.jpg'), fit: BoxFit.fill)),
        position: DecorationPosition.background,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          margin: EdgeInsets.only(top: y, left: x, right: x),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                style: fieldTxtStyle,
                cursorColor: kNameFontColor,
                textCapitalization: TextCapitalization.characters,
                obscureText: true,
                decoration: InputDecoration(
                  // border: UnderlineInputBorder(
                  //     borderSide: BorderSide(
                  //   color: Colors.red,
                  // )),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPlaceholderColor,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPlaceholderColor,
                    )
                  ),
                  filled: true,
                  hintText: '请输入登录账号或手机号',
                  hintStyle: fieldTxtStyle,
                  labelText: '账号',
                  labelStyle: fieldTxtStyle,
                ),
              ),
              TextFormField(
                style: fieldTxtStyle,
                cursorColor: kNameFontColor,
                textCapitalization: TextCapitalization.characters,
                obscureText: true,
                maxLength: 8,
                decoration: InputDecoration(
                  // border: UnderlineInputBorder(
                  //     borderSide: BorderSide(
                  //   color: Colors.red,
                  // )),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPlaceholderColor,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPlaceholderColor,
                    )
                  ),
                  filled: true,
                  hintText: '请输入密码',
                  hintStyle: fieldTxtStyle,
                  labelText: '密码',
                  labelStyle: fieldTxtStyle,
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0.0),
                color: Colors.transparent,
                textColor: kPlaceholderColor,
                child: Text(
                  '忘记密码？',
                  style: TextStyle(
                    fontSize: kFieldFontSize,
                  ),
                ),
                onPressed: _forgetBtnPressed,
              ),
              Container(
                width: width,
                child: FlatButton(
                  color: kMainOnTintColor,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(kCornerRadius)),
                  ),
                  child: Text(
                    '账号登录',
                    style: TextStyle(
                      fontSize: kNameFontSize,
                    ),
                  ),
                  onPressed: _signInBtnPressed,
                ),
              ),
              Container(
                width: width,
                child: FlatButton(
                  color: kMarqueeBgColor,
                  textColor: kMainOnTintColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(kCornerRadius)),
                  ),
                  child: Text(
                    '账号注册',
                    style: TextStyle(
                      fontSize: kNameFontSize,
                    ),
                  ),
                  onPressed: _signUpBtnPressed,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: Colors.transparent,
                  textColor: kPlaceholderColor,
                  shape: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPlaceholderColor,
                    )
                  ),
                  child: Text(
                    '游客登录',
                    style: TextStyle(
                      fontSize: kFieldFontSize,
                    ),
                  ),
                  onPressed: _visiteBtnPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
