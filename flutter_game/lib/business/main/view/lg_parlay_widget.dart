import 'package:flutter/material.dart';
import 'package:flutter_game/business/common_ui/lg_ui_config.dart';
import 'package:flutter_game/business/main/model/lg_matchlist_keys.dart';
import 'package:flutter_game/utility/window_utility.dart';

const String kLGMatchParlayTableViewCellKeyTeamDic          = "kLGMatchParlayTableViewCellKeyTeamDic";
const String kLGMatchParlayTableViewCellKeyOddsDic          = "kLGMatchParlayTableViewCellKeyOddsDic";
const String kLGMatchParlayTableViewCellKeyMatchName        = "kLGMatchParlayTableViewCellKeyMatchName";
const String kLGMatchParlayTableViewCellKeyFieldFocused     = "kLGMatchParlayTableViewCellKeyFieldFocused";
const String kLGMatchParlayTableViewCellKeyAnte             = "kLGMatchParlayTableViewCellKeyAnte";

const double kMatchParlayViewTopHeight = 40.0;
const double kMatchParlayTableViewCellHeight = 68.0;
const double kMatchParlayViewBottomHeight = 52.0;

class LGParlayWidget extends StatefulWidget {
  static LGParlayWidget _instance;
  factory LGParlayWidget.instance() {
    if (_instance == null) {
      _instance = LGParlayWidget._initialize();
    }
    return _instance;
  }

  LGParlayWidget._initialize() {
    _itemArray = [];
    isDisplaying = false;
  }

  List<Map> _itemArray;
  bool isDisplaying;

  @pragma('Public')
  bool addTeamAndOdds(Map teamDic, Map oddsDic, String matchName) {
    if (teamDic == null || oddsDic == null) {
      return false;
    }

    for (var i = 0; i < _itemArray.length; i++) {
      Map tmpOdds = _itemArray[i][kLGMatchParlayTableViewCellKeyOddsDic];
      if (tmpOdds[kMatchOddsKeyOddsID] == oddsDic[kMatchOddsKeyOddsID]) {
        return false;
      }
    }

    Map itemMix = {
      kLGMatchParlayTableViewCellKeyTeamDic: teamDic, 
      kLGMatchParlayTableViewCellKeyOddsDic: oddsDic, 
      kLGMatchParlayTableViewCellKeyMatchName: matchName
    };

    _itemArray.add(itemMix);

    return true;
  }

  @pragma('Public')
  bool removeTeamAndOdds(Map teamDic, Map oddsDic) {
    if (teamDic == null || oddsDic == null) {
      return false;
    }

    for (var i = 0; i < _itemArray.length; i++) {
      Map tmpOdds = _itemArray[i][kLGMatchParlayTableViewCellKeyOddsDic];
      if (tmpOdds[kMatchOddsKeyOddsID] == oddsDic[kMatchOddsKeyOddsID]) {
        _itemArray.remove(tmpOdds);
        return true;
      }
    }

    return false;
  }

  @override
  State<StatefulWidget> createState() => _LGParlayWidgetState();
}

class _LGParlayWidgetState extends State<LGParlayWidget> {
  double width = FQWindowUtility.instance().screenWidth;
  double contentHeight = kMatchParlayTableViewCellHeight;
    
  double totalHeight;

  @override
  void initState() {
    super.initState();
    print('------> _LGParlayWidgetState initState');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._itemArray.length > 1) {
      contentHeight = kMatchParlayTableViewCellHeight * widget._itemArray.length;
    }
    if (widget._itemArray.length > 5) {
      contentHeight = kMatchParlayTableViewCellHeight * 5;
    }
    totalHeight = kMatchParlayViewTopHeight + contentHeight + kMatchParlayViewBottomHeight + FQWindowUtility.instance().safeAreaBottomY;

    return Container(
      width: width,
      height: totalHeight,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          _buildTopWidget(context),
          _buildContentWidget(context),
          _buildBtmWidget(context),
        ],
      ),
    );
  }

  Widget _buildTopWidget(BuildContext context) {
    return Container(
      width: width,
      height: kMatchParlayViewTopHeight,
      decoration: BoxDecoration(
        color: kMainOnTintColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(kCornerRadius), topRight: Radius.circular(kCornerRadius)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(left: kCellMarginX),
            decoration: BoxDecoration(
              color: kCellBgColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Text(widget._itemArray.length.toString(), style: TextStyle(
              color: kMainOnTintColor,
            ),),
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kCellMarginX),
            child: InkWell(
              child: Text("删除全部"),
              onTap: () {
                
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ), 
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kCellMarginX),
            child: Text.rich(TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '余额：'
                ),
                TextSpan(
                  text: '999999999.0'
                )
              ]
            )),
          ),
          Container(
            width: 1.0,
            height: kMatchParlayViewTopHeight,
            color: kCellBgColor,
          ),
          Container(
            width: kMatchParlayViewTopHeight,
            height: kMatchParlayViewTopHeight,
            color: Colors.transparent,
            child: Center(
              child: Text('×', style: TextStyle(
                fontSize: kScoreFontSize
              ),),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContentWidget(BuildContext context) {
    return Container(
      width: width,
      height: contentHeight,
      color: kMainBgColor,
      child: ListView.builder(
        itemCount: widget._itemArray != null ? widget._itemArray.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Map dataDic = widget._itemArray[index];
          Map oddsDic = widget._itemArray[index][kLGMatchParlayTableViewCellKeyOddsDic];
          return Container(
            width: width,
            height: kMatchParlayTableViewCellHeight,
            color: kMainBgColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        color: kMainOnTintColor,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // todo: delete
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Text(oddsDic[kMatchOddsKeyName], style: TextStyle(
                              color: kScoreFontColor,
                              fontSize: kNoteFontSize,
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(oddsDic[kMatchOddsKeyGroupName], style: TextStyle(
                              color: kLightTintColor,
                              fontSize: kTinyFontSize,
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Text(dataDic[kLGMatchParlayTableViewCellKeyMatchName], style: TextStyle(
                              color: kLightTintColor,
                              fontSize: kTinyFontSize,
                            ),),
                          )
                        ],
                      ),
                      Expanded( // 空白占位
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ), 
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: kCellMarginX),
                        child: Text('@' + oddsDic[kMatchOddsKeyOddsValue], style: TextStyle(
                          color: kScoreFontColor,
                          fontSize: kNoteFontSize,
                        ),),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 70.0,
                            height: 28.0,
                            margin: EdgeInsets.only(right: kCellMarginX),
                            decoration: BoxDecoration(
                              color: kInputBgColor,
                              border: Border.all(
                                color: kMainOnTintColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: kCellMarginY * 0.5),
                            child: Text.rich(TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '预计返还 ',
                                  style: TextStyle(
                                    color: kLightTintColor,
                                    fontSize: kTinyFontSize,
                                  )
                                ),
                                TextSpan(
                                  text: dataDic[kLGMatchParlayTableViewCellKeyAnte] != null ? (dataDic[kLGMatchParlayTableViewCellKeyAnte] * oddsDic[kMatchOddsKeyOddsValue]).toString() : '0.00',
                                  style: TextStyle(
                                    color: kScoreFontColor,
                                    fontSize: kTinyFontSize
                                  )
                                )
                              ]
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: kCellMarginX),
                  width: width - kCellMarginX * 2,
                  height: 1.0,
                  color: kSeparateLineColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBtmWidget(BuildContext context) {
    return Container(
      width: width,
      height: kMatchParlayViewBottomHeight + FQWindowUtility.instance().safeAreaBottomY,
      color: kCellBgColor,
    );
  }
}