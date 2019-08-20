import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum FQPlayerWidgetSourceType { asset, network }

class FQPlayerWidget extends StatefulWidget {
  final String urlString;
  final FQPlayerWidgetSourceType sourceType;

  FQPlayerWidget.network({this.urlString}) : this.sourceType = FQPlayerWidgetSourceType.network;
  FQPlayerWidget.asset({this.urlString}) : this.sourceType = FQPlayerWidgetSourceType.asset;

  @override
  State<StatefulWidget> createState() => _FQPlayerWidgetState();
}

class _FQPlayerWidgetState extends State<FQPlayerWidget> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  // String testUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  void initState() {
    super.initState();
    switch (this.widget.sourceType) {
      case FQPlayerWidgetSourceType.network:
        _controller = VideoPlayerController.network(this.widget.urlString);
        break;
      case FQPlayerWidgetSourceType.asset:
        _controller = VideoPlayerController.asset(this.widget.urlString);
        break;
    }

    _controller
      ..addListener(() {
        // 播放状态
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // 在初始化完成后必须更新界面
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: _controller.value.initialized
            // 加载成功
            ? new AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : new Container(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed:
            _controller.value.isPlaying ? _controller.pause : _controller.play,
        child: new Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
