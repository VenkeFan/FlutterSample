import 'package:flutter/material.dart';
import 'package:flutter_like/business/timeline/viewmodel/timelineviewmodel.dart';

class TimelineWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TimelineWidget",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimelineHomePage(),
    );
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

  Widget _buildItem(BuildContext context, int index) {
    return ListTile(
      title: Text(this.displayList[index][kTimelineContentKey]),
    );
  }
}