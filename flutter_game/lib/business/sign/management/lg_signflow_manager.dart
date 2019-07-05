import 'package:flutter_game/service/network/http_request/api_request/lg_signin_request.dart';

class LGSignFlowManager extends Object {

  void signIn(String accountName, String pwd) {
    LGSignRequest request = LGSignRequest();
    request.requestSignIn(accountName, pwd, success: (Object responseObject) {
      print("sign in succeed");
    }, failure: (int errorCode) {
      
    });
  }
}