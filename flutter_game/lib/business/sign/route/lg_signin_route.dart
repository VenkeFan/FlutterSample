import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/utility/window_utility.dart';
import '../management/lg_signflow_manager.dart';
import '../../common_ui/lg_ui_config.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class LGSignInRoute extends StatelessWidget {
  final GlobalKey<FormFieldState<String>> _accountFieldKey = GlobalKey(debugLabel: 'accountFieldKey'); // GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _pwdFieldKey = GlobalKey(debugLabel: 'pwdFieldKey'); // GlobalKey<FormFieldState<String>>();

  final fieldTxtStyle = TextStyle(
    color: kNameFontColor,
    fontSize: kFieldFontSize,
  );

  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
    .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        // _scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text('You selected: $value'),
        // ));
      }
    });
  }

  @pragma('Events')
  void _forgetBtnPressed() {
    print('_forgetBtnPressed');
  }

  void _signInBtnPressed() {
    final FormFieldState<String> accountField = _accountFieldKey.currentState;
    final FormFieldState<String> pwdField = _pwdFieldKey.currentState;

    if (!accountField.validate() || !pwdField.validate()) {
      return;
    } 

    LGSignFlowManager flowManager = LGSignFlowManager();
    flowManager.signIn(accountField.value, pwdField.value);
  }
  
  void _signUpBtnPressed() {
    print('_signUpBtnPressed');
  }

  void _visiteBtnPressed() {
    print('_visiteBtnPressed');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);
    
    FQWindowUtility.initialize(context);
    final screenWidth = FQWindowUtility.instance().screenWidth;
    final screenHeight = FQWindowUtility.instance().screenHeight;

    final x = 28.0, y = 83.0; // screenHeight * 0.5 - 150.0;
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
                key: _accountFieldKey,
                style: fieldTxtStyle,
                cursorColor: kNameFontColor,
                textCapitalization: TextCapitalization.characters,
                validator: (String value) {
                  print('------------->validator: $value');

                  if (value.length < 6 || value.length > 16) {
                    return '账号格式错误 6-16位';
                    
                    // showDemoDialog<DialogDemoAction>(
                    //   context: context,
                    //   child: AlertDialog(
                    //     content: Text(
                    //       '账号格式错误',
                    //       style: dialogTextStyle,
                    //     ),
                    //     actions: <Widget>[
                    //       FlatButton(
                    //         child: const Text('CANCEL'),
                    //         onPressed: () { Navigator.pop(context, DialogDemoAction.cancel); },
                    //       ),
                    //       FlatButton(
                    //         child: const Text('DISCARD'),
                    //         onPressed: () { Navigator.pop(context, DialogDemoAction.discard); },
                    //       ),
                    //     ],
                    //   ),
                    // );
                    // return '';
                  }
                },
                onSaved: (String value) {
                  print('------------->onSaved: $value');
                },
                onFieldSubmitted: (String value) {
                  print('------------->onFieldSubmitted: $value');
                },
                // onEditingComplete: () {
                //   print('------------->onEditingComplete');
                // },
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
                key: _pwdFieldKey,
                style: fieldTxtStyle,
                cursorColor: kNameFontColor,
                textCapitalization: TextCapitalization.characters,
                obscureText: true,
                maxLength: 16,
                validator: (String value) {
                  if (value.length < 6 || value.length > 16) {
                    return '密码格式错误 6-16位';
                  }
                },
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
