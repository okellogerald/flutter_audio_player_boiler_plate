/// created specifically for providing values to the foreground player.
class AudioContent {
  final String title, audioUrl;
  final Duration duration, position;
  final String? imageURL;
  final bool playing;

  const AudioContent({
    this.title = '',
    this.audioUrl = '',
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.imageURL,
    this.playing = false,
  });

  AudioContent copyWith({
    Duration? duration,
    Duration? position,
    bool? playing,
    String? imageURL,
    String? audioUrl,
  }) {
    return AudioContent(
      title: title,
      imageURL: imageURL ?? this.imageURL,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      playing: playing ?? this.playing,
    );
  }

  bool get hasDuration => duration != Duration.zero;

  @override
  String toString() {
    return 'title: $title, duration: $duration, image: $imageURL, audioUrl: $audioUrl';
  }
}
