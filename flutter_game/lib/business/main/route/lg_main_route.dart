import 'package:flutter/material.dart';
import '../../common_ui/lg_ui_config.dart';
import '../view/lg_matchlist_view.dart';
import '../model/lg_matchlist_keys.dart';

class LGMainRoute extends StatelessWidget {
  // static const List<Choice> choices = const <Choice>[
  //   const Choice(title: '赛前', type: LGMatchListType.prepare),
  //   const Choice(title: '今日', type: LGMatchListType.today),
  //   const Choice(title: '滚盘', type: LGMatchListType.rolling),
  //   const Choice(title: '已结束', type: LGMatchListType.finished),
  // ];

  List<Choice> choices;
  List<LGMatchListView> listViewArray;

  LGMainRoute() {
    choices = <Choice>[
      const Choice(title: '赛前', type: LGMatchListType.prepare, index: 0),
      const Choice(title: '今日', type: LGMatchListType.today, index: 1),
      const Choice(title: '滚盘', type: LGMatchListType.rolling, index: 2),
      const Choice(title: '已结束', type: LGMatchListType.finished, index: 3),
    ];

    listViewArray = List();
    for (var i = 0; i < choices.length; i++) {
      LGMatchListView view = LGMatchListView(listType: choices[i].type);
      listViewArray.add(view);
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: choices.length,
  //     child: NestedScrollView(
  //         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //           return <Widget>[
  //             SliverOverlapAbsorber(
  //               handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  //               child: SliverAppBar(
  //                 // backgroundColor: Colors.red,
  //                 title: Image.asset('lib/images/nav_title.png'),
  //                 pinned: true,
  //                 expandedHeight: 0, // 150,
  //                 forceElevated: innerBoxIsScrolled,
  //                 bottom: TabBar(
  //                   tabs: choices.map((Choice choice) {
  //                     return Tab(
  //                       text: choice.title,
  //                     );
  //                   }).toList(),
  //                   onTap: (int index) {
  //                     listViewArray[index].display();
  //                   },
  //                 ),
  //               ),
  //             )
  //           ];
  //         },
  //         body: TabBarView(
  //           children: choices.map((Choice choice) {
  //             return SafeArea(
  //               top: false,
  //               bottom: false,
  //               child: Builder(
  //                 builder: (BuildContext context) {
  //                   return CustomScrollView(
  //                     key: PageStorageKey<String>(choice.title),
  //                     slivers: <Widget>[
  //                       SliverOverlapInjector(
  //                         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  //                       ),
  //                       // SliverPadding(
  //                       //   padding: const EdgeInsets.all(8.0),
  //                       //   sliver: SliverFixedExtentList(
  //                       //     itemExtent: 166.0,
  //                       //     delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //                       //       return Card(
  //                       //         color: Colors.red,
  //                       //       );
  //                       //     }),
  //                       //   ),
  //                       // ),
  //                       SliverList(
  //                         delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //                             return Card(
  //                               child: Container(
  //                                 height: 166.0,
  //                               ),
  //                               color: Colors.red,
  //                             );
  //                           }),
  //                       ),
  //                     ],
  //                   );
                    
  //                   // LGMatchListView listView = LGMatchListView(listType: choice.type,);
  //                   // listViewArray.add(listView);
  //                   // if (choice.index == 0) {
  //                   //   listView.display();
  //                   // }
  //                   // return listView; 
  //                 },
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('lib/images/nav_title.png'),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: kMainOnTintColor,
          ),
          leading: IconButton(
            icon: ImageIcon(AssetImage('lib/images/nav_kefu.png')), //
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: ImageIcon(AssetImage('lib/images/nav_profile.png')),
              onPressed: () {},
            ),
            IconButton(
              icon: ImageIcon(AssetImage('lib/images/nav_rein.png')),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: kMainOnTintColor,
            tabs: choices.map((Choice choice) {
              return Tab(
                child: Text(
                  choice.title,
                  style: TextStyle(
                    color: kNameFontColor,
                    fontSize: kNameFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            onTap: (int index) {
              listViewArray[index].display();
            },
          ),
        ),
        // body: Image(
        //   image: AssetImage('lib/images/nav_kefu.png'),
        // ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            LGMatchListView listView = listViewArray[choice.index];
            if (choice.index == 0) {
              listView.display();
            }
            return listView;
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.type, this.index});
  final String title;
  final int type;
  final int index;
}
