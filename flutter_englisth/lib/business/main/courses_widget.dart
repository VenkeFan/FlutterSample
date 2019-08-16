import 'package:flutter/material.dart';
import 'package:flutter_englisth/utility/fq_marco.dart';

const String kTermItemGroupTitleKey = "kTermItemGroupTitleKey";
const String kTermItemGroupValueKey = "kTermItemGroupValueKey";
const String kTermItemTitleKey = "kTermItemTitleKey";
const String kTermItemClassKey = "kTermItemClassKey";

class FQCoursesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FQCoursesWidgetState();
}

class _FQCoursesWidgetState extends State<FQCoursesWidget> {
  List<Map> _itemArray;

  @override
  void initState() {
    super.initState();

    _itemArray = <Map>[
      {
        kTermItemTitleKey: "通用英语1",
        kTermItemClassKey: "FQGeneralEnglishVC",
      },
      {
        kTermItemTitleKey: "英语听说1",
        kTermItemClassKey: "FQLSEnglisthVC",
      },
      {
        kTermItemTitleKey: "英语语音（暂无资源）",
        kTermItemClassKey: "",
      },
      {
        kTermItemTitleKey: "大学语文",
        kTermItemClassKey: "FQLanguageVC",
      },
      {
        kTermItemTitleKey: "邓小平理论概论",
        kTermItemClassKey: "FQDenglunVC",
      },
      {
        kTermItemTitleKey: "计算机文化基础（暂无资源）",
        kTermItemClassKey: "",
      },
      {
        kTermItemTitleKey: "马克思主义哲学原理（暂无资源）",
        kTermItemClassKey: "",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: _itemArray.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     Map itemDic = this._itemArray[index];
    //     return ListTile(
    //       title: Text(itemDic[kTermItemTitleKey], style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 14.0
    //       ),),
    //       trailing: Icon(Icons.arrow_forward_ios),
    //     );
    //   },
    // );

    return ListView(
      children: ListTile.divideTiles(
        context: context,
        color: kSeparatorColor,
        tiles: _itemArray.map((Map itemDic) {
          return ListTile(
            title: Text(itemDic[kTermItemTitleKey], style: TextStyle(
              color: kTitleFontColor,
              fontSize: kTitleFontSize
            ),),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        }).toList(),
      ).toList(),
    );
  }
}
