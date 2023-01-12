import 'package:audioplayers/audioplayers.dart';
import 'package:euda_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyToolKitAudioPlayer extends StatefulWidget {
  AudioPlayer advancedPlayer;
  String path;
  String title;
  String img;
  MyToolKitAudioPlayer(
      {Key? key,
      required this.advancedPlayer,
      required this.path,
      required this.title,
      required this.img})
      : super(key: key);

  @override
  _MyToolKitAudioPlayerState createState() => _MyToolKitAudioPlayerState();
}

class _MyToolKitAudioPlayerState extends State<MyToolKitAudioPlayer> {
  late String videoPath;
  Duration _duration = new Duration();
  Duration _position = new Duration();

  bool isPlaying = false;
  bool isPaused = false;
  bool isStopped = false;
  bool isRepeat = false;
  bool _isLoadedd = false;

  Color color = Colors.black;
  Color repeatBtn = Colors.black;

  List<IconData> icons = [
    Icons.play_arrow,
    Icons.pause,
    Icons.stop,
  ];

  @override
  void initState() {
    videoPath = widget.path;
    super.initState();

    this.widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
        _isLoadedd = true;
      });
    });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);

        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });

    this.widget.advancedPlayer.setUrl(videoPath);

    this.widget.advancedPlayer.notificationService.startHeadlessService();
    this.widget.advancedPlayer.notificationService.setNotification(
        title: widget.title,
        artist: 'Euda',
        albumTitle: 'Meditation',
        imageUrl: widget.img,
        forwardSkipInterval: const Duration(seconds: 30),
        backwardSkipInterval: const Duration(seconds: 30),
        duration: _duration,
        elapsedTime: Duration(seconds: 0));
  }

  Widget slider() {
    return Slider(
      activeColor: greenBackground,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble() + 1.0,
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int value) {
    Duration newDuration = Duration(seconds: value);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget btnSlow() {
    return IconButton(
      icon: Image.asset('assets/icons/meditation/Back15.png'),
      onPressed: () {
        var changedValue = _position.inSeconds.toInt() - 15;

        setState(() {
          if (changedValue < 0 || changedValue == 0) {
            changeToSecond(0);
          } else {
            changeToSecond(_position.inSeconds.toInt() - 15);
          }
        });
        // this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: Image.asset('assets/icons/meditation/Next15.png'),
      onPressed: () {
        var changedValue = _position.inSeconds.toInt() + 15;

        setState(() {
          if (changedValue > _duration.inSeconds.toDouble() ||
              changedValue == _duration.inSeconds.toDouble()) {
            // changeToSecond(0);

          } else {
            changeToSecond(_position.inSeconds.toInt() + 15);
          }
        });

        // this.widget.advancedPlayer.setPlaybackRate(1.5);
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
          child: Container(
              child: IconButton(
            icon: _isLoadedd == true
                ? isPlaying == false
                    ? SvgPicture.asset('assets/icons/meditation/Play.svg',
                        width: 30, height: 30, color: Colors.white)
                    : SvgPicture.asset('assets/icons/meditation/Pause.svg',
                        width: 30, height: 30)
                : CircularProgressIndicator(
                    color: Colors.white,
                  ),
            onPressed: () {
              if (isPlaying == false) {
                if (_position.inSeconds == 0) {
                  this.widget.advancedPlayer.play(videoPath);
                } else {
                  this.widget.advancedPlayer.resume();
                }
                setState(() {
                  isPlaying = true;
                });
              } else if (isPlaying == true) {
                this.widget.advancedPlayer.pause();
                setState(() {
                  isPlaying = false;
                });
              }
            },
          )),
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
    return Container(
      child: Column(
        children: [
          Container(height: 135, child: loadAsset()),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: slider()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _position.toString().split('.').first,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              color: Color.fromRGBO(255, 255, 255, 0.69),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            _duration.toString().split('.').first,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              color: Color.fromRGBO(255, 255, 255, 0.69),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
