import 'package:flutter/material.dart';
import 'package:flutter_game/business/common_ui/lg_ui_config.dart';
import 'package:flutter_game/business/main/model/lg_matchlist_keys.dart';
import 'package:flutter_game/business/main/view/lg_basicodds_widget.dart';
import 'package:flutter_game/business/main/viewmodel/lg_matchdetail_vm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tableview/flutter_tableview.dart';

const double kMatchDetailTableViewCellLineHeight = 14.0;
const double kMatchDetailTableViewCellPadding = 8.0;
const double kMatchTeamOddsHViewHeight = 40.0;

class LGMatchDetailRoute extends StatefulWidget {
  final num matchID;
  LGMatchDetailRoute({@required this.matchID});

  @override
  State<StatefulWidget> createState() => _LGMatchDetailRouteState();
}

class _LGMatchDetailRouteState extends State<LGMatchDetailRoute> {
  LGMatchDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = LGMatchDetailViewModel(matchID: widget.matchID);
    _viewModel.fetchDetailData(completed: ({bool success}) {
      if (success) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('游戏竞猜'),
        textTheme: TextTheme(
            title: TextStyle(
          fontSize: kHeaderFontSize,
          color: kMainOnTintColor,
        )),
        iconTheme: IconThemeData(
          color: kMainOnTintColor,
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildHeader(_viewModel.matchDic),
          Expanded(
            child: _buildContext(),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(Map dataDic) {
    if (dataDic == null) {
      return Container();
    }

    return Container(
      height: 148.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kCellBgColor,
        borderRadius: BorderRadius.circular(kCornerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(6.0),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: dataDic[kMatchKeyTournamentName],
                    style: TextStyle(
                      color: kNameFontColor,
                    ),
                  ),
                  TextSpan(
                    text: '/' + dataDic[kMatchKeyRound].toUpperCase(),
                    style: TextStyle(
                      color: kMainOnTintColor,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: kNameFontSize,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 6.0),
                    child: CachedNetworkImage(
                      imageUrl: _viewModel.leftTeam[kMatchTeamKeyLogo],
                      width: 60.0,
                      height: 60.0,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    height: 16.0,
                    color: Colors.red,
                  ),
                  Text(
                    _viewModel.leftTeam[kMatchTeamKeyName],
                    style: TextStyle(
                      color: kNameFontColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _viewModel.leftTeam[kMatchTeamKeyScore]
                                  [kMatchScoreKeyTotal] !=
                              null
                          ? _viewModel.leftTeam[kMatchTeamKeyScore]
                                  [kMatchScoreKeyTotal]
                              .toString()
                          : '0',
                      style: TextStyle(
                        color: kScoreFontColor,
                        fontSize: kScoreFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      width: 14.0,
                      height: 2.0,
                      color: kMarqueeBgColor,
                    ),
                    Text(
                      _viewModel.rightTeam[kMatchTeamKeyScore]
                                  [kMatchScoreKeyTotal] !=
                              null
                          ? _viewModel.rightTeam[kMatchTeamKeyScore]
                                  [kMatchScoreKeyTotal]
                              .toString()
                          : '0',
                      style: TextStyle(
                        color: kScoreFontColor,
                        fontSize: kScoreFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 6.0),
                    child: CachedNetworkImage(
                      imageUrl: _viewModel.rightTeam[kMatchTeamKeyLogo],
                      width: 60.0,
                      height: 60.0,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    height: 16.0,
                    color: Colors.green,
                  ),
                  Text(
                    _viewModel.rightTeam[kMatchTeamKeyName],
                    style: TextStyle(
                      color: kNameFontColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContext() {
    if (_viewModel.sortedKeyArray == null) {
      return Container();
    }

    int sectionCount = _viewModel.sortedKeyArray.length;

    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      decoration: BoxDecoration(
        color: kCellBgColor,
        borderRadius: BorderRadius.circular(kCornerRadius),
      ),
      child: FlutterTableView(
        sectionCount: sectionCount,
        rowCountAtSection: _rowCountAtSection,
        sectionHeaderBuilder: _sectionHeaderBuilder,
        cellBuilder: _cellBuilder,
        sectionHeaderHeight: (BuildContext context, int section) => 40.0,
        cellHeight: _cellHeight,
      ),
    );
  }

  int _rowCountAtSection(int section) {
    if (_viewModel.oddsDic == null) {
      return 0;
    }

    List oddsArray = _viewModel.oddsDic[_viewModel.sortedKeyArray[section]];
    return oddsArray.length;
  }

  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    return Container(
      height: 40.0,
      color: kCellBgColor,
      child: Center(
        child: Text(LGMatchDetailViewModel.matchStageName(_viewModel.sortedKeyArray[section], 0), style: TextStyle(
          color: kNameFontColor,
        ),),
      )
    );
  }

  Widget _cellBuilder(BuildContext context, int section, int row) {
    if (_viewModel.matchDic == null) {
      return Container();
    }

    List oddsArray = _viewModel.oddsDic[_viewModel.sortedKeyArray[section]][row];

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: kMatchDetailTableViewCellPadding),
              width: 2.0,
              height: kMatchDetailTableViewCellLineHeight,
              color: kMainOnTintColor,
            ),
            Container(
              margin: EdgeInsets.only(left: kMatchDetailTableViewCellPadding),
              child: Text(oddsArray.first[kMatchOddsKeyGroupName], style: TextStyle(
                color: kNameFontColor,
                fontSize: kNameFontSize
              ),)
            )
          ],
        ),

        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: kMatchDetailTableViewCellPadding,
            crossAxisSpacing: kMatchDetailTableViewCellPadding,
            padding: const EdgeInsets.all(kMatchDetailTableViewCellPadding),
            childAspectRatio: 160.0 / 40.0,
            children: _oddsViewBuilder(context, section, row),
          ),
        ),
      ],
    );
  }

  List<Widget> _oddsViewBuilder(BuildContext context, int section, int row) {
    List<Widget> oddsViewArray = [];

    if (_viewModel.matchDic == null) {
      return oddsViewArray;
    }

    List oddsArray = _viewModel.oddsDic[_viewModel.sortedKeyArray[section]][row];
    oddsArray.forEach((dynamic item) {
      int status = item[kMatchOddsKeyStatus];
      if (status != LGMatchOddsStatus.hidden) {
        LGMatchBasicOddsView oddsView;
        
        if (_viewModel.leftTeam[kMatchTeamKeyTeamID] == item[kMatchOddsKeyTeamID]) {
          oddsView = LGMatchBasicOddsView(_viewModel.leftTeam, item, _viewModel.matchDic[kMatchKeyMatchName]);
        } else if (_viewModel.rightTeam[kMatchTeamKeyTeamID] == item[kMatchOddsKeyTeamID]) {
          oddsView = LGMatchBasicOddsView(_viewModel.rightTeam, item, _viewModel.matchDic[kMatchKeyMatchName]);
        } else {
          oddsView = LGMatchBasicOddsView(_viewModel.teamArray.first, item, _viewModel.matchDic[kMatchKeyMatchName]);
        }

        oddsViewArray.add(oddsView);
      }
    });

    return oddsViewArray;
  }

  double _cellHeight(BuildContext context, int section, int row) {
    double totalHeight = 0.0;
    totalHeight += (kMatchDetailTableViewCellLineHeight + kMatchDetailTableViewCellPadding);
    totalHeight += kMatchDetailTableViewCellPadding;

    int validOddsCount = 0;
    List oddsArray = _viewModel.oddsDic[_viewModel.sortedKeyArray[section]][row];
    oddsArray.forEach((dynamic item) {
      int status = item[kMatchOddsKeyStatus];
      if (status != LGMatchOddsStatus.hidden) {
          validOddsCount++;
      }
    });

    double oddsContentViewHeight = (validOddsCount / 2) * (kMatchTeamOddsHViewHeight + kMatchDetailTableViewCellPadding);
    totalHeight += oddsContentViewHeight;

    return totalHeight;
  }

}
