class Audio {
  final String audioUrl, title, imageUrl;
  const Audio({
    required this.audioUrl,
    required this.title,
    required this.imageUrl,
  });
}

const audios = [
  Audio(
    audioUrl:
        "https://file-examples.com/storage/fea8fc38fd63bc5c39cf20b/2017/11/file_example_WAV_5MG.wav",
    title: "Cool Song 1",
    imageUrl:
        "https://images.pexels.com/photos/2911521/pexels-photo-2911521.jpeg?auto=compress&cs=tinysrgb&w=800",
  ),
  Audio(
    audioUrl:
        "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba-online-audio-converter.com_-1.wav",
    title: "Cool Song 2",
    imageUrl:
        "https://images.pexels.com/photos/1327405/pexels-photo-1327405.jpeg?auto=compress&cs=tinysrgb&w=800",
  ),
];
