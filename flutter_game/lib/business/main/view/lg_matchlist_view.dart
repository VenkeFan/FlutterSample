import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_game/business/main/route/lg_match_detail_route.dart';
import '../model/lg_matchlist_keys.dart';
import '../../common_ui/lg_ui_config.dart';
import '../viewmodel/lg_matchlist_viewmodel.dart';
import 'lg_basicodds_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LGMatchListView extends StatefulWidget {
  final int listType;
  LGMatchListView({this.listType}) {
    this._loaded = false;
  }

  bool _loaded;
  @pragma('Public')
  void display() {
    if (true == this._loaded) {
      return;
    }
    this._loaded = true;
  }

  @override
  State<StatefulWidget> createState() => _LGMatchListViewState();
}

class _LGMatchListViewState extends State<LGMatchListView> {
  LGMatchListViewModel _viewModel;
  List<dynamic> _dataList = [];
  final _marginX = 6.0, _marginY = 6.0;
  Map _leftTeam, _rightTeam;
  Map _leftOdds, _rightOdds;

  void _beginRefresh() {
    _viewModel.fetchData(completed: ({List list, int errorCode}) {
      if (!this.mounted) {
       return; 
      }
      setState(() {
        if (list != null) {
          list.sort((dynamic a, dynamic b) {
            return a[kMatchKeyStartTime].toString().compareTo(b[kMatchKeyStartTime].toString());
          });
          _dataList.addAll(list);
        }
      });
    });
  }

  @override
  void dispose() {
    // print('LGMatchListView ${this.widget.listType} dispose!!!!!!!!!!!!!!');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _viewModel = LGMatchListViewModel(listType: widget.listType);
    
    if (this.widget._loaded) {
      this._beginRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null != this._dataList ? this._dataList.length : 0,
      itemBuilder: _buildItem,
    );
  }

  @pragma("Private")
  Widget _buildItem(BuildContext context, int index) {
    Map dataDic = this._dataList[index];

    this._separateTeamsAndOdds(dataDic);

    return Container(
      height: 166.0,
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      decoration: BoxDecoration(
        color: kCellBgColor,
        borderRadius: BorderRadius.circular(kCornerRadius),
      ),
      child: InkWell(
        onTap: () {
          print('${dataDic[kMatchKeyID]}');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return LGMatchDetailRoute(matchID: dataDic[kMatchKeyID],);
            }
          ));
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildPlayName(dataDic),
            ),
            Expanded(
              child: _buildTeamLogo(dataDic),
            ),
            Expanded(
              child: _buildOdds(dataDic),
            ),
            // _buildPlayName(dataDic),
            // _buildTeamLogo(),
            // _buildOdds(),
          ],
        ),
      ),
    );
  }

  void _separateTeamsAndOdds(Map dataDic) {
    List teamList = dataDic[kMatchKeyTeamArray];
    List oddsList = dataDic[kMatchKeyOddsArray];

    for (var tmp in teamList) {
      if (tmp[kMatchTeamKeyPos] == 1) {
        _leftTeam = tmp;
      } else if (tmp[kMatchTeamKeyPos] == 2) {
        _rightTeam = tmp;
      }
    }

    if (null != oddsList && oddsList.length >= 2) {
      if (_leftTeam[kMatchTeamKeyTeamID] == oddsList[0][kMatchOddsKeyTeamID]) {
        _leftOdds = oddsList[0];
        _rightOdds = oddsList[1];
      } else {
        _leftOdds = oddsList[1];
        _rightOdds = oddsList[0];
      }
    }
  }

  Widget _buildPlayName(Map dataDic) {
    // return Container(
    //   height: 24.0,
    //   margin: EdgeInsets.fromLTRB(_marginX, _marginY, _marginX, 0.0),
    //   decoration: BoxDecoration(
    //     color: kMarqueeBgColor,
    //     borderRadius: BorderRadius.circular(kCornerRadius),
    //   ),
    //   // child: Row(...),
    // );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 24.0,
          margin: EdgeInsets.fromLTRB(_marginX, _marginY, _marginX, 0.0),
          decoration: BoxDecoration(
            color: kMarqueeBgColor,
            borderRadius: BorderRadius.circular(kCornerRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: _marginX),
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
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                margin: EdgeInsets.only(right: _marginX),
                decoration: BoxDecoration(
                  color: kMainBgColor,
                  borderRadius:
                      BorderRadius.circular((kNoteFontSize + 2.0) * 0.5),
                ),
                child: Text(
                  '+' + dataDic[kMatchKeyPlayCount].toString(),
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: kNoteFontSize,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTeamLogo(Map dataDic) {
    double logoSize = 60.0;
    double x =
        _marginX + LGMatchBasicOddsView.kOddsViewWidth * 0.5 - logoSize * 0.5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: x),
          // child: Image.network(
          //   _leftTeam[kMatchTeamKeyLogo],
          //   width: logoSize,
          //   height: logoSize,
          // ),
          child: CachedNetworkImage(
            imageUrl: _leftTeam[kMatchTeamKeyLogo],
            width: logoSize,
            height: logoSize,
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        _buildTeamMiddle(dataDic),
        Container(
          margin: EdgeInsets.only(right: x),
          // child: Image.network(
          //   _rightTeam[kMatchTeamKeyLogo],
          //   width: logoSize,
          //   height: logoSize,
          // ),
          child: CachedNetworkImage(
            imageUrl: _rightTeam[kMatchTeamKeyLogo],
            width: logoSize,
            height: logoSize,
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ],
    );
  }

  String _shortStartTime(String startTime) {
    int index = startTime.indexOf(' ');
    return startTime.substring(index, index + 6);
  }

  Widget _buildTeamMiddle(Map dataDic) {
    final timeWidget = Container(
      child: Text(
        _shortStartTime(dataDic[kMatchKeyStartTime]),
        style: TextStyle(
          color: kScoreFontColor,
          fontSize: kNameFontSize,
        ),
      ),
    );

    final scoreWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _leftTeam[kMatchTeamKeyScore][kMatchScoreKeyTotal] != null
              ? _leftTeam[kMatchTeamKeyScore][kMatchScoreKeyTotal].toString()
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
          _rightTeam[kMatchTeamKeyScore][kMatchScoreKeyTotal] != null
              ? _rightTeam[kMatchTeamKeyScore][kMatchScoreKeyTotal].toString()
              : '0',
          style: TextStyle(
            color: kScoreFontColor,
            fontSize: kScoreFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    int matchStatus = dataDic[kMatchKeyStatus];
    switch (widget.listType) {
      case LGMatchListType.prepare:
        {
          return timeWidget;
        }
        break;
      case LGMatchListType.today:
        {
          switch (matchStatus) {
            case LGMatchStatus.prepare:
              {
                return timeWidget;
              }
              break;
            case LGMatchStatus.rolling:
              {
                return scoreWidget;
              }
              break;
            default:
              {
                return scoreWidget;
              }
              break;
          }
        }
        break;
      case LGMatchListType.rolling:
        {
          switch (matchStatus) {
            case LGMatchStatus.prepare:
              {
                return timeWidget;
              }
              break;
            case LGMatchStatus.rolling:
              {
                return scoreWidget;
              }
              break;
            default:
              {
                return scoreWidget;
              }
              break;
          }
        }
        break;
      case LGMatchListType.finished:
        {
          return scoreWidget;
        }
        break;
      default:
        return Container();
        break;
    }
  }

  Widget _buildOdds(Map dataDic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: _marginX, bottom: _marginY),
          child: LGMatchBasicOddsView(_leftTeam, _leftOdds, dataDic[kMatchKeyMatchName]),
        ),
        _buildBtmStatusWidget(dataDic),
        Container(
          margin: EdgeInsets.only(right: _marginX, bottom: _marginY),
          child: LGMatchBasicOddsView(_rightTeam, _rightOdds, dataDic[kMatchKeyMatchName]),
        )
      ],
    );
  }

  Widget _buildBtmStatusWidget(Map dataDic) {
    int matchStatus = dataDic[kMatchKeyStatus];

    switch (matchStatus) {
      case LGMatchStatus.prepare:
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('lib/images/main_notStarted2.png'),
              SizedBox(height: 4.0,),
              Text('未开始', style: TextStyle(
                color: kMainOnTintColor,
                fontSize: kNoteFontSize,
              ),),
            ],
          );
        }
        break;
      case LGMatchStatus.rolling:
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('lib/images/main_rolling.png'),
              SizedBox(height: 4.0,),
              Text('滚盘', style: TextStyle(
                color: kMainOnTintColor,
                fontSize: kNoteFontSize,
              ),),
            ],
          );
        }
        break;
      case LGMatchStatus.finished:
      {
        var flagImage = (Map oddsDic) {
          return oddsDic[kMatchOddsKeyWin] == '1' ? 'lib/images/main_win.png' : 'lib/images/main_lose.png';
        };

        return Expanded(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(flagImage(_leftOdds)),
            Image.asset(flagImage(_rightOdds)),
          ],
        ),
        );
      }
      break;
      default:
        {
          return Container();
        }
        break;
    }
  }
}
