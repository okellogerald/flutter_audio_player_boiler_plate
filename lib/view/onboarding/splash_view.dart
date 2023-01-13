import 'dart:async';
import 'package:euda_app/const/const.dart';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:euda_app/router/app_pages.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/audio_state_controller.dart';
import '../../provider/meditation_provider.dart';

import 'dart:convert';

import '../my_toolkit/widgets/meditation/audio_foreground_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String getBrandImage;

  @override
  void initState() {
    super.initState();
    _initForegroundPlayer();
    Timer(
      const Duration(seconds: 1),
      () async {
        Get.offAllNamed(Routes.MEDITATION);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/euda_splash.gif"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  _initForegroundPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    final audioManager = Get.find<AudioManager>();

    await AudioService.init(
      builder: () => ForegroundPlayer(
        audioSession: session,
        audioManager: audioManager,
      ),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.euda.euda_app',
        androidNotificationChannelName: 'Euda',
        androidNotificationIcon: 'mipmap/launcher_icon',
      ),
    );
  }
}
