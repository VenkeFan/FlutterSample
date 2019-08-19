import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

typedef void FQGEViewModelCallBack(List<dynamic> itemList, bool success);

class FQGeneralEnglisthViewModel extends Object {
  List<dynamic> itemArray;
  List<dynamic> allUrlArray;

  void fetchData(FQGEViewModelCallBack callback) async {
    var json = await rootBundle.loadString('lib/resources/general_english/general_english1.json');
    if (json == null) {
      return;
    }
    var data = jsonDecode(json);

    this.itemArray = data['result'];

    if (callback != null) {
      callback(this.itemArray, true);
    }
  }
}