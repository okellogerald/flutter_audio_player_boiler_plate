/// created specifically for providing values to the foreground player.
class AudioContent {
  final String title, audioUrl, id;
  final Duration duration;
  final String? imageURL;
  final bool playing;

  const AudioContent({
    this.title = '',
    this.audioUrl = '',
    this.id = '',
    this.duration = Duration.zero,
    this.imageURL,
    this.playing = false,
  });

  AudioContent copyWith({
    Duration? duration,
    bool? playing,
    String? imageURL,
    String? audioUrl,
  }) {
    return AudioContent(
      title: title,
      imageURL: imageURL ?? this.imageURL,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      playing: playing ?? this.playing,
      id: id,
    );
  }

  bool get hasDuration => duration != Duration.zero;

  @override
  String toString() {
    return 'title: $title, duration: $duration, image: $imageURL, audioUrl: $audioUrl';
  }
}