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
  Future<void> stop() => audioManager.stop();

  final MediaControl _pause = const MediaControl(
      label: 'Pause', androidIcon: 'drawable/pause', action: MediaAction.pause);

  final MediaControl _play = const MediaControl(
      label: 'Play', androidIcon: 'drawable/play', action: MediaAction.play);

  final MediaControl _stop = const MediaControl(
      label: 'Stop', androidIcon: 'drawable/stop', action: MediaAction.stop);

  void _handleAudioContentStream(AudioContent audioContent) {
    mediaItem.add(MediaItem(
      id: const Uuid().v4(),
      title: audioContent.title,
      duration: audioContent.duration,
      artUri: Uri.parse(audioContent.imageURL ?? demoImage),
    ));

    final _playbackState = PlaybackState(
      controls: [audioContent.playing ? _pause : _play, _stop],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0],
      processingState: audioContent.hasDuration
          ? AudioProcessingState.ready
          : AudioProcessingState.idle,
      playing: audioContent.playing,
      updatePosition: audioContent.position,
      speed: 1.0,
      queueIndex: 0,
    );

    playbackState.add(_playbackState);
  }

  void _handleAudioPositionStream(Duration position) {
    playbackState.add(playbackState.value.copyWith(updatePosition: position));
  }

  void _handleAudioStateStream(AudioState audioState) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: audioState.isIdle
            ? [_play]
            : [audioState.isPlaying ? _pause : _play, _stop],
        processingState: audioState.isLoading
            ? AudioProcessingState.loading
            : audioState.isIdle
                ? AudioProcessingState.idle
                : audioState.isError
                    ? AudioProcessingState.error
                    : AudioProcessingState.ready,
      ),
    );
  }

  void _handleBecomingNoisyStream(_) => audioManager.handleBecomingNoisy();

  void _handleAudioInterruptions(AudioInterruptionEvent event) =>
      audioManager.handleAudioInterruptions(event);
}

const demoImage =
    'https://images.pexels.com/photos/2325446/pexels-photo-2325446.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
