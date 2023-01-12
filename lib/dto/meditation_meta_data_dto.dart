class MeditationMetaDataDTO {
  String link;
  String imgLink;
  String title;
  String description;
  String author;
  String subHeader;
  String duration;
  String category;
  bool show;

  MeditationMetaDataDTO(
      {required this.description,
      required this.link,
      required this.imgLink,
      required this.title,
      required this.author,
      required this.subHeader,
      required this.show,
      required this.duration,
      required this.category});

  factory MeditationMetaDataDTO.fromJson(Map<String, dynamic> json) {
    return MeditationMetaDataDTO(
        link: json['video'],
        imgLink: json['image'],
        title: json['title'],
        description: json['title'],
        author: json['author'],
        subHeader: json['author'],
        duration: json['duration'] ?? '',
        category: json['category'] ?? '',
        show: true);
  }
}
