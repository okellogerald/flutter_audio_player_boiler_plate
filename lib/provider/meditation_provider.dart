import 'package:euda_app/dto/meditation_dto.dart';
import 'package:euda_app/service/plugin_service.dart';
import 'package:flutter/material.dart';

class MeditationProvider extends ChangeNotifier {
  List<dynamic> meditations = [];
  bool loaded = true;
  String activeCategory = "All";
  List<String> categories = [];
  String searchKeyword = "";

  fetch() async {
    List<dynamic> values = [
      {
        "pk": "",
        "sk": "",
        "metaData": {
          "category": "Soundscapes",
          "author": "Euda",
          "title": "Soaring Higher",
          "image":
              "https://euda-resources.s3.ap-southeast-2.amazonaws.com/meditations/soundscapes/30+Soaring+Higher.png",
          "video":
              "https://euda-resources.s3.ap-southeast-2.amazonaws.com/meditations/soundscapes/30+-+Soaring+Higher.wav",
          "duration": "6 mins 48 secs"
        }
      },
      {
        "pk": "",
        "sk": "",
        "metaData": {
          "category": "Soundscapes",
          "author": "Euda",
          "title": "Poem",
          "image":
              "https://euda-resources.s3.ap-southeast-2.amazonaws.com/meditations/soundscapes/29+Poem.png",
          "video":
              "https://euda-resources.s3.ap-southeast-2.amazonaws.com/meditations/soundscapes/29+-+Poem.wav",
          "duration": "7 mins 40 secs"
        }
      },
    ];
    var _itemList = [];

    print('hello');
    // final pluginData = await PluginService().fetch('MEDITATIONS');
    for (int i = 0; i < values.length; i++) {
      Map<String, dynamic> map = values[i];

      _itemList.add(MeditationDTO.fromJson(map));
    }

    print(_itemList);
    meditations = _itemList;
    activeCategory = "All";
    //ADD CATEGORY
    List<String> temp = [];
    // temp.add('All');
    for (var el in meditations) {
      temp.add(el.metaData.category);
    }
    this.categories = temp.toSet().toList();
    this.categories.sort((a, b) => a.toString().compareTo(b.toString()));
    this.categories.insert(0, "All");

    loaded = true;

    notifyListeners();
  }

  updateDisplay(String query) async {
    searchKeyword = query;
    final userQuery = query.toLowerCase();
    for (var item in this.meditations) {
      final titleLower = item.metaData.title.toLowerCase();

      if (titleLower.contains(userQuery)) {
        item.metaData.show = true;
      } else {
        item.metaData.show = false;
      }
    }

    notifyListeners();
  }

  filterByCategory(String categoryName) async {
    this.activeCategory = categoryName;

    if (categoryName == 'All') {
      for (var item in this.meditations) {
        item.metaData.show = true;
      }
    } else {
      for (var item in this.meditations) {
        final titleLower = item.metaData.category;

        if (titleLower == categoryName) {
          item.metaData.show = true;
        } else {
          item.metaData.show = false;
        }
      }
    }

    notifyListeners();
  }
}
