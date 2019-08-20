import 'package:flutter/material.dart';
import 'package:flutter_englisth/business/general_english/model/fq_english_keys.dart';
import 'package:flutter_englisth/business/general_english/view_model/fq_englisth_viewmodel.dart';
import 'package:flutter_englisth/utility/fq_marco.dart';
import 'package:flutter_englisth/utility/fq_player.dart';

class FQGeneralEnglishRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FQGeneralEnglishRouteState();
}

class _FQGeneralEnglishRouteState extends State<FQGeneralEnglishRoute> {
  FQGeneralEnglisthViewModel _viewModel;
  TextStyle boldTxtStyle = TextStyle(color: kTitleFontColor, fontSize: kTitleFontSize, fontWeight: FontWeight.bold);
  TextStyle regularTxtStyle = TextStyle(color: kTitleFontColor, fontSize: kTitleFontSize);
  TextStyle txtStyle = TextStyle(color: kTitleFontColor, fontSize: kTitleFontSize, fontStyle: FontStyle.italic,);

  @override
  void initState() {
    super.initState();

    _viewModel = FQGeneralEnglisthViewModel();

    _viewModel.fetchData((List<dynamic> itemList, bool success) {
      if (success) {
        setState(() {
          
        });
      }
    });
  }

  List<Widget> _buildActivityTitles(Map itemDic) {
    List<Widget> list = [];

    List activities = itemDic[kGEUniteKeyActivitys];
    for (var i = 0; i < activities.length; i++) {
      Map activity = activities[i];
      List tasks = activity[kGEActivityKeyTasks];

      if (tasks.length > 0) {
        ExpansionTile expansion = ExpansionTile(
          title: Text(activity[kGEActivityKeyName], style: regularTxtStyle,),
          children: _buildTaskTitles(activity),
        );
        list.add(expansion);
      } else {
        ListTile tile = ListTile(
          title: Text(activity[kGEActivityKeyName], style: txtStyle,),
          trailing: Icon(Icons.file_download, color: Theme.of(context).primaryColor,),
        );

        InkWell inkWell = InkWell(
        child: tile,
        onTap: () {
          print("${activity[kGETaskKeyUrl]}");
          this._pushToPlayer(activity[kGETaskKeyUrl]);
        },
      );
        list.add(inkWell);
      }
    }

    return list;
  }

  List<Widget> _buildTaskTitles(Map itemDic) {
    List<Widget> list = [];

    List tasks = itemDic[kGEActivityKeyTasks];
    for (var i = 0; i < tasks.length; i++) {
      Map task = tasks[i];
      
      ListTile tile = ListTile(
        title: Text("- " + task[kGETaskKeyName], style: txtStyle,),
        trailing: Icon(Icons.file_download, color: Theme.of(context).primaryColor,),
      );

      InkWell inkWell = InkWell(
        child: tile,
        onTap: () {
          print("${task[kGETaskKeyUrl]}");
          this._pushToPlayer(task[kGETaskKeyUrl]);
        },
      );
      list.add(inkWell);
    }

    return list;
  }

  void _pushToPlayer(String urlString) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return FQPlayerWidget.network(urlString: urlString);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通用英语1"),
      ),
      body: ListView.builder(
        itemCount: _viewModel.itemArray != null ? _viewModel.itemArray.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Map itemDic = _viewModel.itemArray[index];

          return ExpansionTile(
            title: Text(itemDic[kGEUniteKeyName], style: boldTxtStyle,),
            children: _buildActivityTitles(itemDic),
          );
        },
      ),
    );
  }
}
