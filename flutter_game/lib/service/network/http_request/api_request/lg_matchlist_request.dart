import 'lg_basic_request.dart';
import '../../engine/fq_network_manager.dart';
import '../lg_api_url_config.dart';

class LGMatchListRequest extends LGBasicRequest {
  final int listType;
  LGMatchListRequest(this.listType) : super.initialize(kAPIMatchListURL + listType.toString(), HTTPRequestMethod.method_get);

  void requestMatchList({RequestSucceedBlock success, RequestFailBlock failure}) {
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