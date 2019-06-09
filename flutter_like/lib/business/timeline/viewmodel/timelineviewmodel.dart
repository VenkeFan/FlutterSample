import 'package:flutter_like/service/network/httprequest.dart';

const String kTimelineContentKey = "content";


typedef void TimelineViewModelFinishedCallBack(List<dynamic> itemList, String errorInfo);

class TimelineViewModel {
  fetchDiscovery(TimelineViewModelFinishedCallBack callBack) {
    BasicRequest requset = BasicRequest();
    requset.requsetDiscovery((Map<String, dynamic> result, String errorInfo) {
      List<dynamic> items = result["list"];
      if (callBack != null) {
        callBack(items, errorInfo);
      }
    });
  }
}