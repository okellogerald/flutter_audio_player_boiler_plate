import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'basic_overlay_widget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final ChewieController chewieController;

  const VideoPlayerWidget({
    Key? key,
    required this.chewieController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => chewieController != null
      ? Chewie(
          controller: chewieController,
        )
      : Container(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

  // Widget buildVideo() => Stack(
  //       children: <Widget>[
  //         buildVideoPlayer(),
  //         Positioned.fill(
  //           child: BasicOverlayWidget(controller: controller),
  //         )
  //       ],
  //     );

  // Widget buildVideoPlayer() => AspectRatio(
  //       aspectRatio: controller.value.aspectRatio,
  //       // child: VideoPlayer(controller),
  //       child: VideoPlayer(controller),
  //     );
}
