import 'package:flutter/material.dart';
import '../../common_ui/lg_ui_config.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: LGMatchBasicOddsView.kOddsViewWidth,
      height: LGMatchBasicOddsView.kOddsViewHeight,
      decoration: BoxDecoration(
        color: kMarqueeBgColor,
        borderRadius: BorderRadius.all(Radius.circular(kCornerRadius)),
      ),
    );
  }
}