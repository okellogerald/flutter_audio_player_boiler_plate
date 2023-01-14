import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../data/audios.dart';
import 'audio_screen.dart';

class AudiosScreen extends StatelessWidget {
  const AudiosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: ListView.separated(
        itemCount: audios.length,
        padding: const EdgeInsets.only(top: 100),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (_, index) {
          final audio = audios[index];
          return GestureDetector(
            onTap: () {
              Get.to(AudioScreen(audio));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              height: 120,
              child: Row(
                children: [
                  Container(
                    height: 85,
                    width: 70,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(audio.imageUrl),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Text(
                    audio.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
