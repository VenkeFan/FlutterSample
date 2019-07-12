import 'package:flutter/material.dart';
import '../../common_ui/lg_ui_config.dart';
import '../model/lg_matchlist_keys.dart';
import 'lg_parlay_widget.dart';

class LGMatchBasicOddsView extends StatefulWidget {
  final Map teamDic;
  final Map oddsDic;
  LGMatchBasicOddsView(this.teamDic, this.oddsDic);

  @override
  State<StatefulWidget> createState() => _LGMatchBasicOddsViewState();

  static const double kOddsViewWidth = 130.0;
  static const double kOddsViewHeight = 40.0;
}

class _LGMatchBasicOddsViewState extends State<LGMatchBasicOddsView> {
  final textStyle = TextStyle();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LGParlayWidget.instance().addTeamAndOdds(widget.teamDic, widget.oddsDic);
      },
      child: Container(
        width: LGMatchBasicOddsView.kOddsViewWidth,
        height: LGMatchBasicOddsView.kOddsViewHeight,
        decoration: BoxDecoration(
          color: kMarqueeBgColor,
          borderRadius: BorderRadius.all(Radius.circular(kCornerRadius)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(widget.oddsDic[kMatchOddsKeyOddsValue],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kNameFontColor,
                    fontSize: kNameFontSize,
                  )),
            ),
            Container(
              child: Text(widget.teamDic[kMatchTeamKeyName],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kNameFontColor,
                    fontSize: kNoteFontSize,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
