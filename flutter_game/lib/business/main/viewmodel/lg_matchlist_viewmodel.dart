import 'package:flutter_game/service/network/http_request/api_request/lg_matchlist_request.dart';

typedef void MatchListViewModelCompleted({List list, int errorCode});

class LGMatchListViewModel extends Object {
  final int listType;
  LGMatchListViewModel({this.listType});

  void fetchData({MatchListViewModelCompleted completed}) {
    LGMatchListRequest request = LGMatchListRequest(this.listType);
    request.requestMatchList(success: (Object responseObject) {
      Map responseDic = responseObject as Map;
      List list = responseDic["datas"];
      if (completed != null) {
        completed(list: list);
      }
    }, failure: (int errorCode) {
        if (completed != null) {
        completed(errorCode: errorCode);
      }
    });
  }
}