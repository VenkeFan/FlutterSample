import 'package:flutter/material.dart';
import 'package:flutter_englisth/business/general_english/route/fq_english_route.dart';
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
        kTermItemClassKey: "FQGeneralEnglishRoute",
      },
      {
        kTermItemTitleKey: "英语听说1",
        kTermItemClassKey: "FQLSEnglisthRoute",
      },
      {
        kTermItemTitleKey: "英语语音（暂无资源）",
        kTermItemClassKey: "",
      },
      {
        kTermItemTitleKey: "大学语文",
        kTermItemClassKey: "FQLanguageRoute",
      },
      {
        kTermItemTitleKey: "邓小平理论概论",
        kTermItemClassKey: "FQDenglunRoute",
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
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                String routeName = itemDic[kTermItemClassKey];
                switch (routeName) {
                  case "FQGeneralEnglishRoute":
                    return FQGeneralEnglishRoute();
                    break;
                  default:
                  return null;
                  break;
                }
              }));
            },
            child: ListTile(
              title: Text(
                itemDic[kTermItemTitleKey],
                style:
                    TextStyle(color: kTitleFontColor, fontSize: kTitleFontSize),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );

          // return ListTile(
          //   title: Text(itemDic[kTermItemTitleKey], style: TextStyle(
          //     color: kTitleFontColor,
          //     fontSize: kTitleFontSize
          //   ),),
          //   trailing: Icon(Icons.arrow_forward_ios),
          // );
        }).toList(),
      ).toList(),
    );
  }
}
