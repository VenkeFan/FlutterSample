import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englisth/business/general_english/route/fq_english_route.dart';
import 'package:flutter_englisth/utility/fq_marco.dart';

const String kTermTitleKey = "kTermTitleKey";
const String kTermCourseKey = "kTermCourseKey";

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
  void dispose() {
    
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _itemArray = [
      {
        kTermTitleKey: "第一学期",
        kTermCourseKey: <Map>[
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
        ]
      },
      {
      kTermTitleKey: "第二学期",
      kTermCourseKey: <Map>[
          {
            kTermItemTitleKey: "通用英语2",
            kTermItemClassKey: "FQGeneralEnglishRoute",
          },
          {
            kTermItemTitleKey: "英语听说2",
            kTermItemClassKey: "FQLSEnglisthRoute",
          }
        ]
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _itemArray.length,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  // backgroundColor: Colors.red,
                  title: Text("课程"),
                  pinned: true,
                  expandedHeight: 0, // 150,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _itemArray.map((Map dic) {
                      return Tab(
                        text: dic[kTermTitleKey],
                      );
                    }).toList(),
                    onTap: (int index) {
                      print('----------> $index');
                    },
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: _itemArray.map((Map dic) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(dic[kTermTitleKey]),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverFixedExtentList(
                            itemExtent: 48.0,
                            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                              Map courseDic = dic[kTermCourseKey][index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                    String routeName = courseDic[kTermItemClassKey];
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
                                    courseDic[kTermItemTitleKey],
                                    style:
                                        TextStyle(color: kTitleFontColor, fontSize: kTitleFontSize),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                              );
                            }, childCount: dic[kTermCourseKey].length),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView(
  //     children: ListTile.divideTiles(
  //       context: context,
  //       color: kSeparatorColor,
  //       tiles: _itemArray.map((Map itemDic) {
          // return InkWell(
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          //       String routeName = itemDic[kTermItemClassKey];
          //       switch (routeName) {
          //         case "FQGeneralEnglishRoute":
          //           return FQGeneralEnglishRoute();
          //           break;
          //         default:
          //         return null;
          //         break;
          //       }
          //     }));
          //   },
          //   child: ListTile(
          //     title: Text(
          //       itemDic[kTermItemTitleKey],
          //       style:
          //           TextStyle(color: kTitleFontColor, fontSize: kTitleFontSize),
          //     ),
          //     trailing: Icon(Icons.arrow_forward_ios),
          //   ),
          // );
  //       }).toList(),
  //     ).toList(),
  //   );
  // }
}
