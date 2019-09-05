import 'package:flutter/cupertino.dart';
import 'package:flutter_game/business/main/model/lg_matchlist_keys.dart';
import 'package:flutter_game/service/network/http_request/api_request/lg_matchdetail_request.dart';

typedef void LGBasicViewModelCompleted({bool success});

const Map LGMatchStageMapping = {
  '1': '一',
  '2': '二',
  '3': '三',
  '4': '四',
  '5': '五',
  '6': '六',
  '7': '七',
  '8': '八',
  '9': '九',
};

class LGMatchDetailViewModel extends Object {
  final num matchID;
  LGMatchDetailViewModel({@required this.matchID});

  @pragma("Public")
  Map get matchDic => _matchDic;
  Map get oddsDic => _oddsDic;
  List get teamArray => _teamArray;
  List get sortedKeyArray => _sortedKeyArray;
  List get stageNameArray => _stageNameArray;
  Map get leftTeam => _leftTeam;
  Map get rightTeam => _rightTeam;

  @pragma("Private")
  Map _matchDic;
  Map _oddsDic;
  List _teamArray;
  List _sortedKeyArray;
  List _stageNameArray;
  Map _leftTeam;
  Map _rightTeam;

  void fetchDetailData({LGBasicViewModelCompleted completed}) {
    LGMatchDetailRequest request = LGMatchDetailRequest(matchID: this.matchID);
    request.requestMatchDetail(success: (Object responseObject) {
      _matchDic = responseObject;

      _teamArray = _matchDic[kMatchKeyTeamArray];
      if (_teamArray.length > 1) {
        _teamArray.sort(([dynamic obj1, dynamic obj2]) {
          int pos1 = obj1[kMatchTeamKeyPos] as int;
          int pos2 = obj2[kMatchTeamKeyPos] as int;
          return pos1.compareTo(pos2);
        });

        _leftTeam = _teamArray[0];
        _rightTeam = _teamArray[1];
      }

      List oddsArray = _matchDic[kMatchKeyOddsArray];
      _oddsDic = _handleMatchStage(oddsArray);

      _sortGroupDic(_oddsDic);

      if (completed != null) {
        completed(success: true);
      }
    }, failure: (int errorCode) {
      if (completed != null) {
        completed(success: false);
      }
    });
  }

  static String matchStageName(String stageKey, int index) {
    if (stageKey == 'final') {
      index = -99999;
      stageKey = '全场';
    } else if (stageKey.contains('r')) {
      int start = stageKey.indexOf('r');
      int length = 'r'.length;
      String number = stageKey.substring(start + length);
      index = int.parse(number);

      stageKey = '第' + LGMatchStageMapping[number] + '局';

    } else if (stageKey.contains('map')) {
      int start = stageKey.indexOf('map');
      int length = 'map'.length;
      String number = stageKey.substring(start + length);
      index = int.parse(number);

      stageKey = '地图' + LGMatchStageMapping[number];

    } else if (stageKey.contains('1st')) {
      index = -2;
      stageKey = '上半场';

    } else if (stageKey.contains('2nd')) {
      index = -1;
      stageKey = '下半场';

    }  else if (stageKey.contains('q')) {
      int start = stageKey.indexOf('q');
      int length = 'q'.length;
      String number = stageKey.substring(start + length);
      index = int.parse(number);

      stageKey = '第' + LGMatchStageMapping[number] + '节';
    }

    return stageKey;
  }

  void _sortGroupDic(Map dic) {
    List keys = [];
    dic.keys.forEach((dynamic item) => keys.add(item));
    keys.sort(([dynamic obj1, dynamic obj2]) {
      int index1 = 0, index2 = 0;
      LGMatchDetailViewModel.matchStageName(obj1, index1);
      LGMatchDetailViewModel.matchStageName(obj2, index2);

      return index1.compareTo(index2);
    });

    _sortedKeyArray = keys;


    List stageArray = [];
    _sortedKeyArray.forEach((dynamic item) => stageArray.add(LGMatchDetailViewModel.matchStageName(item, 0)));
    _stageNameArray = stageArray;
  }

  Map _handleMatchStage(List oddsArray) {
    Map matchStageDic = Map();

    for (Map oddsDic in oddsArray) {
      if (oddsDic[kMatchOddsKeyStatus] != LGMatchOddsStatus.hidden) {
        String stageKey = oddsDic[kMatchOddsKeyMatchStage];

        if (matchStageDic[stageKey] == null) {
          List listM = List();
          listM.add(oddsDic);
          matchStageDic[stageKey] = listM;
        } else {
          List listM = matchStageDic[stageKey];
          listM.add(oddsDic);
        }
      }
    }

    _handleMatchStageGroup(matchStageDic);

    return matchStageDic;
  }

  void _handleMatchStageGroup(Map matchStageDic) {
    matchStageDic.forEach((dynamic key, dynamic value) {
      Map groupDic = Map();
      List tmpArray = value as List;

      for (var i = 0; i < tmpArray.length; i++) {
        Map oddsDic = tmpArray[i];
        num groupKey = oddsDic[kMatchOddsKeyGroupID];

        if (groupDic[groupKey] == null) {
          List arrayM = List();
          arrayM.add(oddsDic);
          groupDic[groupKey] = arrayM;
        } else {
          List arrayM = groupDic[groupKey];
          arrayM.add(oddsDic);
        }
      }

      List groupArray = List();
      groupDic.forEach((dynamic key2, dynamic value2) {
        groupArray.add(value2);
      });

      _sortGroupArray(groupArray);

      matchStageDic[key] = groupArray;
    });
  }

  void _sortGroupArray(List groupArray) {
    groupArray.sort(([dynamic obj1, dynamic obj2]) {
      List l1 = obj1 as List;
      List l2 = obj2 as List;

      Map oddsDic1 = l1.first;
      Map oddsDic2 = l2.first;

      int index1 = oddsDic1[kMatchOddsKeySortIndex] as int;
      int index2 = oddsDic2[kMatchOddsKeySortIndex] as int;

      return index1.compareTo(index2);
    });

    groupArray.forEach((dynamic item) {
      _sortGroupOddsArray(item);
    });
  }

  void _sortGroupOddsArray(List oddsArray) {
    String tmp = oddsArray.first[kMatchOddsKeyValue];
    if (tmp.startsWith('+') == true || tmp.startsWith('-') == true) {

      List leftOddsArray = List();
      List rightOddsArray = List();

      oddsArray.forEach((dynamic obj) {
        if(obj[kMatchOddsKeyTeamID] == _leftTeam[kMatchTeamKeyTeamID]) {
          leftOddsArray.add(obj);
        } else if (obj[kMatchOddsKeyTeamID] == _rightTeam[kMatchTeamKeyTeamID]) {
          rightOddsArray.add(obj);
        }
      });

      leftOddsArray.sort(([dynamic obj1, dynamic obj2]) {
        return obj1[kMatchOddsKeyValue] < obj2[kMatchOddsKeyValue];
      });

      rightOddsArray.sort(([dynamic obj1, dynamic obj2]) {
        return obj1[kMatchOddsKeyValue] > obj2[kMatchOddsKeyValue];
      });

      List sortedArray = List();
      for(int i = 0; i < leftOddsArray.length + rightOddsArray.length; i++) {
        int j = i ~/ 2;
        if ((i & 1) == 0) {
          sortedArray.add(leftOddsArray[j]);
        } else {
          sortedArray.add(rightOddsArray[j]);
        }
      }

      oddsArray.clear();
      sortedArray.forEach((dynamic obj) {
        oddsArray.add(obj);
      });

    } else if (tmp.startsWith('>') == true || tmp.startsWith('-') == true) {

      oddsArray.sort(([dynamic obj1, dynamic obj2]) {
        String str1 = obj1[kMatchOddsKeyValue].toString().substring(1);
        String str2 = obj2[kMatchOddsKeyValue].toString().substring(1);

        double value1 = double.parse(str1);
        double value2 = double.parse(str2);

        if (value1 == value2) {
          return obj2[kMatchOddsKeyValue].toString().startsWith('>') == true ? 1 : -1;
        }

        return value1.compareTo(value2);
      });

    } else if (oddsArray.length == 3) {
      for (int i = 0; i < oddsArray.length; i++) {
        Map obj = oddsArray[i];
        if (i != 0 && obj[kMatchOddsKeyTeamID] == _leftTeam[kMatchTeamKeyTeamID]) {
          Map tmp = oddsArray[0];
          oddsArray[0] = obj;
          oddsArray[i] = tmp;
        } else if (i != 1 && obj[kMatchOddsKeyTeamID] == _rightTeam[kMatchTeamKeyTeamID]) {
          Map tmp = oddsArray[1];
          oddsArray[1] = obj;
          oddsArray[i] = tmp;
        }
      }
    } else if (oddsArray.first[kMatchOddsKeyTeamID] == 0) {
      oddsArray.sort(([dynamic obj1, dynamic obj2]) {
        String value1 = obj1[kMatchOddsKeyValue];
        String value2 = obj2[kMatchOddsKeyValue];
        return value1.compareTo(value2);
      });
    } else {
      oddsArray.sort(([dynamic obj1, dynamic obj2]) {
        num teamID1 = obj1[kMatchOddsKeyTeamID];
        num teamID2 = obj2[kMatchOddsKeyTeamID];
        return teamID2.compareTo(teamID1);
      });
    }
  }
}
