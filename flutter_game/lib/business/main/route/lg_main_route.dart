import 'package:flutter/material.dart';
import 'package:flutter_game/business/common_ui/lg_ui_config.dart';

class LGMainRoute extends StatelessWidget {
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
              print('-----> $index');
            },
          ),
        ),
        // body: Image(
        //   image: AssetImage('lib/images/nav_kefu.png'),
        // ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoiceCard(
                choice: choice,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '赛前'),
  const Choice(title: '今日'),
  const Choice(title: '滚盘'),
  const Choice(title: '已结束'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: Text(choice.title, style: textStyle),
      ),
    );
  }
}
