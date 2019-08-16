import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FQPlayerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FQPlayerWidgetState();
}

class _FQPlayerWidgetState extends State<FQPlayerWidget> {
    VideoPlayerController _controller;
    bool _isPlaying = false;
    String url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

    @override
    void initState() {
        super.initState();
        _controller = VideoPlayerController.network(this.url)
        // 播放状态
        ..addListener(() {
            final bool isPlaying = _controller.value.isPlaying;
            if (isPlaying != _isPlaying) {
                setState(() { _isPlaying = isPlaying; });
            }
        })
        // 在初始化完成后必须更新界面
        ..initialize().then((_) {
            setState(() {});
        });
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Video Demo',
            home: new Scaffold(
                body: new Center(
                child: _controller.value.initialized
                    // 加载成功
                    ? new AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                    ) : new Container(),
                ),
                floatingActionButton: new FloatingActionButton(
                    onPressed: _controller.value.isPlaying
                        ? _controller.pause
                        : _controller.play,
                    child: new Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                ),
            ),
        );
    }
}