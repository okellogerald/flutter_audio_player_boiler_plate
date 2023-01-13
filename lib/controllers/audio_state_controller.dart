import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:euda_app/controllers/audio_content.dart';
import 'package:get/get.dart';

const sampleImage =
    "https://images.pexels.com/photos/2911521/pexels-photo-2911521.jpeg?auto=compress&cs=tinysrgb&w=800";
const sampleAudio =
    "https://file-examples.com/storage/fea8fc38fd63bc5c39cf20b/2017/11/file_example_WAV_10MG.wav";

enum AudioState { idle, loading, paused, playing, completed, error }

enum AudioAction { play, pause, resume, stop, seekPosition }

class AudioManager extends GetxController {
  static final _player = AudioPlayer();

  /// keeps track of the current state of the player
  var _state = AudioState.idle;

  /// keeps track of the last know position of the player
  var _position = Duration.zero;
  var _audioContent = const AudioContent();

  /// helps to know what function to call when an operation had an error;
  var _action = AudioAction.play;

  /// makes sure setUpListeners private method isn't called more than once from the
  /// play method.
  bool _isAlreadyInitiated = false;

  /// helps to know whether to contiunue the audio being played after the interruption
  /// event is finished.
  bool _shouldUpdateStatusOnInterruptionEnd = false;

  final _contentStreamController = StreamController<AudioContent>.broadcast();
  final _stateStreamController = StreamController<AudioState>.broadcast();

  Stream<AudioContent> get contentStream => _contentStreamController.stream;
  Stream<AudioState> get stateStream => _stateStreamController.stream;
  Stream<Duration> get positionStream => _player.onAudioPositionChanged;
  AudioState get state => _state;
  AudioContent get currentContent => _audioContent;

  Future<void> play(AudioContent content) async {
    try {
      if (_state.isPlaying) return await pause();
      _setUpListeners();
      final duration = await _player.play(sampleAudio);
      if (duration == 0) throw "An error happened";
      updateContent(
          content.copyWith(audioUrl: sampleAudio, imageURL: sampleImage));
    } catch (_) {
      _handleError(AudioAction.play);
    }
  }

  Future<void> replay() async {
    await _player.seek(Duration.zero);
    _player.resume();
  }

  Future<void> playFromForeground() async {
    if (_audioContent.audioUrl.isEmpty) return;
    if (_state.isIdle) await play(_audioContent);
    if (_state.isPaused) await resume();
    if (_state.isError) {
      await play(_audioContent);
      await changePosition(_position);
    }
  }

  Future<void> pause() async {
    try {
      updateState(AudioState.paused);
      await _player.pause();
    } catch (_) {
      _handleError(AudioAction.pause);
    }
  }

  Future<void> resume() async {
    try {
      updateState(AudioState.playing);
      await _player.resume();
    } catch (_) {
      _handleError(AudioAction.resume);
    }
  }

  Future<void> stop() async {
    // the video play method will start by stopping any audio currently playing. There won't be
    // a need to if the video _state is idle.
    if (_state.isIdle) return;
    try {
      _position = Duration.zero;
      await _player.stop();
    } catch (_) {
      _handleError(AudioAction.stop);
    }
  }

  Future<void> changePosition(Duration position) async {
    try {
      await _player.seek(position);
    } catch (_) {
      _handleError(AudioAction.seekPosition);
    }
  }

  rewind() => changePosition(Duration(seconds: _position.inSeconds - 15));

  fastForward() => changePosition(Duration(seconds: _position.inSeconds + 15));

  Future<void> playFromError() async {
    updateState(AudioState.loading);
    if (_action == AudioAction.play) await play(_audioContent);
    if (_action == AudioAction.pause) await pause();
    if (_action == AudioAction.resume) await resume();
    if (_action == AudioAction.stop) await stop();
    if (_action == AudioAction.seekPosition) await changePosition(_position);
  }

  void _setUpListeners() {
    if (_isAlreadyInitiated) return;
    _player.onAudioPositionChanged.listen((position) {
      if (!state.isPlaying && _player.state == PlayerState.PLAYING) {
        updateState(AudioState.playing, false);
      }
      print(position);
      updateContent(_audioContent.copyWith(
          position: position, playing: _state.isPlaying));
    });
    _player.onDurationChanged.listen((duration) {
      updateContent(_audioContent.copyWith(duration: duration));
    });
    _player.onPlayerStateChanged.listen((playerState) {
      print(playerState);
      if (playerState.isPlaying && _audioContent.duration.inMilliseconds == 0) {
        return;
      }
      if (playerState.isIdle) updateState(AudioState.idle);
      if (playerState.isPlaying) updateState(AudioState.playing);
      if (playerState.isPaused) updateState(AudioState.paused);
    });

    _player.onPlayerCompletion.listen((_) {
      print("player is completed");
      updateState(AudioState.completed);
    });

    _player.onSeekComplete.listen((_) {
      print("seek is complete");
    });

    _isAlreadyInitiated = true;
  }

  void _handleError(AudioAction action) {
    _action = action;
    updateState(AudioState.error);
  }

  //-> audio interruptions event handlers
  /// ex. when earphones are detached
  void handleBecomingNoisy() async {
    if (_state.isPaused) return;
    await pause();
  }

  /// ex. when a call has been made or received when the audio was playing
  void handleAudioInterruptions(AudioInterruptionEvent event) async {
    final isPlaying = _state.isPlaying;

    if (event.begin) {
      switch (event.type) {
        case AudioInterruptionType.duck:
        //when another app uses the audio source temporarily e.g phone calls, instagram videos..
        //then i should pause and continue when it's done.
        case AudioInterruptionType.pause:
        //when another app may the audio source and we don't know when it will
        //release the resource, hence we should pause and do nothing when it's done.
        case AudioInterruptionType.unknown:
          if (isPlaying) {
            await pause();
            _shouldUpdateStatusOnInterruptionEnd = true;
          }
          if (!isPlaying) _shouldUpdateStatusOnInterruptionEnd = false;
          break;
      }
    } else {
      switch (event.type) {
        case AudioInterruptionType.duck:
        case AudioInterruptionType.pause:
          if (_shouldUpdateStatusOnInterruptionEnd) await resume();
          break;
        case AudioInterruptionType.unknown:
          break;
      }
    }
  }

  updateState(AudioState newState, [bool shouldUpdateContent = true]) {
    _state = newState;
    _stateStreamController.add(newState);
    if (shouldUpdateContent) {
      print("updating new state: $newState");
      updateContent(_audioContent.copyWith(playing: newState.isPlaying));
    }
    update();
  }

  updateContent(AudioContent newContent) {
    _audioContent = newContent;
    _contentStreamController.add(newContent);
  }
}

// -> extensions
extension AudioStateExtension on AudioState {
  bool get isLoading => this == AudioState.loading;
  bool get isPaused => this == AudioState.paused;
  bool get isPlaying => this == AudioState.playing;
  bool get isIdle => this == AudioState.idle;
  bool get isError => this == AudioState.error;
  bool get isCompleted => this == AudioState.completed;
}

extension PlayerStateExtension on PlayerState {
  bool get isPlaying => this == PlayerState.PLAYING;
  bool get isPaused => this == PlayerState.PAUSED;
  bool get isIdle =>
      this == PlayerState.COMPLETED || this == PlayerState.STOPPED;
}
