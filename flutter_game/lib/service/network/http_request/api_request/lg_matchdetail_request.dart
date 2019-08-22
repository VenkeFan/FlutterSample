
import 'package:flutter/material.dart';
import 'package:flutter_game/service/network/engine/fq_network_manager.dart';
import '../lg_api_url_config.dart';
import 'lg_basic_request.dart';

class LGMatchDetailRequest extends LGBasicRequest {
  LGMatchDetailRequest({@required num matchID}) : super.initialize(kAPIMatchDetailURL + matchID.toString(), HTTPRequestMethod.method_get);

  void requestMatchDetail({RequestSucceedBlock success, RequestFailBlock failure}) {
    super.requestData(success: success, failure: failure);
  }
}