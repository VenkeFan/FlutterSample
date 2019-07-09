import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../model/lg_matchlist_keys.dart';
import '../../common_ui/lg_ui_config.dart';
import '../viewmodel/lg_matchlist_viewmodel.dart';
import 'lg_basicodds_widget.dart';

class LGMatchListView extends StatefulWidget {
  final int listType;
  LGMatchListView({this.listType});

  @override
  State<StatefulWidget> createState() => _LGMatchListViewState();
}

class _LGMatchListViewState extends State<LGMatchListView> {
  LGMatchListViewModel _viewModel;
  List<dynamic> _dataList = [];
  final _marginX = 6.0, _marginY = 6.0;
  Map _leftTeam, _rightTeam;
  Map _leftOdds, _rightOdds;

  @override
  void initState() {
    super.initState();

    _viewModel = LGMatchListViewModel(listType: widget.listType);
    _viewModel.fetchData(completed: ({List list, int errorCode}) {
      setState(() {
        if (list != null) {
          _dataList.addAll(list);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this._dataList.length,
      itemBuilder: _buildItem,
    );
  }

  @pragma("Private")
  Widget _buildItem(BuildContext context, int index) {
    // print('_buildItem ------> $index');
    Map dataDic = this._dataList[index];

    this._separateTeamsAndOdds(dataDic);

    // return Card(
    //   color: kCellBgColor,
    //   child: Column(
    //     children: <Widget>[
    //       _buildPlayName(dataDic),
    //       _buildTeamLogo(),
    //     ],
    //   ),
    // );

    return Container(
      height: 166.0,
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      decoration: BoxDecoration(
        color: kCellBgColor,
        borderRadius: BorderRadius.circular(kCornerRadius),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _buildPlayName(dataDic),
          ),
          Expanded(
            child: _buildTeamLogo(),
          ),
          Expanded(
            child: _buildOdds(),
          ),
          // _buildPlayName(dataDic),
          // _buildTeamLogo(),
          // _buildOdds(),
        ],
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

    if (oddsList.length >= 2) {
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
    //   child: Row(...),
    // );

    return Column(
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

  Widget _buildTeamLogo() {
    double size = 60.0;
    double x = _marginX + LGMatchBasicOddsView.kOddsViewWidth * 0.5 - size * 0.5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: x),
          child: Image.network(
            _leftTeam[kMatchTeamKeyLogo],
            width: size,
            height: size,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: x),
          child: Image.network(
            _rightTeam[kMatchTeamKeyLogo],
            width: size,
            height: size,
          ),
        ),
      ],
    );
  }

  Widget _buildOdds() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: _marginX, bottom: _marginY),
          child: LGMatchBasicOddsView(_leftTeam, _leftOdds),
        ),
        Container(
          margin: EdgeInsets.only(right: _marginX, bottom: _marginY),
          child: LGMatchBasicOddsView(_rightTeam, _rightOdds),
        )
      ],
    );
  }
}
