import 'package:flutter/material.dart';
import 'package:flutter_game/business/common_ui/lg_ui_config.dart';
import 'package:flutter_game/business/main/viewmodel/lg_matchdetail_vm.dart';

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
        setState(() {
          
        });
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
          )
        ),
        iconTheme: IconThemeData(
          color: kMainOnTintColor,
        ),
      ),
    );
  }
}