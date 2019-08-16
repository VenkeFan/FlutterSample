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
  }

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
              print('-------> $index');
              // listViewArray[index].display();
            },
          ),
        ),
        // body: Image(
        //   image: AssetImage('lib/images/nav_kefu.png'),
        // ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            LGMatchListView listView = LGMatchListView(listType: choice.type,);
            listViewArray.add(listView);
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
