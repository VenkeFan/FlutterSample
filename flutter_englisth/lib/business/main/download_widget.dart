import 'package:flutter/material.dart';

class FQDownloadWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FQDownloadWidgetState();
}

class _FQDownloadWidgetState extends State<FQDownloadWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下载管理"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
        ),
      )
    );
  }
}