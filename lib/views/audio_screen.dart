import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../controllers/audio_content.dart';
import '../controllers/audio_state_controller.dart';
import '../data/audios.dart';

class AudioScreen extends StatefulWidget {
  final Audio audio;

  const AudioScreen(this.audio, {Key? key}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  AudioManager get controller => Get.find<AudioManager>();

  void play() {
    final content = AudioContent(
      title: widget.audio.title,
      imageURL: widget.audio.imageUrl,
      audioUrl: widget.audio.audioUrl,
      id: const Uuid().v4(),
    );
    controller.play(content);
  }

  @override
  void initState() {
    super.initState();
    play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(.0),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close_rounded,
              size: 30,
              color: Colors.white,
            ),
          )),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              widget.audio.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(height: 135, child: buildControls()),
            const SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  slider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: AudioPositionDurationStreamBuilder(
                        builder: (position, duration) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTime(position),
                              buildTime(duration),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTime(Duration value) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        value.toString().split('.').first,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget slider() {
    return AudioPositionDurationStreamBuilder(
      builder: (position, duration) {
        final value = position.inMilliseconds.toDouble();
        final max = duration.inMilliseconds.toDouble();

        return Slider(
          activeColor: Colors.green,
          inactiveColor: Colors.grey,
          value: value.isNegative ? 0 : value,
          min: 0.0,
          max: max < value ? value + 1 : max,
          onChanged: (value) {
            controller.changePosition(Duration(milliseconds: value.toInt()));
          },
        );
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
            color: Colors.green,
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
                        ? const Icon(Icons.play_arrow,
                            size: 50, color: Colors.white)
                        : state.isPlaying
                            ? const Icon(Icons.pause,
                                size: 50, color: Colors.white)
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
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

  Widget buildControls() {
    return Container(
      color: Colors.transparent,
      child: Row(
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
        ],
      ),
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: const Icon(
        Icons.replay_10_rounded,
        color: Colors.white,
        size: 30,
      ),
      onPressed: controller.rewind,
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: const Icon(
        Icons.forward_10_rounded,
        color: Colors.white,
        size: 30,
      ),
      onPressed: controller.fastForward,
    );
  }
}

class AudioPositionDurationStreamBuilder extends StatelessWidget {
  final Widget Function(Duration position, Duration duration) builder;
  const AudioPositionDurationStreamBuilder({required this.builder, Key? key})
      : super(key: key);

  AudioManager get controller => Get.find<AudioManager>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: controller.positionStream,
        builder: (context, snapshot) {
          final position = snapshot.data ?? Duration.zero;

          return StreamBuilder<AudioContent>(
              stream: controller.contentStream,
              builder: (context, snapshot) {
                final duration = snapshot.data?.duration ?? Duration.zero;

                return builder(position, duration);
              });
        });
  }
}
