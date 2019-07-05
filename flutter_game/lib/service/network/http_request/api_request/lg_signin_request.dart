import '../../engine/fq_network_manager.dart';
import '../lg_api_url_config.dart';
import 'lg_basic_request.dart';

class LGSignRequest extends LGBasicRequest {
  LGSignRequest() : super.initialize(kAPISignInURL, HTTPRequestMethod.method_post);

  void requestSignIn(String accountName, String pwd, {RequestSucceedBlock success, RequestFailBlock failure}) {
    if (accountName.length == 0 || pwd.length == 0) {
      return;
    }

    this.paraMap["username"] = accountName;
    this.paraMap["password"] = pwd;

    super.requestData(success: (Object responseObject) {
      if (success != null) {
        success(responseObject);
      }
    }, failure: (int errorCode) {
      if (failure != null) {
        failure(errorCode);
      }
    });
  }
}