import 'package:euda_app/controllers/audio_state_controller.dart';
import 'package:euda_app/provider/meditation_provider.dart';
import 'package:euda_app/view/my_toolkit/widgets/meditation/meditation_player_audio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyToolKitPlayer extends StatefulWidget {
  const MyToolKitPlayer({Key? key}) : super(key: key);

  @override
  _MyToolKitPlayerState createState() => _MyToolKitPlayerState();
}

class _MyToolKitPlayerState extends State<MyToolKitPlayer> {
  late String title;
  late String imgLink;
  late String videoLink;

  @override
  void initState() {
    super.initState();
    title = Get.arguments['title'];
    imgLink = Get.arguments['imgLink'];
    videoLink = Get.arguments['videoLink'];
  }

  @override
  Widget build(BuildContext context) {
    final meditationProvider = Provider.of<MeditationProvider>(context);
    var meditationList = meditationProvider.meditations;

    if (meditationList.isNotEmpty && meditationProvider.loaded == true) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.clear_outlined,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                ),
                onPressed: () {
                  Get.find<AudioManager>().stop();
                  Get.back();
                },
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken),
                  //TODO: edit this back to using imgLink
              image: NetworkImage("https://images.pexels.com/photos/1327405/pexels-photo-1327405.jpeg?auto=compress&cs=tinysrgb&w=800"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'With Euda',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                                color: Colors.transparent,
                                child: MyToolKitAudioPlayer(
                                    path: videoLink,
                                    title: title,
                                    img: imgLink)),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.transparent,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) /* add child content here */,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Meditations'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
