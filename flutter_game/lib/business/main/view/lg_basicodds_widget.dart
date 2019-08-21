import 'package:flutter/material.dart';
import '../../common_ui/lg_ui_config.dart';
import '../model/lg_matchlist_keys.dart';
import 'lg_parlay_widget.dart';

class LGMatchBasicOddsView extends StatefulWidget {
  final Map teamDic;
  final Map oddsDic;
  final String matchName;
  LGMatchBasicOddsView(this.teamDic, this.oddsDic, this.matchName);

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

        // PersistentBottomSheetController controller = showBottomSheet(
        //   context: context,
        //   builder: (BuildContext context) {
        //     LGParlayWidget.instance().addTeamAndOdds(widget.teamDic, widget.oddsDic, widget.matchName);
        //     LGParlayWidget.instance().isDisplaying = true;
        //     return LGParlayWidget.instance();
        //   }
        // );
        

        // if (LGParlayWidget.instance().isDisplaying) {
        //   LGParlayWidget.instance().isDisplaying = false;

        // } else {
        //   PersistentBottomSheetController controller = showBottomSheet(
        //     context: context,
        //     builder: (BuildContext context) {
        //       LGParlayWidget.instance().addTeamAndOdds(widget.teamDic, widget.oddsDic);
        //       LGParlayWidget.instance().isDisplaying = true;
        //       return LGParlayWidget.instance();
        //     }
        //   ); 
        // }
        

        // bool added = LGParlayWidget.instance().addTeamAndOdds(widget.teamDic, widget.oddsDic);
        // if (added == true) {
        //   showModalBottomSheet(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return LGParlayWidget.instance();
        //     }
        //   );
        // }

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            LGParlayWidget.instance().addTeamAndOdds(widget.teamDic, widget.oddsDic, widget.matchName);
            return LGParlayWidget.instance();
          }
        );
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
