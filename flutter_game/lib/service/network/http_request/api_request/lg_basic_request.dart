import '../../engine/fq_network_manager.dart';
import '../lg_api_url_config.dart';
import '../lg_api_error_code.dart';

class LGBasicRequest extends Object {
  Map<String, dynamic> paraMap;

  String _apiName;
  HTTPRequestMethod _method;

  LGBasicRequest.initialize(String apiName, HTTPRequestMethod method) {
    this._apiName = apiName;
    this._method = method;
    this.paraMap = Map<String, dynamic>();
  }

  void requestData({RequestSucceedBlock success, RequestFailBlock failure}) {
    FQNetworkManager manager = FQNetworkManager(kBasicURL);
    manager.requestUrl(
        apiName: this._apiName,
        method: this._method,
        parameters: this.paraMap,
        success: (Object responseObject) {
          if (responseObject == null) {
            _handleFailure(failure, LGErrorCode.unDefine);
            return;
          }

          if (responseObject is! Map) {
            _handleFailure(failure, LGErrorCode.unDefine);
            return;
          }

          Map<dynamic, dynamic> responseMap = responseObject as Map<dynamic, dynamic>;
          
          Object errorObj = responseMap["code"];
          int errorCode = LGErrorCode.unDefine;

          if (errorObj is int) {
            errorCode = errorObj;

          } else if (errorObj is String) {
            try {
              errorCode = int.parse(errorObj);
            } catch (e) {
              _handleFailure(failure, LGErrorCode.unDefine);
            }
          } else {
            _handleFailure(failure, LGErrorCode.unDefine);
            return;
          }
          
          if (errorCode == LGErrorCode.accessToken) {
            print("need sign in");
            return;
          }

          if (errorCode != LGErrorCode.success) {
            _handleFailure(failure, errorCode);
            return;
          }

          if (success != null) {
            success(responseMap["result"]);
          }
        },
        failure: (int errorCode) {
          _handleFailure(failure, errorCode);
        });
  }

  void _handleFailure(RequestFailBlock failure, int errorCode) {
    if (failure != null) {
      failure(errorCode);
    }
  }
}
