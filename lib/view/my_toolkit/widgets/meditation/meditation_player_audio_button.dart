import 'package:euda_app/const/const.dart';
import 'package:euda_app/controllers/audio_content.dart';
import 'package:euda_app/controllers/audio_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyToolKitAudioPlayer extends StatefulWidget {
  String path;
  String title;
  String img;
  MyToolKitAudioPlayer(
      {Key? key, required this.path, required this.title, required this.img})
      : super(key: key);

  @override
  _MyToolKitAudioPlayerState createState() => _MyToolKitAudioPlayerState();
}

class _MyToolKitAudioPlayerState extends State<MyToolKitAudioPlayer> {
  late String videoPath;

  Color color = Colors.black;
  Color repeatBtn = Colors.black;

  List<IconData> icons = [
    Icons.play_arrow,
    Icons.pause,
    Icons.stop,
  ];

  AudioManager get controller => Get.find<AudioManager>();

  void play() {
    final content = AudioContent(
      title: widget.title,
      imageURL: widget.img,
      audioUrl: widget.path,
    );
    controller.play(content);
  }

  @override
  void initState() {
    super.initState();
    play();
  }

  Widget slider() {
    return StreamBuilder<AudioContent>(
      stream: controller.contentStream,
      builder: (context, snapshot) {
        final content = snapshot.data ?? const AudioContent();
        final min = content.position.inMilliseconds.toDouble();
        final max = content.duration.inMilliseconds.toDouble();
        return Slider(
          activeColor: greenBackground,
          inactiveColor: Colors.grey,
          value: min,
          min: 0.0,
          max: max < min ? min : max,
          onChanged: updatePosition,
        );
      },
    );
  }

  void updatePosition(num milliseconds) {
    final position = Duration(milliseconds: milliseconds.toInt());
    controller.changePosition(position);
  }

  Widget btnSlow() {
    return IconButton(
      icon: Image.asset('assets/icons/meditation/Back15.png'),
      onPressed: () {
        final position = controller.currentContent.position;
        updatePosition(position.inMilliseconds - 15000);
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: Image.asset('assets/icons/meditation/Next15.png'),
      onPressed: () {
        final position = controller.currentContent.position;
        updatePosition(position.inMilliseconds + 15000);
      },
    );
  }

  Widget btnStart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: greenBackground,
            borderRadius: BorderRadius.circular(100),
          ),
          child: GetBuilder<AudioManager>(
            builder: (controller) {
              final state = controller.state;

              return IconButton(
                icon: state.isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : state.isPaused || state.isCompleted
                        ? SvgPicture.asset('assets/icons/meditation/Play.svg',
                            width: 30, height: 30, color: Colors.white)
                        : state.isPlaying
                            ? SvgPicture.asset(
                                'assets/icons/meditation/Pause.svg',
                                width: 30,
                                height: 30)
                            : const CircularProgressIndicator(
                                color: Colors.white),
                onPressed: () {
                  if (state.isIdle) play();
                  if (state.isPlaying) controller.pause();
                  if (state.isPaused) controller.resume();
                  if (state.isCompleted) controller.replay();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget loadAsset() {
    return Container(
      color: Colors.transparent,
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: btnSlow(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: btnStart(),
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Expanded(
              flex: 1,
              child: btnFast(),
            ),

            // btnLoop()
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 135, child: loadAsset()),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(child: slider()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: StreamBuilder<AudioContent>(
                      stream: controller.contentStream,
                      builder: (context, snapshot) {
                        final content = snapshot.data ?? const AudioContent();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                content.position.toString().split('.').first,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Manrope',
                                  color: Color.fromRGBO(255, 255, 255, 0.69),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                content.duration.toString().split('.').first,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Manrope',
                                  color: Color.fromRGBO(255, 255, 255, 0.69),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
