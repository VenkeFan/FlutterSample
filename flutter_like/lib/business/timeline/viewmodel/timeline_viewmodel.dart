import 'package:flutter/services.dart';
import 'package:flutter_like/service/network/httprequest.dart';
import 'package:flutter_like/business/timeline/model/timeline_propertykeys.dart';
// import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

const bool _isBundle = true;

typedef void TimelineViewModelFinishedCallBack(
    List<dynamic> itemList, String errorInfo);

class TimelineViewModel {
  fetchDiscovery(TimelineViewModelFinishedCallBack callBack) {
    if (_isBundle) _fetchFromBundle(callBack);
    else _fetchFromNet(callBack);
  }

  void _fetchFromBundle(TimelineViewModelFinishedCallBack callBack) async {
    // DefaultAssetBundle.of(context).load("lib/resources/weibo_0.json");
    var json = await rootBundle.loadString("lib/resources/weibo_0.json");
    var data = jsonDecode(json);
    if (data == null) {
      return;
    }
    List<dynamic> items = data[kTimelineListKey];
    if (items.isEmpty) {
      return;
    }

    if (callBack != null) {
      callBack(items, null);
    }
  }

  void _fetchFromNet(TimelineViewModelFinishedCallBack callBack) {
    BasicRequest requset = BasicRequest();
    requset.requsetDiscovery((Map<String, dynamic> result, String errorInfo) {
      List<dynamic> items = result["list"];
      if (callBack != null) {
        callBack(items, errorInfo);
      }
    });
  }
}
