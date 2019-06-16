import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_like/business/timeline/viewmodel/timelineviewmodel.dart';
import 'package:flutter_like/business/timeline/model/timelinepropertykeys.dart';

class TimelineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimelineHomePage();
  }
}

class TimelineHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimelineHomePageState();
}

class TimelineHomePageState extends State<TimelineHomePage> {
  List<dynamic> displayList = [];

  @override
  void initState() {
    super.initState();

    TimelineViewModel viewModel = TimelineViewModel();

    viewModel.fetchDiscovery((List<dynamic> itemList, String errorInfo) {
      setState(() {
        if (errorInfo == null) {
          this.displayList.addAll(itemList);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discovery"),
      ),
      body: ListView.builder(
        itemCount: this.displayList.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  @pragma("Private")
  Widget _buildItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildProfile(context, index),
          _buildText(context, index),
          _buildPictures(context, this.displayList[index]),
          _buildRetweet(context, index),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(this.displayList[index]
                [kTimelinePropertyKeyUser][kUserPropertyKeyAvatarProfile]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: Text(this.displayList[index]
                        [kTimelinePropertyKeyUser][kUserPropertyKeyName]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2.0),
                    color: Colors.yellow,
                    child: Text(
                      this.displayList[index][kTimelinePropertyKeySource],
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.cyan,
      )),
      padding: const EdgeInsets.all(6.0),
      alignment: AlignmentDirectional.topStart,
      child: Text(this.displayList[index][kTimelinePropertyKeyText]),
    );
  }

  Widget _buildRetweet(BuildContext context, int index) {
    Map<String, dynamic> retweetStatuses =
        this.displayList[index][kTimelinePropertyKeyRetweetStatus];
    if (retweetStatuses == null) {
      return Container(
        width: 0.0,
        height: 0.0,
        color: Colors.pink,
      );
    }

    String userName =
        retweetStatuses[kTimelinePropertyKeyUser][kUserPropertyKeyName];
    String text = retweetStatuses[kTimelinePropertyKeyText];
    // print("---------> $retweetContent \n");

    final contentWidget = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green
        )
      ),
      alignment: AlignmentDirectional.topStart,
      margin: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
          text: userName + ": ",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        TextSpan(
          text: text,
          style: TextStyle(color: Colors.black),
        )
      ])),
    );

    return Column(
      children: <Widget>[
        contentWidget,
        _buildPictures(context, retweetStatuses),
      ],
    );
  }

  Widget _buildPictures(BuildContext context, Map<String, dynamic> status) {
    List picIds = status[kTimelinePropertyPicIds];
    Map<String, dynamic> picInfoDic = status[kTimelinePropertyKeyPicInfos];

    if (picIds.isEmpty) {
      return Container(
        width: 0.0,
        height: 0.0,
        color: Colors.pink,
      ); // 没有图片时返回一个高度为0的widget，因为children中的widget不能为null
    }

    List<Map<String, dynamic>> pictures = List();
    for (var picId in picIds) {
      final info = picInfoDic[picId];
      if (info != null) {
        pictures.add(info);
      }
    }

    var numberInRow = 3; // column
    if (pictures.length == 4) {
      numberInRow = 2;
    }

    final itemWidth = 120.0, itemHeight = 120.0;
    final padding = 6.0;

    List<Widget> picWidgets = List();
    for (var i = 0; i < pictures.length; i++) {
      var x = (i % numberInRow) * (itemWidth + padding);
      var y = (i / numberInRow).floor() * (itemHeight + padding);

      Container container = Container(
        width: itemWidth,
        height: itemHeight,
        margin: EdgeInsets.only(left: x, top: y),
        child: Image.network(
          pictures[i][kPicturePropertyKeyMetadataBMiddle]
              [kPictureMetadataKeyUrl],
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      );

      picWidgets.add(container);
    }

    Container container = Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.purple,
      )),
      alignment: AlignmentDirectional.topStart,
      margin: const EdgeInsets.all(6.0),
      child: Stack(
        children: picWidgets,
      ),
    );

    return container;
  }
}
