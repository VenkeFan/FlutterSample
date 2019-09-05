import 'package:flutter/material.dart';
import 'package:flutter_game/business/common_ui/lg_ui_config.dart';
import 'package:flutter_game/business/main/model/lg_matchlist_keys.dart';
import 'package:flutter_game/business/main/viewmodel/lg_matchdetail_vm.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  
}
