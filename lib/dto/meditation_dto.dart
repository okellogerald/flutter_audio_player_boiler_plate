import 'meditation_meta_data_dto.dart';

class MeditationDTO {
  String pk;
  String sk;
  MeditationMetaDataDTO metaData;

  MeditationDTO({required this.pk, required this.sk, required this.metaData});

  factory MeditationDTO.fromJson(Map<String, dynamic> json) {
    return MeditationDTO(
      pk: json['pk'],
      sk: json['sk'],
      metaData: MeditationMetaDataDTO.fromJson(json['metaData']),
    );
  }
}
