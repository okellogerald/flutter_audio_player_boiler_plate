import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:uuid/uuid.dart';

import '../../../../controllers/audio_content.dart';
import '../../../../controllers/audio_state_controller.dart';

class ForegroundPlayer extends BaseAudioHandler with SeekHandler {
  final AudioManager audioManager;
  final AudioSession audioSession;

  ForegroundPlayer({required this.audioManager, required this.audioSession}) {
    audioManager.stateStream.listen(_handleAudioStateStream);
    audioManager.positionStream.listen(_handleAudioPositionStream);
    audioManager.contentStream.listen(_handleAudioContentStream);
    audioSession.becomingNoisyEventStream.listen(_handleBecomingNoisyStream);
    audioSession.interruptionEventStream.listen(_handleAudioInterruptions);
    print('initiated foreground player');
  }

  @override
  Future<void> play() => audioManager.playFromForeground();

  @override
  Future<void> pause() => audioManager.pause();

  @override
  Future<void> seek(Duration position) => audioManager.changePosition(position);

  @override
  Future<void> rewind() => audioManager.rewind();

  @override
  Future<void> fastForward() => audioManager.fastForward();

  @override
  Future<void> stop() => audioManager.stop();

  static const _pause = MediaControl(
    label: 'Pause',
    androidIcon: 'drawable/pause',
    action: MediaAction.pause,
  );

  static const _play = MediaControl(
    label: 'Play',
    androidIcon: 'drawable/play',
    action: MediaAction.play,
  );

  /* static const _stop = MediaControl(
    label: 'Stop',
    androidIcon: 'drawable/stop',
    action: MediaAction.stop,
  );*/

  static const _forward = MediaControl(
    label: 'Stop',
    androidIcon: 'drawable/_15_forward',
    action: MediaAction.fastForward,
  );

  static const _rewind = MediaControl(
    label: 'Stop',
    androidIcon: 'drawable/_15_back',
    action: MediaAction.rewind,
  );

  static final androidActionsWithPause = [
    _forward,
    _pause,
    _rewind,
  ];
  static final androidActionsWithPlay = [
    _forward,
    _play,
    _rewind,
  ];
  static const iOSControls = {
    MediaAction.seek,
    MediaAction.seekForward,
    MediaAction.seekBackward,
    MediaAction.fastForward,
    MediaAction.rewind,
    MediaAction.play,
    MediaAction.pause,
  };

  var _audioId = "";

  void _handleAudioContentStream(AudioContent audioContent) {
    if (_audioId == audioContent.id) {
      return;
    }

    mediaItem.add(
      MediaItem(
        id: audioContent.id,
        title: audioContent.title,
        duration: audioContent.duration,
        artUri: Uri.parse(audioContent.imageURL ?? demoImage),
      ),
    );

    final _playbackState = PlaybackState(
      controls: androidActionsWithPlay,
      systemActions: iOSControls,
      androidCompactActionIndices: [0, 1, 2],
      processingState: AudioProcessingState.idle,
      playing: false,
      speed: 1.0,
      queueIndex: 0,
    );

    playbackState.add(_playbackState);
    _audioId = audioContent.id;
  }

  void _handleAudioPositionStream(Duration position) {
    playbackState.add(playbackState.value.copyWith(updatePosition: position));
  }

  void _handleAudioStateStream(AudioState audioState) {
    print(audioState);
    playbackState.add(
      playbackState.value.copyWith(
        controls: audioState.isPlaying
            ? androidActionsWithPause
            : androidActionsWithPlay,
        processingState: audioState.isLoading
            ? AudioProcessingState.loading
            : audioState.isIdle
                ? AudioProcessingState.idle
                : audioState.isError
                    ? AudioProcessingState.error
                    : AudioProcessingState.ready,
        playing: audioState.isPlaying,
      ),
    );
  }

  void _handleBecomingNoisyStream(_) => audioManager.handleBecomingNoisy();

  void _handleAudioInterruptions(AudioInterruptionEvent event) =>
      audioManager.handleAudioInterruptions(event);
}

const demoImage =
    'https://images.pexels.com/photos/2325446/pexels-photo-2325446.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
